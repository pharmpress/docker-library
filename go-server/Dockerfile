
FROM java:7

MAINTAINER Ramiro Calle <ramiro.calle@rpharms.com>

ENV DEBIAN_FRONTEND noninteractive

ENV GO_SERVER_PORT 8153
ENV GO_SERVER_SSL_PORT 8154

ENV SERVER_MEM 512m
ENV SERVER_MAX_MEM 1024m
ENV SERVER_MAX_PERM_GEN 256m
ENV SERVER_MIN_PERM_GEN 128m
ENV SERVER_WORK_DIR=/var/lib/go-server

ENV JAVA_HOME "/usr/lib/jvm/java-7-openjdk-amd64/jre"

RUN curl -L https://bintray.com/user/downloadSubjectPublicKey?username=gocd | apt-key add -
RUN echo "deb http://dl.bintray.com/gocd/gocd-deb /" | tee -a /etc/apt/sources.list
RUN apt-get -q -y update && apt-get -q -y --force-yes install go-server

CMD DAEMON=N MANUAL_SETTING=Y /usr/share/go-server/server.sh