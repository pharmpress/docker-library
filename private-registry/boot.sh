#!/bin/bash

function getFileFromEtcd {
	filePath=$1
	echo "try to get ${filePath}"
	if [ ! -e "$filePath" ]
	then
	  etcdctl get "${filePath//\/[.]/\/_}" > /dev/null
	  if [ "$?" = "0" ]
	  then
	    mkdir -p $(dirname "${filePath}")
	    etcdctl get "${filePath//\/[.]/\/_}" > "$filePath"
	    echo "[boot] get $filePath from etcd"
	  fi
	fi
}

echo "[$0] Get files from etcd"


for file in "${REGISTRY_HTTP_TLS_CERTIFICATE}" "${REGISTRY_HTTP_TLS_KEY}" "${REGISTRY_AUTH_HTPASSWD_PATH}"
do
    getFileFromEtcd "$file"
done

echo "[$0] finish."

registry "$@"
