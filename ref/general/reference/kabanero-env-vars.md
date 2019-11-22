---
layout: doc
doc-category: Reference
title: Environment variables
---
# Environment variables

Kabanero Collections are built with a default set of configuration options that you can modify by setting environment variables.

The default values are set by the `./ci/ext/pre_env.d/kabanero_pre_env.sh` script. To overwrite these values, set any
required environment variables before you run the `./ci/build.sh`script.

The environment variables are listed in the following sections:

## `BUILD_ALL`

When using Github and Travis as the CI/CD build process, the build scripts build only the Collections that have been modified as part of a `git push` or `git pull` request. This environment variable can be used to overwrite that behavior and build all the Collections.

**Default value:** `BUILD_ALL=true`

## `CODEWIND_INDEX`

Controls whether the CODEWIND `index.json` file is built.

**Default value:** `CODEWIND_INDEX=true`

## `DISPLAY_NAME_PREFIX`

Defines the text that is prefixed to the `displayName` value for each of the Collection templates listed within the Codewind `index.json` file.

**Default value:** `DISPLAY_NAME_PREFIX=Kabanero`

## `EXCLUDED_STACKS`

Defines which Collections are excluded from the build.

**Default value:** `EXCLUDED_STACKS=“incubator/swift incubator/python-flask”`

For example, to exclude only the `incubator/swift` Collection in the `incubator/` directory, run:

```
export EXCLUDED_STACKS=incubator/swift
```

## `IMAGE_REGISTRY_ORG`

Defines the organisation name of the image registry that you want to use.

**Default value:** `IMAGE_REGISTRY_ORG=kabanero`

For example, to use the Docker hub organisation of `Kabanero` to name and store container images, run:

```
export IMAGE_REGISTRY_ORG=kabanero
```

## `INDEX_IMAGE`

Defines the name of the `nginx` index image. This image is created with the `IMAGE_REGISTRY_ORG` organisation. For example: `kabanero/kabanero-index`.

**Default value:** `INDEX_IMAGE=kabanero-index`

## `REPO_LIST`

Defines which classification of Collections are searched.

**Default value:** `REPO_LIST=incubator`

For example, to build Collections in the `incubator/` and `stable/` directories, run:

```
export REPO_LIST="incubator stable"
```
