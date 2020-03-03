---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-03"
---
layout: doc
doc-category: Reference
title: Troubleshooting
---

<!--
:page-layout: doc
:page-doc-category: Reference
:linkattrs:
:sectanchors:
-->

# Troubleshooting the Kabanero open source project
{: #troubleshoot}

Learn how to isolate and resolve problems.

* [Errors when using a webhook to trigger pipelines](#errorwtp)
* ['docker push` fails with gateway timeout error](#dockerpushfails)
* [Webhooks are not created in GitHub, even though the pipelines dashboard says webhook creation was successful](#nowebhook)

## Errors when using a webhook to trigger pipelines
{: #errorwtp}

When using a Tekton webhook to trigger pipelines installed with Kabanero, the last task is the `monitor-result-task`, which may fail in some cases. This might also cause the webhook pod to be in the "Error" state. The following failures of `monitor-result-task` in the TaskRun view can be disregarded at this time; they do not impact the application deployment:

* `error creating GitHub client: error parsing PR number: pulls`
* `IOError: [Errno 2] No such file or directory: '/workspace/pull-request/pr.json'`


## `docker push` fails with gateway timeout error
{: #dockerpushfails}

When using OpenShift Container Platform on a cloud with Kubernetes service and an internal Docker registry, performing a `docker push` into the internal Docker registry might result in a gateway time-out error.  This happens in cases where the input-output operations per second (IOPS) setting for the backing storage of the registry's persistent volume (PV) is too low.

To resolve this problem, change the IOPS setting of the PV's backing storage device.

## Webhooks are not created in GitHub, even though the dashboard says webhook creation was successful
{: #nowebhook}

When the webhooks extension sink does not run for extended periods of time, the KService might not be marked as `ready`, which can prevent a webhook from being created.

### To diagnose this problem:

1. Check that your pods in the `knative-serving`, `knative-sources`, and `knative-eventingandistio-system` namespaces are healthy, and that you have a `ServiceMeshMemberRoll` resource that includes your install namespace for the Tekton Dashboard and Webhooks Extension.

1. Inspect the logs in the `github-controller-manager-0` pod in the `knative-eventing` namespace.  For example, run:
```
oc logs github-controller-manager-0 -n knative-sources | grep -i 'creating GitHub webhook' -C 3
```
1. Check for multiple "Ready" KServices. For example, run:
```
oc get ksvc -n *<my_install_namespace>*.
```
You want the output to resemble the following example, but with different pod names:
```
mylaptop:config myusername$ oc get ksvc
NAME                      URL                                                            LATESTCREATED                   LATESTREADY                     READY
tekton-8hmwh-brxps        http://tekton-8hmwh-brxps.mynamespace.apps.mysystem.com        tekton-8hmwh-brxps-pj5jx        tekton-8hmwh-brxps-pj5jx        True
webhooks-extension-sink   http://webhooks-extension-sink.mynamespace.apps.mysystem.com   webhooks-extension-sink-5tx7l   webhooks-extension-sink-5tx7l   True
```
If the output does not resemble the example, use `oc describe` to describe the KService that is not marked as `True` for READY and your GitHubSource.

An ideal `oc describe githubsource` includes:

```
  Sink:
    API Version:  serving.knative.dev/v1alpha1
    Kind:         Service
    Name:         webhooks-extension-sink
Status:
  Conditions:
    Last Transition Time:  2019-11-15T14:19:51Z
    Status:                True
    Type:                  Ready
    Last Transition Time:  2019-11-15T14:19:51Z
    Status:                True
    Type:                  SecretsProvided
    Last Transition Time:  2019-11-15T14:19:51Z
    Status:                True
    Type:                  SinkProvided
  Sink Uri:                http://webhooks-extension-sink.myinstallnamespacesvc.cluster.local
```

If the data does not show a `Ready` state and the problem is persistent, there might be an issue with the webhooks extension code itself.

### To resolve the problem:

1. Ensure that the `ServiceMeshControlPlane` namespace is in the `Ready` state.
   - Use the `oc -n istio-system describe ServiceMeshControlPlane basic-install` command.
   - If the `ServiceMeshControlPlane` is not in the `Ready` state, restart all the pods in the `istio-system` namespace.
1. Ensure that the `KnativeServing` namespace is in `Ready` state.
   - Use the `oc -n knative-serving describe KnativeServing knative-serving` command.
   - If the `KnativeServing` is in `Ready` is not in the `Ready` state, restart all the pods in the `knative-serving` namespace.
1. Ensure that `webhooks-extension-sink` KService is in the `Ready` state.
   - Use the `oc get kservice -n tekton-pipelines` command.
   - If the `webhooks-extension-sink` KService is not in the `Ready` state, delete a revision object that is associated with the `webhooks-extension-sink`. For example, use the `oc delete rev -l serving.knative.dev/configuration=webhooks-extension-sink` command.
