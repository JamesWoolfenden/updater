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
region=os.getenv('region')
incident_id=os.getenv('incident_id')


def lambda_handler(event, context):
    exists=policy.exists(dh, dbp, du, dn, region, incident_id)

    if not exists:
        print(f'Inserting Placeholder Policy {incident_id}')
        result=policy.insert(dh, dbp, du, dn, region, incident_id)
        if not result:
            print("failed to insert placeholder  record")
        
    print(f'Updating Policy {incident_id}')
    result=policy.update(dn, du, dh, dbp, incident_id, region, account_id)
    
    if not result:
        print("failed to update record")
        
    return result

