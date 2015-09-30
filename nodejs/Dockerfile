FROM java:7

MAINTAINER Ramiro Calle <ramiro.calle@rpharms.com>

ENV DEBIAN_FRONTEND noninteractive

ENV NODEJS_VERSION 0.12.7

RUN apt-get -q -y update && apt-get -q -y install make build-essential 

# Install Node.js
RUN curl -sSL http://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}.tar.gz  | tar -C /tmp -xz && \
    cd /tmp/node-v* && \
    ./configure && \
    CXX="g++ -Wno-unused-local-typedefs" make && \
    CXX="g++ -Wno-unused-local-typedefs" make install && \
    rm -rf /tmp/node-v* && \
    echo '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bashrc
 
RUN apt-get remove --purge -y build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

