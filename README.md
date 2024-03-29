# sdksqlproj

Deploying Azure Synapse Dedicated SQL Pools from GitHub Actions using GitHub hosted runners.

## **Prerequisites**
* Github Account
* Git
* VS Code (Extensions: SQL Server (mssql))
* .NET Core SDK 3.1 (https://dotnet.microsoft.com/en-us/download/dotnet/3.1)
* Azure Account (with an existing Synapse Workspace with Dedicated SQL Pool or Dedicated SQL Pool (Formerly SQL DW))
* Optional Azure Key Vault for secret storage (otherwise use the Service Principal)

---

## **Create a database project**
Using either Visual Studio, or Visual Studio Code, create a database project (in our case, we're going to create an Azure SQL Database Project):

<img src="./assets/db_project_1.jpg" alt="drawing" style="width:1000px;"/>

We want to choose a SDK-style project. SDK-style projects can be built on Linux hosted runners. Default SQL Database Projects use .NET 4.8 which isn't supported on Linux.

<img src="./assets/db_project_2.jpg" alt="drawing" style="width:1000px;"/>

Once the project is created, right click on the database project and change the target platform as required:

<img src="./assets/db_project_3.jpg" alt="drawing" style="width:800px;"/>

In our case, we're going to choose Azure Synapse Dedicated SQL Pool

<img src="./assets/db_project_4.jpg" alt="drawing" style="width:1000px;"/>

---

## **Create an Azure Service Principal for GitHub**

[Create an Azure service principal with the Azure CLI](https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli)

An Azure service principal is an identity created for use with applications, hosted services, and automated tools to access Azure resources. This access is restricted by the roles assigned to the service principal, giving you control over which resources can be accessed and at which level. For security reasons, it's always recommended to use service principals with automated tools rather than allowing them to log in with a user identity.

In this case, our Github Action will use the Azure Service Principal to connect to our Azure tenet and deploy our database changes.

Example:
From the Azure CLI:
This will create a Service Principal with the Contributor RBAC role for the bicep-rg resource group:
```
az ad sp create-for-rbac --role contributor --sdk-auth --name "bicepsqldeployserviceprincipal" --scopes /subscriptions/<subscription id>/resourceGroups/bicep-rg
```

The output from this command will look something like:
```json
{
  "clientId": "<GUID>",
  "clientSecret": "<GUID>",
  "subscriptionId": "<GUID>",
  "tenantId": "<GUID>",
  "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
  "resourceManagerEndpointUrl": "https://management.azure.com/",
  "activeDirectoryGraphResourceId": "https://graph.windows.net/",
  "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
  "galleryEndpointUrl": "https://gallery.azure.com/",
  "managementEndpointUrl": "https://management.core.windows.net/"
}
```
Put these values in a safe place, you will need them later. The only time you see these values are when you're creating the Service Principal.

Add the created credentials to Github Secrets:
In settings, go to Secrets, Actions, "New repository secret", give it a name, and copy the output from the Azure CLI in the Value and click on Add secret.

<img src="./assets/github_2.jpg" alt="drawing" style="width:1000px;"/>

---

## **Github Action**
To deploy the project, use a GitHub action.

<img src="./assets/github_actions_1.jpg" alt="drawing" style="width:1000px;"/>

Within your GitHub repo, select Actions from the menu and select "New Workflow" and click on the "Configure" button in the "Simple Workflow" box

<img src="./assets/github_actions_2.jpg" alt="drawing" style="width:1000px;"/>

Example actions in the repository include:

 - linux-action.yml - A Github Linux hosted runner. [linux-action.yml](https://github.com/kebullen/sdksqlproj/blob/main/.github/workflows/linux-action.yml) featuring the Azure [sql-action](https://github.com/Azure/sql-action) from the Linux hosted runner.
 
 - linux-raw.yml - A Github Linux hosted runner. [linux-raw.yml](https://github.com/kebullen/sdksqlproj/blob/main/.github/workflows/linux-raw.yml) builds the .NET project and executes sqlpackage from the Linux hosted runner.

 - windows-action.yml - A Github Windows hosted runner. [windows-action.yml](https://github.com/kebullen/sdksqlproj/blob/main/.github/workflows/windows-action.yml) featuring the Azure [sql-action](https://github.com/Azure/sql-action) from the Windows hosted runner.

 - windows-raw.yml - A Github Windows hosted runner. [windows-raw.yml](https://github.com/kebullen/sdksqlproj/blob/main/.github/workflows/windows-raw.yml) builds the .NET project and executes sqlpackage from the Windows hosted runner.

## **Links**
 - Sqlpackage publish properties - https://docs.microsoft.com/en-us/sql/tools/sqlpackage/sqlpackage-publish?view=sql-server-ver16#properties-specific-to-the-publish-action
 - Building database projects from the commandline: https://docs.microsoft.com/en-us/sql/azure-data-studio/extensions/sql-database-project-extension-build-from-command-line?view=sql-server-ver16
