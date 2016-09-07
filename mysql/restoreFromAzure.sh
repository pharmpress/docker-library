#!/bin/bash

VERSION=${1:-${MYSQL_RESTORE_VERSION}}

COMPRESSED_FILE="${MYSQL_DATABASE}-${VERSION}.sql.gz"
FILE="${COMPRESSED_FILE%.gz}"
rm *.sql || true

azurectl --account-name "${AZURE_ACCOUNT_NAME}" --account-key "${AZURE_ACCOUNT_KEY}" download --container "${AZURE_CONTAINER}" --blob "backup/${COMPRESSED_FILE}" "${COMPRESSED_FILE}"
gunzip "${COMPRESSED_FILE}"

# ${MYSQL_ROOT_PASSWORD}

mysql -h "${MYSQL_HOST}" -u "${MYSQL_USER}" -p${MYSQL_PASSWORD} "${MYSQL_DATABASE}" < "${FILE}"
