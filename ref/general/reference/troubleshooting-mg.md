---

copyright:
  years: 2019, 2020
lastupdated: "2020-02-25"
---
layout: doc
doc-category: Reference
title: Using MustGather scripts to collect environment data
---

<!--
:page-layout: doc
:page-doc-category: Reference
:linkattrs:
:sectanchors:
-->

# Using MustGather scripts to collect environment data

You can use the `mustgather` command to collect data about your environment. This information can be useful in troubleshooting and fixing problems.

There are several MustGather scripts available in the `kabanero-foundation/scripts/mustgather` directory:

* `appsody-mustgather.sh`
* `che-mustgather.sh`
* `istio-mustgather.sh`
* `kabanero-mustgather.sh`
* `kappnav-mustgather.sh`
* `knative-mustgather.sh`
* `mustgather-all.sh`
* `tekton-mustgather.sh`

## Running a MustGather Script

1. In a terminal session, navigate to the location where you cloned the *kabanero-foundation* repository and go to the `kabanero-foundation/scripts/mustgather` directory.

1. Log in to your cluster.
```
oc login https://<your_cluster_hostname> -u <username> -p <password>
```

1. Run a `mustgather` script. For example:
```
./mustgather-all.sh
```
**Tip**: You can set the environment variable `LOGS_DIR` to specify the data output location:
```
LOGS_DIR=<my_directory> ./mustgather-all.sh
```
By default, MustGather data is stored in the `kabanero-debug` directory. The command also stores compressed information in the `kabanero-debug-<timestamp>.tar.gz` file.
