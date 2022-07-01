import boto3
import os
import policy

s3 = boto3.resource('s3')

dn=os.getenv('dn')
du=os.getenv('du')
dh=os.getenv('dh')
dbp=os.getenv('dbp')
account_id=os.getenv('account_id')
REGION="eu-west-2"
incident_id="johndeere_AWS_999"


def lambda_handler(event, context):
    if policy.exists(dh, dbp, du, dn, REGION, incident_id):
        print(f'Updating Policy {incident_id}')
        result=policy.update(dn, du, dh, dbp, incident_id, REGION, account_id)
        if not result:
            print("failed to update record")
    else:
        result=policy.insert(dh, dbp, du, dn, REGION, incident_id)
        if not result:
            print("failed to insert record")
    return result


