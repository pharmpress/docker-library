 #!/bin/bash

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit 1
fi

FILE="${1}-$(date +"%Y%m%d%H%M%S").sql"
COMPRESSED_FILE="${FILE}.gz"

mysqldump --opt --protocol=TCP --host=${MYSQL_HOST} --user=root --password=${MYSQL_ROOT_PASSWORD} --all-databases | gzip -9 > "${COMPRESSED_FILE}"
ls -l ${COMPRESSED_FILE}

azurectl --account-name "${AZURE_ACCOUNT_NAME}" --account-key "${AZURE_ACCOUNT_KEY}" upload --container "${AZURE_CONTAINER}" --blob "backup/${COMPRESSED_FILE}" "${COMPRESSED_FILE}"
