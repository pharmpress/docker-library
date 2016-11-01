
FROM java:8

MAINTAINER Ramiro Calle <ramiro.calle@rpharms.com>

ENV DEBIAN_FRONTEND noninteractive

ENV GO_SERVER_PORT 8153
ENV GO_SERVER_SSL_PORT 8154

ENV SERVER_MEM 512m
ENV SERVER_MAX_MEM 1024m
ENV SERVER_MAX_PERM_GEN 256m
ENV SERVER_MIN_PERM_GEN 128m
ENV SERVER_WORK_DIR=/var/lib/go-server

ENV GOCD_VERSION 16.11.0-4185

ENV JAVA_HOME "/usr/lib/jvm/java-8-openjdk-amd64/jre"

RUN apt-get -q -y update && apt-get -q -y --force-yes install apt-transport-https

RUN groupadd -r go && useradd -r -c "Go User" -g go -d /var/go -m -s /bin/bash go
RUN mkdir -p /var/lib/go-server/addons /var/log/go-server /etc/go /go-addons
#RUN touch /etc/go/postgresqldb.properties
#RUN chown -R go:go /var/lib/go-server /var/log/go-server /etc/go /go-addons

# RUN curl -L https://bintray.com/user/downloadSubjectPublicKey?username=gocd | apt-key add -
# RUN echo "deb http://dl.bintray.com/gocd/gocd-deb /" | tee -a /etc/apt/sources.list
RUN curl -L https://download.go.cd/GOCD-GPG-KEY.asc | apt-key add -
RUN echo "deb https://download.go.cd /" | tee /etc/apt/sources.list.d/gocd.list

RUN apt-get -q -y update && apt-get -q -y --force-yes install go-server=$GOCD_VERSION && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#USER go
WORKDIR /tmp
VOLUME ["/var/lib/go-server", "/var/log/go-server", "/etc/go", "/go-addons"]
EXPOSE 8153 8154

CMD DAEMON=N MANUAL_SETTING=Y /usr/share/go-server/server.sh
