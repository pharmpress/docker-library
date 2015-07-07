#!/bin/bash

AUTO_REGISTER_FILE=/var/lib/go-agent/config/autoregister.properties

sed -ri -e "s|GO_SERVER=.*$|GO_SERVER=${GO_SERVER:=127.0.0.1}|g"  /etc/default/go-agent

sed -ri -e "s|DAEMON=Y|DAEMON=N|g" /etc/default/go-agent

if [ -e ${AUTO_REGISTER_FILE} ]
then rm ${AUTO_REGISTER_FILE}
fi

if [ -n "$GO_AGENT_AUTO_REGISTER_KEY" ]
then echo "agent.auto.register.key=${GO_AGENT_AUTO_REGISTER_KEY}" >> ${AUTO_REGISTER_FILE}
else echo "GO_AGENT_AUTO_REGISTER_KEY is unset" 
fi


if [ -n "$GO_AGENT_AUTO_REGISTER_RESOURCES" ]
then echo "agent.auto.register.resources=${GO_AGENT_AUTO_REGISTER_RESOURCES}" >> ${AUTO_REGISTER_FILE}
else echo "GO_AGENT_AUTO_REGISTER_RESOURCES is unset" 
fi

if [ -n "$GO_AGENT_AUTO_REGISTER_ENVIRONMENTS" ]
then echo "agent.auto.register.environments=${GO_AGENT_AUTO_REGISTER_ENVIRONMENTS}" >> ${AUTO_REGISTER_FILE}
else echo "GO_AGENT_AUTO_REGISTER_ENVIRONMENTS is unset"
fi

/usr/share/go-agent/agent.sh