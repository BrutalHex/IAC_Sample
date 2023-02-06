# Prerequisites
- Azure cli
- npm
- azure function tools
- Python3

# Deploy:
navigate to ./src folder and restore the node packages.
for deployment simply execute `python3 setup.py` and followup instructions.
after successfull execution navigate to the url provided in the cli.


# questions: 
## 1.What resources (websites/documentation) did you use to create the Infrastructure as Code ?
### information
- https://registry.terraform.io/providers/hashicorp/azurerm/latest
- https://learn.microsoft.com/en-us/azure/azure-functions/run-functions-from-deployment-package

### terraform resources:
- **azurerm_resource_group** : it's a starting point to tell Azure were we want to setup our infrastructure
- **azurerm_service_plan** : the hosting plan that needed to be used for our application.
- **azurerm_storage_account** : to determine the tier of our blobs and some other specifications.
- **azurerm_storage_container** : it is beingnused to hold our blobs.
- **azurerm_storage_blob** : we are using two of them , one for **source code** and another for **Hello-world** file.
- **azurerm_function_app** : gives us the ability to define serverless functions.

## 2.What was the biggest challenge in this task?
- development of the nodejs app to read from Azur blob. 
- the settings of WEBSITE_RUN_FROM_PACKAGE in azurerm_function_app


## 3.If you needed additional Azure Resources why did you need them?
- addition of azurerm_storage_account_blob_container_sas. it helped to add a token for accessing the hell-world.txt blob.
- archive_file , to archive the source code as zip file.
