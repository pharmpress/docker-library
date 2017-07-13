 #!/bin/bash

DATABASE="${1}"
ENVIRONMENT="${2}"
TIMESTAMP="${3}"
FILE="${DATABASE}-${ENVIRONMENT}-${TIMESTAMP}.sql"
COMPRESSED_FILE="${FILE}.gz"

rm -f *.sql

azurectl --account-name "${AZURE_ACCOUNT_NAME}" --account-key "${AZURE_ACCOUNT_KEY}" download --container "${AZURE_CONTAINER}" --blob "backup/${COMPRESSED_FILE}" "${COMPRESSED_FILE}"
gunzip "${COMPRESSED_FILE}"

cat "${FILE}" | psql --username postgres "${DATABASE}"
