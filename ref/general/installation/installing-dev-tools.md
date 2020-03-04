---
layout: doc
doc-category: Installation
title: Installing Codewind in VS Code or Eclipse
doc-number:  3.0
---
<!--
:linkattrs:
:page-doc-number: 3.0
:sectanchors:
-->

Eclipse Codewind enables you to develop microservice applications from application stacks in an IDE. Follow one of these links for your chosen IDE:

- [Installing Codewind for VS Code](installing-dev-tools.html#installing-codewind-for-vs-code)
- [Installing Codewind for Eclipse](installing-dev-tools.html#installing-codewind-for-eclipse)

## Installing Codewind for VS Code

The Codewind installation includes two steps:

1. The VS Code extension installs when you install Codewind from the VS Code Marketplace or when you install by searching in the "VS Code Extensions" view.
2. The Codewind back end containers install after you click "Install" when you are prompted. After you click Install, the necessary images are downloaded from the internet. The download is approximately 1 GB.

The following Codewind images are pulled. These images together form the Codewind back end:

- `eclipse/codewind-initialize-amd64`
- `eclipse/codewind-performance-amd64`
- `eclipse/codewind-pfe-amd64`

When the installation is complete, the extension is ready to use. For more information, see [Getting started: Codewind for VS Code](https://www.eclipse.org/codewind/mdt-vsc-getting-started.html).

To get started with application stacks in VS Code, read the guide [Getting Started with Codewind and Kabanero](../../../../guides/guide-codewind/).


### Updating the Codewind plug-in

Update your Codewind plug-in without uninstalling the extension.

1. Go to the **Extensions** view in VS Code
2. Search for the latest Codewind version in the Marketplace
3. Install the latest version of Codewind. Then, reload Codewind
4. Go to the **Explorer** view in VS Code
5. Depending on the current status of Codewind, one of two messages appear:
    - If the images from a previous version or release of Codewind are installed on the system, but Codewind is not running, a message asks you to install the most recent images. Click **OK** to start the download
    - If an older version of Codewind is installed and running, a message asks you to update the older version. Click **OK**, and Codewind stops automatically, and new images begin to download
6. Wait for the Codewind installation to complete. Codewind starts and is ready to use

### Removing containers and images

To remove Codewind, see [Uninstalling Codewind from VS Code](https://www.eclipse.org/codewind/mdt-vsc-uninstall.html).

### Troubleshooting

- Reinitiating the Codewind installation
    - If you don't click "Install" when the notification window first appears, you can't access the notification again.
Go to **View > Explorer**, then click **Codewind** and hover the cursor over **Codewind** where there is a switch to turn Codewind on or off.  Click the switch so that it is on. The notification window is displayed.

- Resetting the installation
    - To reset the installation, uninstall Codewind and install it again.

For more information about troubleshooting Codewind, see the [Codewind Troubleshooting page](https://www.eclipse.org/codewind/troubleshooting.html).


## Installing Codewind for Eclipse

The Codewind installation includes two steps and one optional step:

1. The Eclipse plug-in installs when you install Codewind from the Eclipse Marketplace or when you install by searching in the "Eclipse Extensions" view.
2. The Codewind back end containers install after you click "Install" when you are prompted. After you click "Install," the necessary images are downloaded from the internet. The download is approximately 1 GB.
3. **Optional**: If you don't click "Install" when the notification window first appears, you can access the notification again. Go to **View > Explorer**, then click **Codewind** and hover the cursor over "Codewind" where there is a switch to turn Codewind on or off.  Click the switch so that it is on. The notification window is displayed.

The following images are pulled. These images together form the Codewind back end:

- `eclipse/codewind-initialize-amd64`
- `eclipse/codewind-performance-amd64`
- `eclipse/codewind-pfe-amd64`

When the installation is complete, the extension is ready to use, and you are prompted to open the Codewind workspace.
You can open the Codewind workspace or a project within the workspace as your Eclipse workspace. For more information,
see [Getting started: Codewind for Eclipse](https://www.eclipse.org/codewind/mdt-eclipse-getting-started.html).

- On macOS and Linux, the workspace folder is `~/codewind-workspace`.
- On Windows, the workspace folder is `C:\codewind-workspace`.

When Codewind creates a new project, it is created in the Codewind workspace. If you want to add an existing project to Codewind, first copy it into the Codewind workspace.

To get started with application stacks in your Eclipse IDE, read the guide [Getting Started with Codewind and Kabanero](../../../../guides/guide-codewind/).

### Updating the Codewind plug-in

Update the Codewind Eclipse plug-in to the latest version.

1. From Eclipse, go to **Help > About Eclipse IDE**
2. Click **Installation details**
3. To look for the latest release, highlight `Codewind tech preview` and click **Update....**
4. Select the latest version and click **Next**
5. Review the license and click **Finish**
6. Click **Restart Now** to refresh Codewind to the latest version
7. After Codewind restarts, go to the **Codewind Explorer** view and double-click **Codewind** to update it to the latest version
8. Click **OK** in the **Codewind Update** window that states that the older version of Codewind will be removed, and the newer version will be started
9. After Codewind updates, the **Codewind Explorer** view appears with your projects

### Removing containers and images

To remove Codewind, see [Uninstalling Codewind from Eclipse](https://www.eclipse.org/codewind/mdteclipseuninstall.html).

### Troubleshooting Codewind

To troubleshoot Codewind, see the [Codewind Troubleshooting page](https://www.eclipse.org/codewind/troubleshooting.html).
