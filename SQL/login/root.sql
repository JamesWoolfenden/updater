-- Role: root
-- DROP ROLE IF EXISTS root;

CREATE ROLE root WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  CREATEDB
  CREATEROLE
  NOREPLICATION
  VALID UNTIL 'infinity';

GRANT rds_superuser TO root;
