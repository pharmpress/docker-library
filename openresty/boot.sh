#!/bin/bash

# Fail hard and fast
set -eo pipefail

echo "[boot] booting container. ETCD: $ETCDCTL_PEERS"

# Loop until confd has updated the nginx config
until confd -debug -onetime ; do
  echo "[boot] waiting for confd ..."
  sleep 5
done
