-- Table: platform2.incident_configurations

-- DROP TABLE IF EXISTS "platform2".incident_configurations;

CREATE TABLE IF NOT EXISTS "platform2".incident_configurations
(
    incident_id character varying(50) COLLATE pg_catalog."default" NOT NULL,
    incident_type "platform2".incident_type NOT NULL,
    category "platform2".incident_category NOT NULL,
    title text COLLATE pg_catalog."default" NOT NULL,
    guideline text COLLATE pg_catalog."default",
    severity "platform2".incident_severity NOT NULL,
    lacework_violation_id character varying(50) COLLATE pg_catalog."default",
    prowler_violation_id character varying(50) COLLATE pg_catalog."default",
    checkov_check_id character varying(50) COLLATE pg_catalog."default",
    remediation_ids text[] COLLATE pg_catalog."default" NOT NULL,
    condition_query jsonb,
    is_custom boolean,
    customer_name character varying(50) COLLATE pg_catalog."default",
    resource_types text[] COLLATE pg_catalog."default",
    provider "platform2".incident_provider DEFAULT 'AWS'::"platform2".incident_provider,
    created_by character varying(64) COLLATE pg_catalog."default",
    code jsonb,
    constructive_title text COLLATE pg_catalog."default",
    descriptive_title text COLLATE pg_catalog."default",
    pc_policy_id character varying(200) COLLATE pg_catalog."default",
    frameworks "platform2".framework_type[] DEFAULT '{Terraform,CloudFormation}'::"platform2".framework_type[],
    pc_severity "platform2".incident_severity,
    source_incident_id character varying(50) COLLATE pg_catalog."default",
    additional_pc_policy_ids character varying(200)[] COLLATE pg_catalog."default",
    CONSTRAINT "PK_5480bcb5a4d95b655357644c312" PRIMARY KEY (incident_id),
    CONSTRAINT "FK_customer_name" FOREIGN KEY (customer_name)
        REFERENCES "platform2".tenants (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "platform2".incident_configurations
    OWNER to root;

REVOKE ALL ON TABLE "platform2".incident_configurations FROM read_only;

GRANT ALL ON TABLE "platform2".incident_configurations TO root;

GRANT SELECT ON TABLE "platform2".incident_configurations TO read_only;