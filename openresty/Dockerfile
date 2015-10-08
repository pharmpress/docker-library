FROM debian:jessie


MAINTAINER Ramiro Calle <ramiro.calle@rpharms.com>

ENV DEBIAN_FRONTEND noninteractive
ENV OPENRESTY_VERSION 1.7.10.1
ENV LUAROCKS_VERSION 2.2.0
ENV CONFD_VERSION 0.10.0
ENV ETCD_VERSION 2.0.8
ENV ETCDCTL_PEERS 127.0.0.1:4001
ENV ETCD_BOOTSTRAP_BASE_KEY /bootstrap

#Install supervisor
RUN apt-get -q -y update && apt-get -q -y install supervisor unzip curl ca-certificates nano wget \
	make \
	build-essential \
	libpcre3-dev \
	libssl-dev \
	libexpat1-dev \
	libreadline-dev \
  	libncurses5-dev
	
RUN curl -L http://openresty.org/download/ngx_openresty-${OPENRESTY_VERSION}.tar.gz | tar xz -C /tmp/ && \
  cd /tmp/ngx_openresty-* && \
  ./configure --prefix=/opt/openresty \
    --http-client-body-temp-path=/var/nginx/client_body_temp \
    --http-proxy-temp-path=/var/nginx/proxy_temp \
    --http-log-path=/var/nginx/access.log \
    --error-log-path=/var/nginx/error.log \
    --pid-path=/var/nginx/nginx.pid \
    --lock-path=/var/nginx/nginx.lock \	
	--with-pcre-jit \
	--with-ipv6 \
    --with-luajit \
    --with-luajit-xcflags=-DLUAJIT_ENABLE_LUA52COMPAT \
    --with-md5-asm \
    --with-sha1-asm \
    --with-file-aio \
    --with-http_stub_status_module \
    --with-http_ssl_module \
    --with-http_realip_module \
    --with-http_gunzip_module \
    --without-http_fastcgi_module \
    --without-http_uwsgi_module \
    --without-http_scgi_module \
    --without-http_redis2_module \
 && make \
 && make install \
 && rm -rf /tmp/ngx_openresty*

RUN wget -qO- http://luarocks.org/releases/luarocks-${LUAROCKS_VERSION}.tar.gz | tar xvz -C /tmp/ \
 && cd /tmp/luarocks-* \
 && ./configure --with-lua=/opt/openresty/luajit \
    --with-lua-include=/opt/openresty/luajit/include/luajit-2.1 \
    --with-lua-lib=/opt/openresty/lualib \
 && make && make install \
 && rm -rf /tmp/luarocks-*

RUN ln -sf /opt/openresty/nginx/sbin/nginx /usr/sbin/nginx \
 && ln -sf /opt/openresty/bin/resty /usr/local/bin/resty \
 && ln -sf /opt/openresty/nginx/conf /etc/nginx \
 && ln -sf /opt/openresty/luajit/bin/luajit-2.1.0-alpha /opt/openresty/luajit/bin/lua \
 && ln -sf /opt/openresty/luajit/bin/lua /usr/local/bin/lua \
 && mkdir -p /var/nginx/cache \
 && rm /opt/openresty/nginx/conf/nginx.conf

RUN apt-get remove --purge -y build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget -O /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64  && \
	chmod a+x /usr/local/bin/confd

RUN curl -L https://github.com/coreos/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz | tar xz -C /tmp/ && \
 	cp /tmp/etcd-v${ETCD_VERSION}-linux-amd64/etcdctl /usr/local/bin/etcdctl && \
 	rm -rf /tmp/etcd-v*

ADD ./boot.sh       /boot.sh
ADD ./nginx_supervisord.conf    /etc/supervisor/conf.d/nginx.conf

CMD /boot.sh && supervisord -n
