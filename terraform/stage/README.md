
## Setup 


Resource group for storage account

```
$ az group create \
    --name storage-resource-group \
    --location northeurope
```

Storage Account

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

```
$ az storage container create --name tfstate
```

## Useful commands:

List of locations

```
az account list-locations \
    --query "[].{Region:name}" \
    --out table
```