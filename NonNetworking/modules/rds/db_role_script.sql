-- Note: Need to run this script manually 

-- Create databases -- (Execute one by one)
CREATE DATABASE "authentication_service";
CREATE DATABASE "dev-orbit";
CREATE DATABASE "sparc_service";


-- Create readonly role
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'readonly') THEN
        CREATE ROLE readonly;
    END IF;
END
$$;

-- Create readwrite role
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'readwrite') THEN
        CREATE ROLE readwrite;
    END IF;
END
$$;

-- Create user and assign role 
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'app_user1') THEN
        CREATE USER app_user1 WITH PASSWORD 'some_secret_passwd';
    END IF;
END
$$;

GRANT readwrite TO app_user1;


-- Need to run this for each database and replace current_database with the actual database name

-- Revoke default privileges from PUBLIC role
REVOKE CREATE ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON DATABASE current_database FROM PUBLIC;

-- readonly role grants
GRANT CONNECT ON DATABASE current_database TO readonly;
GRANT USAGE ON SCHEMA public TO readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readonly;


-- writeonly role grants
GRANT CONNECT ON DATABASE current_database TO readwrite;
GRANT USAGE, CREATE ON SCHEMA public TO readwrite;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO readwrite;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO readwrite;

GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO readwrite;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE ON SEQUENCES TO readwrite;

