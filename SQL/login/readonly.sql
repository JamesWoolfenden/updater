
-- Role: read_only
-- DROP ROLE IF EXISTS read_only;

CREATE ROLE read_only WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  VALID UNTIL 'infinity';
