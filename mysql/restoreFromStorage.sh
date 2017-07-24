#!/bin/bash

DATABASE="${1}"
ENVIRONMENT="${2}"
TIMESTAMP="${3}"
FILE="${DATABASE}-${ENVIRONMENT}-${TIMESTAMP}.sql"
COMPRESSED_FILE="${FILE}.gz"

rm -f *.sql

storagectl --account-name "${STORAGE_ACCOUNT_NAME}" --account-key "${STORAGE_ACCOUNT_KEY}" "${STORAGE_ENGINE}" download --container "${STORAGE_CONTAINER}" --blob "backup/${COMPRESSED_FILE}" "${COMPRESSED_FILE}"
gunzip "${COMPRESSED_FILE}"

cat "${FILE}" | mysql -uroot -p${MYSQL_ROOT_PASSWORD} "${1}"
