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

### Istio ###

oc adm policy add-scc-to-user anyuid -z istio-ingress-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z default -n istio-system
oc adm policy add-scc-to-user anyuid -z prometheus -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-egressgateway-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-citadel-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-ingressgateway-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-cleanup-old-ca-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-mixer-post-install-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-mixer-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-pilot-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-sidecar-injector-service-account -n istio-system
oc adm policy add-cluster-role-to-user cluster-admin -z istio-galley-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z cluster-local-gateway-service-account -n istio-system
kubectl apply --filename https://github.com/knative/serving/releases/download/v0.5.0/istio-crds.yaml &&
curl -L https://github.com/knative/serving/releases/download/v0.5.0/istio.yaml \
  | sed 's/LoadBalancer/NodePort/' \
  | kubectl apply --filename -


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

until oc get crd pipelines.tekton.dev && oc get crd tasks.tekton.dev
do
  sleep 1
done

# Webhook Extension #
curl -L https://raw.githubusercontent.com/tektoncd/experimental/master/webhooks-extension/config/release/gcr-tekton-webhooks-extension.yaml \
  | sed 's/namespace: tekton-pipelines/namespace: kabanero/' \
  | oc apply --filename -

# Dashboard #
curl -L https://github.com/tektoncd/dashboard/releases/download/v0/gcr-tekton-dashboard.yaml \
  | sed 's/namespace: tekton-pipelines/namespace: kabanero/' \
  | oc apply --filename -
  
  
# Patch Dashboard #
# https://github.com/tektoncd/dashboard/issues/364
until oc get clusterrole tekton-dashboard-minimal
do
  sleep 1
done
oc patch clusterrole tekton-dashboard-minimal --type json -p='[{"op":"add","path":"/rules/-","value":{"apiGroups":["security.openshift.io"],"resources":["securitycontextconstraints"],"verbs":["use"]}}]'
oc scale -n kabanero deploy tekton-dashboard --replicas=0
sleep 5
oc scale -n kabanero deploy tekton-dashboard --replicas=1


# Kserving Configuration #
oc patch configmap config-domain --namespace knative-serving --type='json' --patch '[{"op": "add", "path": "/data/'"${openshift_master_default_subdomain}"'", "value": ""}]'


### Routes ###

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




