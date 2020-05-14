---
layout: doc
doc-category: Overview
title: Operations workflows
doc-number: 3.0
---

The Operations team are responsible for any development, test, or production environments that run on the Kubernetes
container platform. Their role is to install and configure Kabanero Foundation to support cloud native application deployments, implement secure
connections to back end systems, and integrate the development lifecycle into robust Continuous Integration / Continuous Deployment (CI/CD) processes.

## Installation

The first task is to install the Kabanero Foundation software in your Kubernetes environment.

- Follow the instructions in the [installation topic](../installation/installing-kabanero-foundation.html)

When you've completed the installation, take a look at the **Configuration** topics to learn about the different configuration options.

If your development teams want to use CodeReady workspaces for their development environment, you must install Codewind for CodeReady
workspaces on your cluster.

- Follow the instructions for [Installing Codewind in CodeReady Workspaces](../general/installation/installing-codeready-and-codewind.html)

## Implementing pipelines

As application development projects get underway, you must integrate the development, build, and test cycle into your CI/CD processes. When changes are made to development projects, use webhooks to drive pipelines that update your Kubernetes
environments.

- Read the following guides to get started with pipelines:
    - [Creating and updating tasks and pipelines](../../../../guides/curating-pipelines/)
    - [Build and deploy applications with pipelines](../../../../guides/working-with-pipelines/)

Webhooks can be configured for each Git repository that contains a development project. Alternatively, a single webhook can be configured for your
Git organization. A single webhook is the recommended approach to save set up and maintenance tasks.

- To  create a single webhook for your GitHub organization that you can use with the Event Operator to filter events and drive multiple pipelines,
read [Integrating the Event Operator](../../../../guides/......)
- To set up individual webhooks from your pipelines dashboard, read [Connecting to GitHub with webhooks](../configuration/tekton-webhooks.html)


## Monitoring and logging your deployments

When applications are deployed to your cluster, set up monitoring and logging to help you manage the environment.

- Learn how to set up [Application Monitoring on Red Hat OpenShift Container Platform (RHOCP) 4.3 with Prometheus and Grafana](../guides/app-monitoring-ocp4.2/)
- Implement [Application Logging on Red Hat OpenShift Container Platform (RHOCP) 4.3 with Elasticsearch, Fluentd, and Kibana](../guides/app-logging-ocp-4-2/)
