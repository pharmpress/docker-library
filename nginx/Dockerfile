FROM nginx

ENV CONFD_VERSION 0.10.0
ENV ETCD_VERSION 2.0.8
ENV ETCD_BOOTSTRAP_BASE_KEY /bootstrap
ENV ETCDCTL_PEERS 127.0.0.1:4001

RUN apt-get update && \
    apt-get install -y supervisor wget curl nano && \
    rm -rf /var/lib/apt/lists/*

RUN wget -O /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64  && \
	chmod a+x /usr/local/bin/confd

RUN curl -L https://github.com/coreos/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz | tar xz -C /tmp/ && \
 	cp /tmp/etcd-v${ETCD_VERSION}-linux-amd64/etcdctl /usr/local/bin/etcdctl && \
 	rm -rf /tmp/etcd-v*

ADD ./boot.sh					/boot.sh
ADD ./nginx_supervisord.conf    /etc/supervisor/conf.d/nginx.conf

CMD ["nginx", "-g", "daemon off;"]