FROM pharmpress/java

MAINTAINER Mark Williams <mark.williams@rpharms.com>

ENV NODEJS_VERSION v8.11.2
ENV PYTHON_VERSION=2.7.12-r0
ENV PY_PIP_VERSION=8.1.2-r0
ENV SUPERVISOR_VERSION=3.3.0
ENV NPM_VERSION 5.8.0
ENV CONFIG_FLAGS "--fully-static"
ENV DEL_PKGS "libgcc libstdc++"
ENV RM_DIRS /usr/include


RUN apk update && apk add --no-cache curl make gcc g++ python linux-headers paxctl libgcc libstdc++ gnupg python=$PYTHON_VERSION py-pip=$PY_PIP_VERSION && \
  pip install supervisor==$SUPERVISOR_VERSION && \
  gpg --keyserver ha.pool.sks-keyservers.net --recv-keys \
    9554F04D7259F04124DE6B476D5A82AC7E37093B \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    0034A06D9D9B0064CE8ADF6BF1747F4AD2306D93 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
    B9AE9905FFD7803F25714661B63B535A4C206CA9 \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
    7937DFD2AB06298B2293C3187D33FF9D0246406D \
    114F43EE0176B71C7BC219DD50A3051F888C628D && \
  curl -o node-${NODEJS_VERSION}.tar.gz -sSL https://nodejs.org/dist/${NODEJS_VERSION}/node-${NODEJS_VERSION}.tar.gz && \
  curl -o SHASUMS256.txt.asc -sSL https://nodejs.org/dist/${NODEJS_VERSION}/SHASUMS256.txt.asc && \
  gpg --verify SHASUMS256.txt.asc && \
  grep node-${NODEJS_VERSION}.tar.gz SHASUMS256.txt.asc | sha256sum -c - && \
  tar -zxf node-${NODEJS_VERSION}.tar.gz && \
  cd node-${NODEJS_VERSION} && \
  export GYP_DEFINES="linux_use_gold_flags=0" && \
  ./configure --prefix=/usr ${CONFIG_FLAGS} && \
  NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
  make -j${NPROC} -C out mksnapshot BUILDTYPE=Release && \
  paxctl -cm out/Release/mksnapshot && \
  make -j${NPROC} && \
  make install && \
  paxctl -cm /usr/bin/node && \
  cd / && \
  if [ -x /usr/bin/npm ]; then \
    npm install -g npm@${NPM_VERSION} && \
    find /usr/lib/node_modules/npm -name test -o -name .bin -type d | xargs rm -rf; \
  fi && \
  apk del curl make gcc g++ python linux-headers paxctl gnupg ${DEL_PKGS} && \
  rm -rf /node-${NODEJS_VERSION}.tar.gz /SHASUMS256.txt.asc /node-${NODEJS_VERSION} ${RM_DIRS} \
    /usr/share/man /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp /root/.gnupg \
    /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html

RUN mkdir /var/log/supervisor/ && mkdir /etc/supervisor/ mkdir /etc/supervisor/conf.d/
ADD supervisord.conf /etc/supervisor/supervisord.conf
