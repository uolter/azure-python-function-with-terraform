
import azure.cosmos.documents as documents
import azure.cosmos.cosmos_client as cosmos_client
import azure.cosmos.exceptions as exceptions
from azure.cosmos.partition_key import PartitionKey
import azure.functions as func

import datetime
import logging
import os


ACCOUNT_HOST = os.environ.get('COSMOS_ACCOUNT_HOST')
ACCOUNT_KEY = os.environ.get('COSMOS_ACCOUNT_KEY')
COSMOS_DATABASE = os.environ.get('COSMOS_DATABASE')
COSMOS_CONTAINER = os.environ.get('COSMOS_CONTAINER')


def read_items(container):
    logging.info('Reading all items in a container\n')

    item_list = list(container.read_all_items(max_item_count=10))

    logging.info('Found {0} items'.format(item_list.__len__()))

    '''
    for doc in item_list:
        print('Item Id: {0}'.format(doc.get('id')))
    '''
    return item_list



def main(req):

    logging.info('Python HTTP trigger function processed a request.')

    try:
        client = cosmos_client.CosmosClient(ACCOUNT_HOST, {'masterKey': ACCOUNT_KEY},
            user_agent="CosmosDBDotnetQuickstart",
            user_agent_overwrite=True,
            connection_verify=False)

    except exceptions.CosmosResourceExistsError:
        logging.error("Error creating client")
        return func.HttpResponse("Error creating client")

    try:
        logging.info(COSMOS_DATABASE)
        db = client.create_database_if_not_exists(id=COSMOS_DATABASE)
    except  exceptions.CosmosResourceExistsError:
        logging.error("Error creating database")
        return func.HttpResponse("Error creating database")

    try:
        container = db.create_container_if_not_exists(id=COSMOS_CONTAINER,
            partition_key=PartitionKey(path='/account_number'),
            offer_throughput=400)

    except exceptions.CosmosResourceExistsError:
            logging.error('Container with id \'{0}\' was found'.format(COSMOS_CONTAINER))
            return func.HttpResponse("Error creating container")

    item_list = read_items(container)

    return func.HttpResponse(str(item_list))


if __name__ == "__main__":
    main(None)
