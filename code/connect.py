import psycopg2
import sys
import boto3
import os

def getdbtoken(DBHostname, Port, DBUsername, Region):
    session = boto3.Session()
    client = session.client('rds')
    return client.generate_db_auth_token(DBHostname=DBHostname, Port=Port, DBUsername=DBUsername, Region=Region)


def test_connect(dh, dbp, du, dn, REGION):

    token = getdbtoken(DBHostname=dh, Port=dbp, DBUsername=du, Region=REGION)

    try:
        conn = psycopg2.connect(host=dh, port=dbp, database=dn, user=du, password=token, sslrootcert="global-bundle.cer")
        cur = conn.cursor()
        cur.execute("""SELECT now()""")
        query_results = cur.fetchall()
        print(query_results)
    except Exception as e:
        print("Database connection failed due to {}".format(e))  

