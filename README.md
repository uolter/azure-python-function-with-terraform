# Azure Functions Python developer guide

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
>> eval "$(pyenv init -)"
## Run the function locally
func host start
```
---

## Deploy in Azure

```
>> export FUNC_APP_NAME=<function name>
>> func azure functionapp publish $FUNC_APP_NAME
```
