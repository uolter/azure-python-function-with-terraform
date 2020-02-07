# Azure Function With Python example

This repository has a very simple example useful to create the required infrastructure to deploy a **python** function running in azure.
It basically contains:
* the terraform code
* the python function code
    *  configuration files.
* the **docker** file to build an image to work with the **azure functions tools**. 



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



