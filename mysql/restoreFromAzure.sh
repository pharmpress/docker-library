#!/bin/bash

COMPRESSED_FILE="${MYSQL_DATABASE}-${1}.sql.gz"
FILE="${COMPRESSED_FILE%.gz}"
rm *.sql || true

azurectl --account-name "${AZURE_ACCOUNT_NAME}" --account-key "${AZURE_ACCOUNT_KEY}" download --container "${AZURE_CONTAINER}" --blob "backup/${COMPRESSED_FILE}" "${COMPRESSED_FILE}"
gunzip "${COMPRESSED_FILE}"

mysql -h "${MYSQL_HOST}" -u root "${MYSQL_DATABASE}" < "${FILE}"
