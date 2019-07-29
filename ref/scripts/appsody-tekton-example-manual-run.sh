#!/bin/bash

set -Eeuox pipefail

### Configuration ###

# Resultant Appsody container image #
DOCKER_IMAGE="${DOCKER_IMAGE:-docker-registry.default.svc:5000/appsody-project/java-microprofile}"

# Appsody project GitHub repository #
APP_REPO="${APP_REPO:-https://github.com/dacleyra/appsody-hello-world/}"

### Tekton Example ###

# Create deploy target Project Namespace #
oc new-project appsody-project || true

# Add Namespace to Service Mesh #
oc label namespace appsody-project istio-injection=enabled --overwrite

# Namespace #
namespace=kabanero

# Grant SecurityContext to appsody-sa. Example PV uses hostPath
oc adm policy add-scc-to-user hostmount-anyuid -z appsody-sa -n ${namespace}


# Workaround https://github.com/tektoncd/pipeline/issues/1103
# Restart pipeline operator to avoid issue
oc scale -n kabanero deploy openshift-pipelines-operator --replicas=0
sleep 5
oc scale -n kabanero deploy openshift-pipelines-operator --replicas=1
readyReplicas=0
until [ "$readyReplicas" -ge 1 ]; do
  readyReplicas=$(oc get -n kabanero deploy openshift-pipelines-operator -o template --template={{.status.readyReplicas}})
  sleep 1
done

# Pipeline Resources: Source repo and destination container image
curl -L https://raw.githubusercontent.com/appsody/tekton-example/master/appsody-pipeline-resources.yaml \
  | sed "s|index.docker.io/chilantim/my-appsody-image|${DOCKER_IMAGE}|" \
  | sed "s|https://github.com/chilanti/appsody-test-build|${APP_REPO}|" \
  | oc apply -n ${namespace} --filename -

# Manual Pipeline Run
oc apply -n ${namespace} -f https://raw.githubusercontent.com/appsody/tekton-example/master/appsody-pipeline-run.yaml
