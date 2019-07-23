# Kabanero Foundation scripted install

## Prerequisites

* openshift_master_default_subdomain is configured
  * https://docs.openshift.com/container-platform/3.11/install/configuring_inventory_file.html
* Wildcard DNS is available for your subdomain
  * alternatively, nip.io can be used
* The Openshift Internal Registry is configured
  * https://docs.openshift.com/container-platform/3.11/install_config/registry/index.html


## Installation

As an Openshift `cluster-admin`, run
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

By default, the application container image will be built and pushed to the Openshift Internal Registry, and then deployed as a Knative Service.

View manual pipeline logs
```
oc logs $(oc get pods -l tekton.dev/pipelineRun=appsody-manual-pipeline-run --output=jsonpath={.items[0].metadata.name}) --all-containers
```