#!/bin/bash

set -Eeuox pipefail

### Configuration ###

# Resultant Appsody container image #
DOCKER_IMAGE="${DOCKER_IMAGE:-docker-registry.default.svc:5000/appsody-project/java-microprofile}"

# Appsody project GitHub repository #
APP_REPO="${APP_REPO:-https://github.com/dacleyra/appsody-hello-world/}"


### Tekton Example ###

# Destination Namespace #
oc new-project appsody-project || true

# Add Namespace to Service Mesh #
#oc patch -n istio-system servicemeshmemberroll default --type json -p='[{"op":"add","path":"/spec/members","value":["appsody-project"]}]'
oc label namespace appsody-project istio-injection=enabled --overwrite


# Service Account #
oc apply -n kabanero -f https://raw.githubusercontent.com/appsody/tekton-example/master/appsody-service-account.yaml
oc policy add-role-to-user system:image-builder system:serviceaccount:kabanero:appsody-sa
oc adm policy add-cluster-role-to-user cluster-admin -z appsody-sa -n kabanero
oc adm policy add-scc-to-user hostmount-anyuid -z appsody-sa -n kabanero

sleep 5

# Workaround https://github.com/tektoncd/pipeline/issues/1103
# Restart pipeline operator and set priveleged securityContext
oc scale -n kabanero deploy openshift-pipelines-operator --replicas=0
sleep 5
oc scale -n kabanero deploy openshift-pipelines-operator --replicas=1

readyReplicas=0
until [ "$readyReplicas" -ge 1 ]; do
  readyReplicas=$(oc get -n kabanero deploy openshift-pipelines-operator -o template --template={{.status.readyReplicas}})
  sleep 1
done

sleep 5

# Install example resource for operator installed pipeline.
# Pipeline Resources
curl -L https://raw.githubusercontent.com/appsody/tekton-example/master/appsody-pipeline-resources.yaml \
  | sed "s|index.docker.io/chilantim/my-appsody-image|${DOCKER_IMAGE}|" \
  | sed "s|https://github.com/chilanti/appsody-test-build|${APP_REPO}|" \
  | oc apply -n kabanero --filename -


# Pipeline Run
oc apply -n kabanero -f https://raw.githubusercontent.com/appsody/tekton-example/master/appsody-pipeline-run.yaml
