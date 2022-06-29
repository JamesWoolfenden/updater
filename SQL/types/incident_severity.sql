-- DROP TYPE IF EXISTS "platform2".incident_severity;
CREATE TYPE "platform2".incident_severity AS ENUM (
    'LOW',
    'MEDIUM',
    'HIGH',
    'CRITICAL'
);

ALTER TYPE "platform2".incident_severity OWNER TO root;

