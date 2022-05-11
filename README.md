# sdksqlproj

Deploying Azure Synapse Dedicated SQL Pools from GitHub Actions (using linux hosted runners).

Setup
## Create an Azure Service Principal for Github

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
Put these values in a safe place, you will need them later. The only time you see these values are when you're createing the Service Principal.

## Create a database project
