# Azure Function With Python example

This repository has a very simple example useful to create the required infrastructure to deploy a **python** function running in azure.
It basically contains:
* the terraform code
* the python function code
    *  configuration files.
* the **docker** file to build an image to work with the **azure functions tools**. 


## Requirements

* terraform     v0.12.20 or grater
* terragrunt    v0.21.11 or grater
* docker        v18.09.9


## Developer guide

- [Official documentation](https://docs.microsoft.com/en-us/azure/azure-functions/functions-reference-python)

- [Quickstart: Create an HTTP triggered Python function in Azure](https://docs.microsoft.com/en-us/azure/azure-functions/functions-create-first-function-python)


## Build docker image

```
sudo docker build -t uolter/azure-functions-core-tools .
```

## Working with docker image 

```
sudo docker run -it --rm -v $(pwd):/src -p 7071:7071 uolter/azure-functions-core-tools 
```

Once in the docker container:

```
>> cd  MyFunctionProj
>> pyenv virtualenv 3.7.4 venv
>> pyenv global  venv
## Run the function locally
func host start
```
---


## Azure Infrastructure Setup 

Create a **Resource group** for the **storage account**

```
$ az group create \
    --name storage-resource-group \
    --location northeurope
```

Create the **Storage Account**

```
$ az storage account create \
    --name terraformstate${RANDOM} \
    --resource-group storage-resource-group \
    --location northeurope \
    --sku Standard_RAGRS \
    --kind StorageV2
$ # it creates the storage account terraformstate5844
```

[Create container blob](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-cli)

```
$ az storage account keys list \
    --account-name terraformstate5844 \
    --resource-group storage-resource-group \
    --output table
```
 
get tue value of the key1 or key2 and set the following environment variable:

```
export AZURE_STORAGE_KEY="<key1 value>"
```


```
$ az storage container create --name tfstate
```

## Infrastructure



## Useful commands:

List of locations

```
az account list-locations \
    --query "[].{Region:name}" \
    --out table
```



