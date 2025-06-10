--- CREATE NEW USER FROM CLI
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = :'user') THEN
        CREATE ROLE :'user' WITH LOGIN PASSWORD :'pw';
    END IF;
END
$$







