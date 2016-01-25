FROM elasticsearch:1.7.4

ENV ETCDCTL_PEERS 127.0.0.1:4001

RUN /usr/share/elasticsearch/bin/plugin --url https://github.com/pharmpress/elasticsearch-cloud-etcd/releases/download/2.1/elasticsearch-cloud-etcd-2.1.zip  --install  elasticsearch-cloud-etcd-2.1

RUN /usr/share/elasticsearch/bin/plugin install elasticsearch/elasticsearch-cloud-azure/2.8.2
