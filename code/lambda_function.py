import json
import boto3
import os
import logging as log
import policy
from io import BytesIO

s3 = boto3.resource('s3')

dn=os.getenv('dn')
du=os.getenv('du')
dh=os.getenv('dh')
dbp=os.getenv('dbp')
account_id=os.getenv('account_id')
REGION="eu-west-2"
incident_id="johndeere_AWS_999"


def lambda_handler(event, context):
    policy.update(dn, du, dh, dbp, incident_id, REGION, account_id)
    return True
