CREATE TABLE IF NOT EXISTS "platform2".tenants
(
    id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT tenants_pkey PRIMARY KEY (id),
    CONSTRAINT "PK_tenants_id" UNIQUE (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "platform2".tenants
    OWNER to root;

REVOKE ALL ON TABLE "platform2".tenants FROM read_only;

GRANT ALL ON TABLE "platform2".tenants TO root;

GRANT SELECT ON TABLE "platform2".tenants TO read_only;
