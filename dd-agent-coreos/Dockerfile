FROM datadog/docker-dd-agent

ADD etcd.yaml       /etc/dd-agent/conf.d/etcd.yaml
ADD http_check.yaml /etc/dd-agent/conf.d/http_check.yaml
ADD nginx.yaml      /etc/dd-agent/conf.d/nginx.yaml

COPY entrypoint.sh /entrypoint.sh
