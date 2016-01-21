
FROM java:8

ENV DEBIAN_FRONTEND noninteractive

RUN curl -L https://bintray.com/user/downloadSubjectPublicKey?username=gocd | apt-key add -
RUN curl -L https://bintray.com/user/downloadSubjectPublicKey?username=sbt | apt-key add -
RUN echo "deb http://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list
RUN echo "deb http://dl.bintray.com/gocd/gocd-deb /" | tee -a /etc/apt/sources.list
RUN apt-get -q -y update && apt-get -q -y --force-yes install libdevmapper1.02.1 libapparmor1 jq sbt go-agent nano gcc libc6-dev make python-pip python-dev expect --no-install-recommends

RUN pip install envtpl

# fix docker: error while loading shared libraries: libdevmapper.so.1.02: cannot open shared object file: No such file or directory
RUN ln -s /lib/x86_64-linux-gnu/libdevmapper.so.1.02.1 /lib/x86_64-linux-gnu/libdevmapper.so.1.02 && ldconfig

ENV GOLANG_VERSION 1.4.2
ENV GOPATH /go
ENV PATH /go/bin:/usr/src/go/bin:$PATH
RUN curl -sSL https://golang.org/dl/go$GOLANG_VERSION.src.tar.gz | tar -v -C /usr/src -xz
RUN cd /usr/src/go/src && ./make.bash --no-clean 2>&1 && mkdir -p /go/src /go/bin && chmod -R 777 /go

ENV FLEET_VERSION 0.10.2
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


RUN set -ex \
	&& for key in \
		7937DFD2AB06298B2293C3187D33FF9D0246406D \
		114F43EE0176B71C7BC219DD50A3051F888C628D \
	; do \
		gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
	done

ENV NODE_VERSION 0.12.7
ENV NPM_VERSION 2.14.1
RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
	&& curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
	&& gpg --verify SHASUMS256.txt.asc \
	&& grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
	&& tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
	&& rm "node-v$NODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc \
	&& npm install -g npm@"$NPM_VERSION" \
	&& npm install -g grunt-cli \
	&& npm cache clear

ADD run-go-agent.sh /run-go-agent.sh

CMD /run-go-agent.sh

