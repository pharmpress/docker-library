
FROM java:openjdk-7u79-jdk

ENV DEBIAN_FRONTEND noninteractive

ENV GO_SERVER_PORT 8153

RUN curl -L https://bintray.com/user/downloadSubjectPublicKey?username=gocd | apt-key add -
RUN echo "deb http://dl.bintray.com/gocd/gocd-deb /" | tee -a /etc/apt/sources.list
RUN apt-get -q -y update && apt-get -q -y --force-yes install go-server

ADD run-go-server.sh /run-go-server.sh

CMD /run-go-server.sh