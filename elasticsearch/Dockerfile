FROM elasticsearch:1.4.5

ENV ETCDCTL_PEERS 127.0.0.1:4001

RUN /usr/share/elasticsearch/bin/plugin --url https://github.com/pharmpress/elasticsearch-cloud-etcd/releases/download/1.0-SNAPSHOT/elasticsearch-cloud-etcd-1.0-SNAPSHOT.zip  --install  elasticsearch-cloud-etcd-1.0-SNAPSHOT


