---
version: v0.2.0
title: What's New In Kabanero v0.2.0
---

## Collection CLI
With the Collection CLI, you can synchronize curated-collection updates, view the status of collections, and temporarily deactivate a collection. This feature also assists the enterprise manage collections in a Collection Hub for a specific Kabanero instance deployed in a Kubernetes cluster.

## Collections 0.2.0
Use the features in Kabanero collections to develop microservices and applications for the enterprise. These collections include enhancements for security, performance, and bug fixes.
* java-microprofile
* java-spring-boot2
* node-js-express
* node-js-loopback
* node-js

## Manage microservice composed applications
Kabanero now integrates a new open source project called kAppNav which is a Kubernetes Application Navigator that assists with managing microservice composed applications. This provides display, inspection, understanding, and navigation of the deployed resources that comprise an application. This is installed through a Kubernetes operator and included in the user experience.

The [Application Custom Resource Definition (CRD)] (https://github.com/kubernetes-sigs/application/blob/master/config/crds/app_v1beta1_application.yaml) from the [Kubernetes Application SIG] (https://github.com/kubernetes-sigs/application) is used as the basis for describing applications.

## Guides
Guides are now available on the Kabanero website to help you to learn more about Kabanero. Guides provide step-by-step instructions with a real use case in mind to help you get started quickly. See https://kabanero.io/guides/

## Support scripts
The Kabanero support scripts include a sample script that uninstalls Kabanero and must-gather scripts that collect important diagnostic data.

## Kabanero operator, enhanced
The Kabanero operator now includes a –targetNameSpaces configuration that defines a list of namespaces that help to manage Appsody application deployments with Kabanero using a controlled set of namespaces defined by the architect and operations roles. To simplify collection development, variable substitution is introduced to allow the same pipeline template to be used for multiple collections. This allows you to use one pipeline for multiple collections.
