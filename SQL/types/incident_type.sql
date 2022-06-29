-- Type: incident_type
-- DROP TYPE IF EXISTS "platform2".incident_type;
CREATE TYPE "platform2".incident_type AS ENUM (
    'Violation',
    'Alert',
    'Insight'
);

ALTER TYPE "platform2".incident_type OWNER TO root;

