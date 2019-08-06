# Kabanero Foundation scripted install

## Prerequisites

* openshift_master_default_subdomain is configured
  * See more about [Configuring Your Inventory File](https://docs.okd.io/3.11/install/configuring_inventory_file.html)
* Wildcard DNS is available for your subdomain
  * alternatively, nip.io can be used
* The Internal Registry is configured
  * See more about the [Internal Registry](https://docs.okd.io/3.11/install_config/registry/index.html)

## Installation Scripts

Retrieve the [installation scripts from our documentation repository](https://github.com/kabanero-io/docs/tree/master/ref/scripts)

## Installation

As a `cluster-admin`, run
```
openshift_master_default_subdomain=my.openshift.master.default.subdomain ./install-kabanero-foundation.sh
```

## Sample Appsody project with manual Tekton pipeline run

Create a Persistent Volume for the pipeline to use. A sample hostPath `pv.yaml` is provided.
```
oc apply -f pv.yaml
```

Create the pipeline and execute the example manual pipeline run
```
APP_REPO=https://github.com/dacleyra/appsody-hello-world/ ./appsody-tekton-example-manual-run.sh
```

By default, the application container image will be built and pushed to the Internal Registry, and then deployed as a Knative Service.

View manual pipeline logs
```
oc logs $(oc get pods -l tekton.dev/pipelineRun=appsody-manual-pipeline-run --output=jsonpath={.items[0].metadata.name}) --all-containers
```

Access Tekton dashboard at `http://tekton-dashboard.my.openshift.master.default.subdomain`

Access application at `http://appsody-hello-world.appsody-project.my.openshift.master.default.subdomain`


## Sample Appsody project with webhook driven Tekton pipeline run

Create a Persistent Volume for the pipeline to use. A sample hostPath `pv.yaml` is provided.
```
oc apply -f pv.yaml
```

Create the pipeline and execute the example manual pipeline run.  
The Github user token must have the authority to access the repository and create a webhook.  
```
openshift_master_default_subdomain="my.openshift.master.default.subdomain" \
GITHUB_REPO="https://github.com/dacleyra/appsody-hello-world" \
GITHUB_USERNAME="githubuser" \
GITHUB_TOKEN="githubtoken" \
./appsody-tekton-example-webhook-run.sh
```

Following the creation of the webhook by the script, a commit to the repository will result in a pipeline execution.

By default, the application container image will be built and pushed to the Openshift Internal Registry, and then deployed as a Knative Service.

View manual pipeline logs
```
oc logs $(oc get pods -l tekton.dev/pipeline=appsody-build-pipeline --output=jsonpath={.items[0].metadata.name}) --all-containers
```

Access Tekton dashboard at `http://tekton-dashboard.my.openshift.master.default.subdomain`

Access application at `http://appsody-hello-world.appsody-project.my.openshift.master.default.subdomain`