#!/bin/bash

FILE="${MYSQL_DATABASE}-$(date +"%Y%m%d%H%M%S").sql"
COMPRESSED_FILE="${FILE}.gz"
rm *.gz || true

mysqldump --opt --user=root --password=${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE} | gzip -9 > "${COMPRESSED_FILE}"
ls -l ${COMPRESSED_FILE}

azurectl --account-name "${AZURE_ACCOUNT_NAME}" --account-key "${AZURE_ACCOUNT_KEY}" upload --container "${AZURE_CONTAINER}" --blob "backup/${COMPRESSED_FILE}" "${COMPRESSED_FILE}"
