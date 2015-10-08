#!/bin/bash

baseKey=$ETCD_BOOTSTRAP_BASE_KEY

etcdctl get "${baseKey}" > /dev/null
if [ "$?" = "0" ]
then
	echo "[boot] bootstrap key $baseKey"
  for key in  $(etcdctl ls -p --recursive ${baseKey}  | grep -v "/$" )
  do
      filePath=${key#$baseKey}
      if [ ! -e "$filePath" ]
      then
          echo "[boot] try to get ${filePath}"
          if [ ! -d $(dirname "${filePath}") ]
          then
              mkdir -p $(dirname "${filePath}")
          fi
          etcdctl get "${key}" > "$filePath"
          echo "[boot] get $filePath from etcd"
      fi
  done
fi

# Fail hard and fast
set -eo pipefail

echo "[boot] booting container. ETCD: $ETCDCTL_PEERS"

# Loop until confd has updated the nginx config
until confd -debug -onetime ; do
  echo "[boot] waiting for confd ..."
  sleep 5
done
