FROM registry:2

MAINTAINER Ramiro Calle <ramiro.calle@rpharms.com>

ENV ETCD_VERSION 2.0.8
ENV ETCDCTL_PEERS 127.0.0.1:4001
ENV REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt
ENV REGISTRY_HTTP_TLS_KEY=/certs/domain.key

ADD https://github.com/coreos/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz /tmp/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz

RUN tar xzf /tmp/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz -C /tmp/ && \
        cp /tmp/etcd-v${ETCD_VERSION}-linux-amd64/etcdctl /usr/local/bin/etcdctl && \
        rm -rf /tmp/etcd-v*

ADD ./boot.sh /boot.sh

ENTRYPOINT ["/bin/sh", "-c" ]

CMD /boot.sh ${REGISTRY_HTTP_TLS_CERTIFICATE} ${REGISTRY_HTTP_TLS_KEY} && registry /etc/docker/registry/config.yml
