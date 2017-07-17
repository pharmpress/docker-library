#!/bin/bash
set -e

mysql -uroot -p${MYSQL_ROOT_PASSWORD} <<-EOSQL
    CREATE DATABASE IF NOT EXISTS workflowmanager;
    CREATE DATABASE IF NOT EXISTS idmanager;
    CREATE DATABASE IF NOT EXISTS sources;
    CREATE DATABASE IF NOT EXISTS interactions;
    CREATE USER IF NOT EXISTS pharmpress;
    SET PASSWORD FOR pharmpress = PASSWORD('${PHARMPRESS_PASSWORD}');
    GRANT ALL ON *.* TO pharmpress;
    FLUSH PRIVILEGES;
EOSQL
