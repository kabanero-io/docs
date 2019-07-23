#!/bin/bash

set -Eeox pipefail

### Configuration ###

# Kserving domain matches openshift_master_default_subdomain #
openshift_master_default_subdomain="${openshift_master_default_subdomain:-my.openshift.master.default.subdomain}"

### Operator Lifecycle Manager ###

release=0.10.1
url=https://github.com/operator-framework/operator-lifecycle-manager/releases/download/${release}
namespace=olm

oc apply -f ${url}/crds.yaml
oc apply -f ${url}/olm.yaml

# wait for deployments to be ready
oc rollout status -w deployment/olm-operator --namespace="${namespace}"
oc rollout status -w deployment/catalog-operator --namespace="${namespace}"

retries=50
until [[ $retries == 0 || $new_csv_phase == "Succeeded" ]]; do
    new_csv_phase=$(oc get csv -n "${namespace}" packageserver.v${release} -o jsonpath='{.status.phase}' 2>/dev/null || echo "Waiting for CSV to appear")
    if [[ $new_csv_phase != "$csv_phase" ]]; then
        csv_phase=$new_csv_phase
        echo "Package server phase: $csv_phase"
    fi
    sleep 1
    retries=$((retries - 1))
done

if [ $retries == 0 ]; then
    echo "CSV \"packageserver\" failed to reach phase succeeded"
    exit 1
fi

oc rollout status -w deployment/packageserver --namespace="${namespace}"

### Maistra ###

# Jaeger - Optional#
# oc new-project observability || true
# oc apply -n observability -f https://raw.githubusercontent.com/jaegertracing/jaeger-operator/v1.13.1/deploy/crds/jaegertracing_v1_jaeger_crd.yaml
# oc apply -n observability -f https://raw.githubusercontent.com/jaegertracing/jaeger-operator/v1.13.1/deploy/service_account.yaml
# oc apply -n observability -f https://raw.githubusercontent.com/jaegertracing/jaeger-operator/v1.13.1/deploy/role.yaml
# oc apply -n observability -f https://raw.githubusercontent.com/jaegertracing/jaeger-operator/v1.13.1/deploy/role_binding.yaml
# oc apply -n observability -f https://raw.githubusercontent.com/jaegertracing/jaeger-operator/v1.13.1/deploy/operator.yaml

# Kiali - Optional#
# bash <(curl -L https://git.io/getLatestKialiOperator) --operator-image-version v1.0.0 --operator-watch-namespace '**' --accessible-namespaces '**' --operator-install-kiali true || true

# Istio #
release=maistra-0.12.0
oc new-project istio-operator || true
oc new-project istio-system || true
oc apply -n istio-operator -f https://raw.githubusercontent.com/Maistra/istio-operator/${release}/deploy/maistra-operator.yaml
oc apply -n istio-system -f https://raw.githubusercontent.com/Maistra/istio-operator/${release}/deploy/examples/maistra_v1_servicemeshcontrolplane_cr_minimal.yaml

# Full for Jaeger and Kiali
# oc apply -n istio-system -f https://raw.githubusercontent.com/Maistra/istio-operator/${release}/deploy/examples/maistra_v1_servicemeshcontrolplane_cr_full.yaml



### Kabanero ###

oc new-project kabanero || true
oc apply -n kabanero -f https://raw.githubusercontent.com/kabanero-io/kabanero-operator/master/deploy/dependencies.yaml
oc apply -n kabanero -f https://raw.githubusercontent.com/kabanero-io/kabanero-operator/master/deploy/releases/0.0.1/kabanero-operator.yaml
oc apply -n kabanero -f https://raw.githubusercontent.com/kabanero-io/kabanero-operator/master/config/samples/full.yaml


# Need to check KNative Serving CRD is available before proceeding #

until oc get crd services.serving.knative.dev 
do
  sleep 1
done



### Tekton Dashboard ###

# Webhook Extension #
curl -L https://raw.githubusercontent.com/tektoncd/experimental/master/webhooks-extension/config/release/gcr-tekton-webhooks-extension.yaml \
  | sed 's/namespace: tekton-pipelines/namespace: kabanero/' \
  | oc apply --filename -

# Dashboard #
curl -L https://github.com/tektoncd/dashboard/releases/download/v0/gcr-tekton-dashboard.yaml \
  | sed 's/namespace: tekton-pipelines/namespace: kabanero/' \
  | oc apply --filename -

# Kserving Configuration #
oc patch configmap config-domain --namespace knative-serving --type='json' --patch '[{"op": "add", "path": "/data/'"${openshift_master_default_subdomain}"'", "value": ""}]'


### Routes ###

# Enable wildcard routes #
oc scale -n default dc/router --replicas=0
oc set env -n default dc/router ROUTER_ALLOW_WILDCARD_ROUTES=true
oc scale -n default dc/router --replicas=1

# Expose tekton dashboard with a Route #
until oc get -n kabanero svc tekton-dashboard
do
  sleep 1
done

oc expose service tekton-dashboard \
  -n kabanero \
  --name "tekton-dashboard" \
  --port="http" \
  --hostname=tekton-dashboard.${openshift_master_default_subdomain}

# Expose istio-gateway with a Route #
until oc get -n istio-system svc istio-ingressgateway
do
  sleep 1
done

oc expose service istio-ingressgateway \
  -n istio-system \
  --name="istio-ingressgateway-kabanero" \
  --wildcard-policy="Subdomain" \
  --port="http2" \
  --hostname=wildcard.kabanero.${openshift_master_default_subdomain}




