#!/bin/bash

RESTORE_FILE=${1:-${MYSQL_RESTORE_VERSION}}

COMPRESSED_FILE="${RESTORE_FILE}.sql.gz"
FILE="${COMPRESSED_FILE%.gz}"
rm *.sql || true

azurectl --account-name "${AZURE_ACCOUNT_NAME}" --account-key "${AZURE_ACCOUNT_KEY}" download --container "${AZURE_CONTAINER}" --blob "backup/${COMPRESSED_FILE}" "${COMPRESSED_FILE}"
gunzip "${COMPRESSED_FILE}"


cat "${FILE}" <(echo "FLUSH PRIVILEGES ;") | mysql -h "${MYSQL_HOST}" -uroot -p${MYSQL_ROOT_PASSWORD} mysql
