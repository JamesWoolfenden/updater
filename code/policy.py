#!/usr/bin/env python3
import connect
import psycopg2
import boto3
import yaml
import json
import os

from jinja2 import Environment, FileSystemLoader
from io import BytesIO


def update(dn, du, dh, dbp, incident_id, REGION, account_id):
    print("update")
    policy= make(account_id)
    token = connect.getdbtoken(DBHostname=dh, Port=dbp, DBUsername=du, Region=REGION)

    # Connect to an existing database
    conn=psycopg2.connect(host=dh, port=dbp, database=dn, user=du, password=token, sslrootcert="global-bundle.cer")
    
    # Open a cursor to perform database operations
    cur = conn.cursor()

    cur.execute(f"UPDATE {dn}.incident_configurations SET code='{json.dumps(policy)}' WHERE incident_id='{incident_id}';")
    
    print(cur.statusmessage)
    
    # Make the changes to the database persistent
    conn.commit()

    # Close communication with the database
    cur.close()
    conn.close()

def make(account_id):

    filename="dynamictags.yaml"
    bucket=f"dynamic-policy-{account_id}"
    components=get_tags(account_id)

    file_loader = FileSystemLoader('templates')
    env = Environment(loader=FileSystemLoader(os.path.abspath(os.path.dirname(__file__))))
    
    template = env.get_template('/dynamictags.yaml.tmpl')
    
    output = template.render(components=components)
    return output

def get_tags(account_id):
    bucket=f"dynamic-policy-{account_id}"
    session = boto3.Session()
    s3_client = session.client("s3")

    f = BytesIO()
    s3_client.download_fileobj(bucket, "components", f)
    raw=f.getvalue()
    rawstring=raw.decode("UTF-8")
    components=rawstring.split("\n")
    
    return components