-- Type: incident_category
-- DROP TYPE IF EXISTS "platform2".incident_category;
CREATE TYPE "platform2".incident_category AS ENUM (
    'IAM',
    'Monitoring',
    'Networking',
    'Kubernetes',
    'General',
    'Compute',
    'Storage',
    'Secrets',
    'Public',
    'Vulnerabilities',
    'Drift',
    'VCS'
);

ALTER TYPE "platform2".incident_category OWNER TO root;

