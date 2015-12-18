FROM datadog/docker-dd-agent

ADD etcd.yaml /etc/dd-agent/conf.d/etcd.yaml
ADD http_check.yaml /etc/dd-agent/checks.d/http_check.yaml

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["supervisord", "-n", "-c", "/etc/dd-agent/supervisor.conf"]
