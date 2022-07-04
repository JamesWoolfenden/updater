#!/usr/bin/env python3
import connect
import psycopg2
import boto3
import yaml
import json
import os

from jinja2 import Environment, FileSystemLoader
from io import BytesIO


def update(dn, du, dh, dbp, incident_id, region, account_id):
    policy = make(account_id, incident_id)
    if not policy:
        print("No updates were made to the database")
        return False
    print(f"Following policy will be updated: {policy}")
    token = connect.getdbtoken(DBHostname=dh, Port=dbp, DBUsername=du, Region=region)

    # Connect to an existing database
    conn = psycopg2.connect(host=dh, port=dbp, database=dn, user=du, password=token, sslrootcert="global-bundle.cer")

    # Open a cursor to perform database operations
    cur = conn.cursor()

    cur.execute(f"UPDATE {dn}.incident_configurations SET code='{json.dumps(policy)}' WHERE incident_id='{incident_id}';")

    print(f"status:{cur.statusmessage}")

    # Make the changes to the database persistent
    conn.commit()

    # Close communication with the database
    cur.close()
    conn.close()
    return True

def make(account_id, incident_id):

    filename = "dynamictags.yaml"
    bucket = f"dynamic-policy-{account_id}"
    components = get_tags(account_id)
    if not components:
        print("No components were detected.")
        return
    file_loader = FileSystemLoader('templates')
    env = Environment(loader=FileSystemLoader(os.path.abspath(os.path.dirname(__file__))))
    template = env.get_template('/dynamictags.yaml.tmpl')

    output = template.render(components=components, incident_id=incident_id)
    return output


def get_tags(account_id):
    bucket=f"dynamic-policy-{account_id}"
    session = boto3.Session()
    s3_client = session.client("s3")
    f = BytesIO()
    s3_client.download_fileobj(bucket, "components.json", f)
    raw = f.getvalue()
    rawstring = raw.decode("UTF-8")
    try:
        tags_json = json.loads(rawstring)
        tags_json = tags_json.get('tags')
        if tags_json:
            if tags_json.get('components'):
                components = tags_json.get('components')
                print(f"components: {components}")
                if not isinstance(components, list):
                    components = None
        else:
            components = None
        return components
    except json.JSONDecodeError as e:
        print(f"Error occurred while parsing JSON from S3: {e}")
        return None


def exists(dh, dbp, du, dn, region, incident_id):
    token = connect.getdbtoken(DBHostname=dh, Port=dbp, DBUsername=du, Region=region)

    try:
        conn = psycopg2.connect(host=dh, port=dbp, database=dn, user=du,
                                password=token, sslrootcert="global-bundle.cer")
        cur = conn.cursor()
        cur.execute(f"SELECT count(*) from {dn}.incident_configurations where incident_id='{incident_id}';")
        result = cur.fetchone()[0]
        return bool(result)
    except Exception as e:
        print("Database connection failed due to {}".format(e))
        return False


def insert(dh, dbp, du, dn, region, incident_id):
    token = connect.getdbtoken(DBHostname=dh, Port=dbp, DBUsername=du, Region=region)
    customer=incident_id.split("_")[0]
    
    try:
        conn = psycopg2.connect(host=dh, port=dbp, database=dn, user=du,
                                password=token, sslrootcert="global-bundle.cer")
        cur = conn.cursor()
        query=f"INSERT INTO {dn}.incident_configurations (incident_id, incident_type, category, title, guideline, severity, lacework_violation_id, prowler_violation_id, checkov_check_id, remediation_ids, condition_query, is_custom, customer_name, resource_types, provider, created_by, code, constructive_title, descriptive_title, pc_policy_id, frameworks, pc_severity, source_incident_id, additional_pc_policy_ids) VALUES ('{incident_id}', 'Violation', 'General', 'Ensure Security group has correct tags', 'url to guideline', 'MEDIUM', NULL, NULL, '{incident_id}','{{}}', NULL, true, '{customer}', '{{aws_security_group}}', 'AWS', NULL, NULL, 'constructive', 'descriptive', NULL, '{{Terraform}}', NULL, NULL, NULL);"
        cur.execute(query)
        
        conn.commit()
        # Close communication with the database
        cur.close()
        conn.close()
        print("**Record inserted**")
        return True
    except Exception as e:
        print("Database connection failed due to {}".format(e))
        return False
