FROM datadog/docker-dd-agent

ADD etcd.yaml /etc/dd-agent/conf.d/etcd.yaml

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["supervisord", "-n", "-c", "/etc/dd-agent/supervisor.conf"]
