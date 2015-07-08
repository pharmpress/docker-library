FROM elasticsearch:1.4.5

ENV ETCDCTL_PEERS 127.0.0.1:4001

RUN /usr/share/elasticsearch/bin/plugin --url https://github.com/pharmpress/elasticsearch-cloud-etcd/releases/download/2.0/elasticsearch-cloud-etcd-2.0.zip  --install  elasticsearch-cloud-etcd-2.0


