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
- https://registry.terraform.io/providers/hashicorp/azurerm/latest
- https://learn.microsoft.com/en-us/azure/azure-functions/run-functions-from-deployment-package

## 2.What was the biggest challenge in this task?
- development of the nodejs app to read from Azur blob. 
- the settings of WEBSITE_RUN_FROM_PACKAGE in azurerm_function_app


## 3.If you needed additional Azure Resources why did you need them?
addition of azurerm_storage_account_blob_container_sas.
it helped to add a token for accessing the hell-world.txt blob.
