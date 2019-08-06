#!/bin/bash

set -Eeuox pipefail

### Configuration ###

# openshift_master_default_subdomain #
openshift_master_default_subdomain="${openshift_master_default_subdomain:-my.openshift.master.default.subdomain}"

# Resultant Appsody project registry target #
DOCKER_REGISTRY="${DOCKER_REGISTRY:-docker-registry.default.svc:5000/appsody-project}"

# Appsody project GitHub repository #
GITHUB_HOST="${GITHUB_HOST:-github.com}"
GITHUB_URL="${GITHUB_URL:-https://${GITHUB_HOST}}"
GITHUB_REPO="${GITHUB_REPO:-${GITHUB_URL}/dacleyra/appsody-hello-world}"

# Github credentials for Webhook & Repo access #
GITHUB_USERNAME="${GITHUB_USERNAME:-anonymous}"
GITHUB_TOKEN="${GITHUB_TOKEN:-githubtoken}"


### Tekton Example ###

# Destination Namespace #
oc new-project appsody-project || true

# Add Namespace to Service Mesh #
oc label namespace appsody-project istio-injection=enabled --overwrite

# Elevate privelege of appsody-sa
oc adm policy add-cluster-role-to-user cluster-admin -z appsody-sa -n kabanero
oc adm policy add-scc-to-user hostmount-anyuid -z appsody-sa -n kabanero

# Cleanup
oc delete -n kabanero \
  githubsource.sources.eventing.knative.dev/appsody-build-pipeline-webhook \
  secret/github-secret \
  secret/github-repo-access-secret \
  secret/ssh-key \
  cm/githubwebhook || true

# github-secret is used to create webhooks
oc create secret generic github-secret \
  --from-literal=accessToken=$GITHUB_TOKEN \
  --from-literal=secretToken=$(cat /dev/urandom | LC_CTYPE=C tr -dc a-zA-Z0-9 | fold -w 32 | head -n 1) \
  --namespace kabanero

# github-repo-access-secret is used to check code out of github
post_data='{
    "name": "github-repo-access-secret",
    "type": "userpass", 
    "username": "'"${GITHUB_USERNAME}"'",
    "password": "'"${GITHUB_TOKEN}"'",
    "url": {"tekton.dev/git-0": "'"${GITHUB_URL}"'"},
    "serviceaccount": "appsody-sa"
}'
curl -X POST --header Content-Type:application/json -d "$post_data" http://tekton-dashboard.${openshift_master_default_subdomain}/v1/namespaces/kabanero/credentials


# Alternatively: Create SSH Secret for authenticated Github access, bug
# https://github.com/tektoncd/experimental/issues/188
# oc create -n kabanero secret generic --type='kubernetes.io/ssh-auth' ssh-key \
#   --from-file=ssh-privatekey=$HOME/.ssh/id_rsa \
#   --from-file=known_hosts=$HOME/.ssh/known_hosts 
# oc annotate -n kabanero secret ssh-key tekton.dev/git-0=github.com
# oc secrets -n kabanero link appsody-sa ssh-key


## Set up webhook
post_data='{
  "name": "appsody-build-pipeline-webhook",
  "gitrepositoryurl": "'"${GITHUB_REPO}"'",
  "accesstoken": "github-secret",
  "pipeline": "appsody-build-pipeline",
  "serviceaccount": "appsody-sa",
  "dockerregistry": "'"${DOCKER_REGISTRY}"'",
  "namespace": "'"kabanero"'"
}'
curl -X POST --header Content-Type:application/json -d "$post_data" http://tekton-dashboard.${openshift_master_default_subdomain}/v1/extensions/webhooks-extension/webhooks



echo "Verify the webhook has been set at ${GITHUB_REPO}/settings/hooks"
echo "The next commit to the repository will trigger the webhook & pipeline"
