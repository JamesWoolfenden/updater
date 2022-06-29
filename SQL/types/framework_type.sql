-- Type: framework_type

-- DROP TYPE IF EXISTS "platform2".framework_type;

CREATE TYPE "platform2".framework_type AS ENUM
    ('Terraform', 'CloudFormation', 'Kubernetes', 'Serverless', 'ARM', 'AWS', 'GCP', 'Azure', 'TerraformPlan', 'DockerImage', 'Git', 'Docker', 'Vulnerabilities', 'VCS', 'Bicep', 'Kustomize', 'OpenAPI', 'Helm');

ALTER TYPE "platform2".framework_type
    OWNER TO root;

