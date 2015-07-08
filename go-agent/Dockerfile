
FROM java:openjdk-7u79-jdk

ENV DEBIAN_FRONTEND noninteractive

# TODO find the key file of the repository
# RUN apt-key adv --keyserver hkp://thoughtworks.com:80 --recv XXXX
#RUN echo 'deb http://download01.thoughtworks.com/go/debian contrib/' | tee /etc/apt/sources.list.d/go-cd.list
#RUN echo "deb http://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list 
#RUN echo "deb-src http://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list
#RUN apt-get -q -y update && apt-get -q -y --force-yes install supervisor libapparmor1 sbt go-agent


RUN echo "deb http://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list
RUN apt-get -q -y update && apt-get -q -y install libapparmor1 sbt

ENV FLEET_VERSION 0.9.1
RUN wget -O /tmp/fleet-v${FLEET_VERSION}-linux-amd64.tar.gz https://github.com/coreos/fleet/releases/download/v${FLEET_VERSION}/fleet-v${FLEET_VERSION}-linux-amd64.tar.gz && \
	tar zxvf /tmp/fleet-v${FLEET_VERSION}-linux-amd64.tar.gz -C /tmp/ && \
	cp /tmp/fleet-v${FLEET_VERSION}-linux-amd64/fleetctl /usr/local/bin/fleetctl && \
	rm -rf /tmp/fleet-v*

ENV ETCD_VERSION 2.0.8
RUN wget -O /tmp/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz https://github.com/coreos/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz && \
	tar zxvf /tmp/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz -C /tmp/ && \
	cp /tmp/etcd-v${ETCD_VERSION}-linux-amd64/etcdctl /usr/local/bin/etcdctl && \
	rm -rf /tmp/etcd-v*


ENV MAVEN_VERSION 3.3.3
RUN curl -fsSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
ENV MAVEN_HOME /usr/share/maven


RUN wget -O /tmp/go-agent.deb http://download.go.cd/gocd-deb/go-agent-15.1.0-1863.deb && dpkg -i /tmp/go-agent.deb && rm /tmp/go-agent.deb

ADD run-go-agent.sh /run-go-agent.sh

CMD /run-go-agent.sh

