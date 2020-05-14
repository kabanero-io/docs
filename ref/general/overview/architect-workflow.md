---
layout: doc
doc-category: Overview
title: Architect workflows
doc-number: 2.0
---

Application architects are responsible for designing application architectures. They determine the microservice components of
the architecture, the connections between microservices and back end systems, security considerations, and the set of software
components that are used for developing and deploying applications. In some cases, the application architect might take on some
of the implementation tasks defined in  Operations workflows.

## Implementing application stacks

As an application architect or a lead developer, you will have a keen interest in the application stacks that are used
by your development teams. You will want to choose which stacks are available to your teams and you might want to customize these
stacks to meet local requirements. For example, you might want to define specific  maintenance levels of software components in  the
stack, or add security components to meet compliance rules for your organization. You might also want to change the default template
that is used by your development team, or even add your own.

- To get started, read the guide on [Customizing application stacks](../../../../guides/working-with-stacks/).

If your development teams are using more than one type of application stack, you might want to create a stack hub.
A stack hub is the central control point for application stacks that you want to use in your organization.

- To learn more about this task, read the guide on [Creating a stack hub](../../../../guides/working-with-stacks/).

To follow best practices, implement semantic versioning for releases of your application stacks, which enable governance in
your Kubernetes deployments.

- To understand more, read the topic on [Governing stacks with semantic versioning tags](../reference/semver-governance.html).

To implement a governance policy for your Kubernetes deployment, read [Configuring Governance Policy for Stacks](../configuration/stack-governance.html).
