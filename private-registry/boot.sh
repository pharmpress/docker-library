#!/bin/bash

mkdir -p /certs/

PUBLIC="/certs/public.crt"
PRIVATE="/certs/private.key"

ETCD_BASE_KEY=$1

echo "[boot] check SSL file"

if [ ! -e "$PUBLIC" ] || [ ! -e "$PRIVATE" ]
then
  etcdctl get "$ETCD_BASE_KEY/public.crt" > /dev/null
  publicExists="$?"
  etcdctl get "$ETCD_BASE_KEY/private.key" > /dev/null
  privateExists="$?"

  if [ "$publicExists" = "0" ] && [ "$privateExists" = "0" ]
  then
    etcdctl get "$ETCD_BASE_KEY/public.crt" > "$PUBLIC"
    etcdctl get "$ETCD_BASE_KEY/private.key" > "$PRIVATE"
    echo "[boot] get $PUBLIC from etcd"
    echo "[boot] get $PRIVATE from etcd"
    export REGISTRY_HTTP_TLS_CERTIFICATE="$PUBLIC"
    export REGISTRY_HTTP_TLS_KEY="$PRIVATE"
  fi
fi

echo "[boot] finish $0."