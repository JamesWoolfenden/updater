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
    
def exists(dh, dbp, du, dn, REGION, incident_id):
    token = connect.getdbtoken(DBHostname=dh, Port=dbp, DBUsername=du, Region=REGION)

    try:
        conn = psycopg2.connect(host=dh, port=dbp, database=dn, user=du, password=token, sslrootcert="global-bundle.cer")
        cur = conn.cursor()
        cur.execute(f"SELECT count(*) from {dn}.incident_configurations where incident_id='{incident_id}';")
        results = cursor.fetchone()
  
        print(results)
        if results==0:
            return False
        return True
    except Exception as e:
        print("Database connection failed due to {}".format(e))
        return False
        
def insert(dh, dbp, du, dn, REGION, incident_id):
    token = connect.getdbtoken(DBHostname=dh, Port=dbp, DBUsername=du, Region=REGION)

    try:
        conn = psycopg2.connect(host=dh, port=dbp, database=dn, user=du, password=token, sslrootcert="global-bundle.cer")
        cur = conn.cursor()
        query=f"INSERT INTO {dn}.incident_configurations (incident_id, incident_type, category, title, guideline, severity, lacework_violation_id, prowler_violation_id, checkov_check_id, remediation_ids, condition_query, is_custom, customer_name, resource_types, provider, created_by, code, constructive_title, descriptive_title, pc_policy_id, frameworks, pc_severity, source_incident_id, additional_pc_policy_ids) VALUES ('{incident_id}', 'Violation', 'General', 'Ensure Security group has correct tags', 'url to guideline', 'MEDIUM', NULL, NULL, '{incident_id}','{{}}', NULL, true, 'johndeere', '{{aws_security_group}}', 'AWS', NULL, NULL, 'constuctive', 'descriptive', NULL, '{{Terraform}}', NULL, NULL, NULL);"
        cur.execute(query)
        query_results = cur.fetchall()
        return query_results
    except Exception as e:
        print("Database connection failed due to {}".format(e))
        return False