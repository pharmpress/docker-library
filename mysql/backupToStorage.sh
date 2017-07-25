 #!/bin/bash

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit 1
fi

DATABASE="${1}"
ENVIRONMENT="${2}"
TIMESTAMP="$(date +"%Y%m%d%H%M%S")"
FILE="${DATABASE}-${ENVIRONMENT}-${TIMESTAMP}.sql"
COMPRESSED_FILE="${FILE}.gz"

mysqldump --opt --protocol=TCP --host=${MYSQL_HOST} --user=root --password=${MYSQL_ROOT_PASSWORD} --databases "${DATABASE}" | gzip -9 > "${COMPRESSED_FILE}"
ls -l ${COMPRESSED_FILE}

storagectl --account-name "${STORAGE_ACCOUNT_NAME}" --account-key "${STORAGE_ACCOUNT_KEY}" "${STORAGE_ENGINE}" upload --container "${STORAGE_CONTAINER}" --blob "backup/${COMPRESSED_FILE}" "${COMPRESSED_FILE}"

rm "${COMPRESSED_FILE}"
