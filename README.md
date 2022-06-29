# dynamic-policy-updater

Check for tags on aws_security_group resources, values for tag.component form s3 bucket.

This application genertes new bridgecrew policies when a customer add a new tag file (called components)
to an s3 bucket tht they will have write access to (not public.)

If the customer supplies a role that can write to bucket, we'll attach that role to our bucket.
The upload will trigger a lambda to make a large YML policy based on it and write it to the policies db.

The folder terraform contains the iac that creates all the infra required although it is currently configured for a test environment:
<./tag-updater/terraform/tags.auto.tfvars>

## creates an rds db

- check
  
## connect to it

- check

## connect to iam/ssl instance

You need to grant rds_iam to your specified dbuser to enable iam AUTH:    

```SQL
GRANT rds_iam to DBUSER
```

## write a record in it

- check
  
## update a record in it

- check
  
## construct a policy record based on data read in from s3

<https://docs.aws.amazon.com/lambda/latest/dg/with-s3-example.html>

## Create a template policy in yaml

```yaml
---
---
metadata:
 name: "Check that all security groups resources are tagged with the key for key.component"
 id: "CKV2_AWS_999"
 category: "GENERAL_SECURITY"
scope:
 provider: aws
definition:
  and:
    - or:
      - cond_type: "attribute"
        resource_types:
            - aws_security_group
        attribute: "tags.component"
        operator: contains
        value: "pass"
      - cond_type: "attribute"
        resource_types:
            - aws_security_group
        attribute: "tags.component"
        operator: contains
        value: "correct"

```

## create a lambda layer for psycop2g (SQL lib)

<https://stackoverflow.com/questions/66296869/psycopg2-folder-zipped-into-python-venv-lambda-function>

## Build a new layer zip

run: ./terraform/layer/makezip.sh

