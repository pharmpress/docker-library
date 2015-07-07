FROM debian:wheezy

MAINTAINER Ramiro Calle <ramiro.calle@rpharms.com>

ENV DEBIAN_FRONTEND noninteractive
ENV CONFD_VERSION 0.8.0
ENV COLLECTD_VERSION 5.4.2
ENV COLLECTD_HOSTNAME localhost
ENV COLLECTD_LOGSTASH_SERVER logstash
ENV COLLECTD_LOGSTASH_PORT 25826

RUN apt-get -q -y update && apt-get -q -y install ca-certificates wget curl nano build-essential libcurl4-openssl-dev gnulib

RUN wget -O /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64  && \
	chmod a+x /usr/local/bin/confd

RUN curl -L https://collectd.org/files/collectd-${COLLECTD_VERSION}.tar.gz | tar xz -C /tmp/ && \
	cd /tmp/collectd-${COLLECTD_VERSION} && \
	./configure && \
	make && \
  	make install && \
  	rm -rf /tmp/collectd-*

RUN apt-get remove --purge -y build-essential && \
  	apt-get clean && \
  	rm -rf /var/lib/apt/lists/*

# Create confd directories
RUN mkdir -p /etc/confd/conf.d && \
    mkdir -p /etc/confd/templates && \
    mv /opt/collectd/etc/collectd.conf /opt/collectd/etc/collectd.conf.sample

# Add confd files
ADD ./collectd.d /opt/collectd/etc/collectd.d
ADD ./collectd.conf.tmpl /etc/confd/templates/collectd.conf.tmpl
ADD ./collectd.toml /etc/confd/conf.d/collectd.toml


CMD /usr/local/bin/confd -debug -onetime -backend env && /opt/collectd/sbin/collectd -f -C /opt/collectd/etc/collectd.conf
