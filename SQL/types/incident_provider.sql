-- Type: incident_provider
-- DROP TYPE IF EXISTS "platform2".incident_provider;
CREATE TYPE "platform2".incident_provider AS ENUM (
    'AWS',
    'GCP',
    'Azure',
    'Kubernetes',
    'Docker',
    'DockerImage',
    'Git',
    'Vulnerabilities',
    'Bridgecrew',
    'Linode',
    'OCI',
    'OpenStack',
    'DigitalOcean',
    'PANOS',
    'OpenAPI'
);

ALTER TYPE "platform2".incident_provider OWNER TO root;

