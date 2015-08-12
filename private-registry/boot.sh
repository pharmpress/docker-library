#!/bin/bash

function getFileFromEtcd {
	filePath=$1
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

for file in "$@"
do
    getFileFromEtcd "$file"
done

echo "[$0] finish."
