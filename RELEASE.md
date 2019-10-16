# Docs Release
Docs follow the release process for Kabanero as a whole - Kabanero uses [semver](https://semver.org/) versioning.

Here is an example flow of the Kabanero release using `0.2.0` as the next release example:

**Assumption**: When a new release of Kabanero as a whole is ready the next version number will always be a **Major** or **Minor** increment (never a **Patch** increment).

1. When `0.2.0` release date comes maintainers cut the `0.2.0` release on the repo. End of release process.

## Docs repo needs a hot fix for `0.2.0` example

1. If after a release, a piece of documentation needs to have a small update or a quick bug fix (and should be deployed before the next scheduled release, `0.3.0`, in this example) maintainers would:
1. create a `release-0.2` branch based off the `0.2.0` release. 
1. Put the changes in the `release-0.2` branch and `master` branch, if applicable (see Note below).
1. Cut a new release based off the `release-0.2` branch and increment the patch number so it becomes `0.2.1`
1. Publish release `0.2.1`.

The patch version of the `docs` repo is independent of the patch version of Kabanero; the major and minor version numbers of the docs and Kabanero are in sync. For example, a `docs` release of `0.2.1` corresponds to Kabanero version `0.2.x` and vice versa.  

**Note**: In this hot fix example the `master` branch will always be going towards the next release so new commits to `master` will always be `0.3.0` related.
