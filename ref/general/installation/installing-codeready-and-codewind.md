---
layout: doc
doc-category: Installation
title: Installing Codewind in CodeReady Workspaces
doc-number: 4.0
---

<!--
:linkattrs:
:page-doc-number: 3.0
:sectanchors:
-->

Eclipse Codewind enables you to develop microservice applications from application stacks in an IDE.
CodeReady Workspaces provides a containerized IDE for cloud native application development on an OpenShift cluster.

## Prerequisites

CodeReady Workspaces requires at least two 1Gi ReadWriteOnce (RWO) persistent volumes on the cluster to install and a 1Gi RWO volume for each created workspace.

Each Codewind workspace also requires at least one 1Gi ReadWriteMany (RWX) persistent volume.

## Installing CodeReady Workspaces

To install CodeReady Workspaces, set `Spec.codeReadyWorkspaces.enable: true` in the Kabanero custom resource (Kabanero CR) instance and apply it.

The following sample shows a Kabanero CR instance configuration:

```yaml
apiVersion: kabanero.io/v1alpha2
kind: Kabanero
metadata:
  name: kabanero
spec:
  version: "0.6.0"
  codeReadyWorkspaces:
    enable: true
    operator:
      customResourceInstance:
        tlsSupport: true
        selfSignedCert: true
  stacks:
    repositories:
    - name: central
      https:
        url: https://github.com/kabanero-io/collections/releases/download/0.6.0/kabanero-index.yaml
```

### Configuring CodeReady Workspaces

The Kabanero CR instance provides additional fields that allow you to configure your installation of CodeReady Workspaces.

- If you want to install CodeReady Workspaces with TLS Support, set `Spec.codeReadyWorkspaces.operator.customResourceInstance.tlsSupport` to `true`.
  **Note:** If your OpenShift cluster's router is set up with self-signed certificates, `Spec.codeReadyWorkspaces.operator.instance.selfSignedCert` must also be set to `true`.
- If you want to use your OpenShift accounts with CodeReady Workspaces, set up permanent users (accounts other than kube:admin) and then set `Spec.codeReadyWorkspaces.operator.customResourceInstance.openShiftOAuth` to `true`.
Consult [Configuring a Kabanero CR Instance](../configuration/kabanero-cr-config.html) for the full list of configurable fields.

### Using CodeReady Workspaces with self-signed certificates

If CodeReady Workspaces is set up to use the self-signed certificates provided by the OpenShift cluster's router, you must complete the following steps in your browser:

**Google Chrome:**

- Access the CodeReady Workspaces route in your browser.
- Download the route's certificate to your system.
- Go to **Settings -> Privacy and Security -> Manage certificates**.
- Import the certificate into your system and set trust to `Always trust`.

**Firefox (version 71 or newer):**

- Access the CodeReady Workspaces route in your browser.
- View the route's certificate in your browser.
- Download the certificate titled `ingress-operator`.
- Go to **Preferences -> Privacy and Security -> View certificates**.
- Import the `ingress-operator` certificate as an authority into Firefox.

## Installing Codewind

When CodeReady Workspaces is installed on your OpenShift cluster, complete the following steps:

- Log in to CodeReady Workspaces.
- Click **Create Workspace**.
- Under **Name**, give your workspace a meaningful name.
- Under **Select Stack**, select `Codewind`.
- Click **Create & Open** to create and start Codewind in CodeReady Workspaces.

CodeReady Workspaces starts Codewind and installs the Codewind plugins. This process might take a couple of minutes for all of the necessary components to be pulled and started.

Consult the [Codewind on Che documentation](https://www.eclipse.org/codewind/mdt-che-installinfo.html) for additional information and next steps.

### Stopping or uninstalling Codewind

If you need to stop the Codewind workspace, follow these steps:

- Log in to your CodeReady workspaces account and access the dashboard.
- Click on **Workspaces** in the sidebar.
- To pause the Codewind workspace, select the Codewind workspace and under **Actions** click the **Stop workspace** button.
- To delete the Codewind workspace, select the Codewind workspace and click the **Delete** button.

### Troubleshooting

To troubleshoot Codewind, see the [Codewind Troubleshooting page](https://www.eclipse.org/codewind/troubleshooting.html).
