#!/bin/bash


sed -ri -e "s|GO_SERVER_PORT=.*$|GO_SERVER_PORT=${GO_SERVER_PORT:=127.0.0.1}|g" /etc/default/go-server

sed -ri -e "s|DAEMON=Y|DAEMON=N|g" /etc/default/go-server


/usr/share/go-server/server.sh
