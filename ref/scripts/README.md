# Kabanero Foundation scripted install

## Prerequisites

* openshift_master_default_subdomain is configured
  * See more about [Configuring Your Inventory File](https://docs.okd.io/3.11/install/configuring_inventory_file.html)
* Wildcard DNS is available for your subdomain
  * alternatively, nip.io can be used
* The Internal Registry is configured
  * See more about the [Internal Registry](https://docs.okd.io/3.11/install_config/registry/index.html)

## Installation Scripts

Retrieve the [installation scripts from our kabanero-foundation repository](https://github.com/kabanero-io/kabanero-foundation/tree/master/scripts)

__Note__:Please replace `<my.openshift.master.default.subdomain>` with your master default subdomain. You can find this from your inventory file and the global variable name is `openshift_master_default_subdomain`.

## Installation

As a `cluster-admin`, run
```
openshift_master_default_subdomain=<my.openshift.master.default.subdomain> ./install-kabanero-foundation.sh
```

## Sample Appsody project with manual Tekton pipeline run

__Note__: This step is required only if dynamic storage is not enabled.

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

Access Tekton dashboard at `http://tekton-dashboard.<my.openshift.master.default.subdomain>`

Access application at `http://appsody-hello-world.appsody-project.<my.openshift.master.default.subdomain>`
