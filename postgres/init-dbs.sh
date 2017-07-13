#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER pharmpress WITH PASSWORD '${PHARMPRESS_PASSWORD}';
    CREATE DATABASE workflowmanager;
	CREATE DATABASE idmanager;
	CREATE DATABASE sources;
	CREATE DATABASE interactions;
	GRANT ALL PRIVILEGES ON DATABASE workflowmanager TO pharmpress;
	GRANT ALL PRIVILEGES ON DATABASE idmanager TO pharmpress;
	GRANT ALL PRIVILEGES ON DATABASE sources TO pharmpress;
	GRANT ALL PRIVILEGES ON DATABASE interactions TO pharmpress;
EOSQL
