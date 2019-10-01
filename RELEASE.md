# Docs Release
Docs follow the release process for Kabanero as a whole - Kabanero uses [semver](https://semver.org/) versioning.

Here is an example flow of the Kabanero release using `0.2.0` as the next release example:

**Assumption**: When a new release of Kabanero as a whole is ready the next version number will always be a **Major** or **Minor** increment (never a **Patch** increment).

1. When `0.2.0` release date comes maintainers cut the `0.2.0` release on the repo. End of release process.

## Docs repo needs a hot fix for `0.2.0` example

1. If after a release, A piece of Kabanero.io (cli, pipelines, operator, docs, etc...) needs to do a small update or a quick bug fix or something (and should be deployed before the next scheduled release, `0.3.0`, in this example) maintainers would:
1. create a `release-0.2` branch based off the `0.2.0` release. 
1. Put the changes in the `release-0.2` branch and `master` branch, if applicable (see Note below).
1. Cut a new release based off the `release-0.2` branch and increment the patch number so it becomes `0.2.1`
1. Publish release `0.2.1`.

**Note**: During this whole hot fix situation the `master` branch will always be going towards the next release so new stuff in master will always be `0.3.0` related.
