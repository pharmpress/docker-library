FROM postgres:9.6.3

ENV PHARMPRESS_PASSWORD <SET_SECRET>

RUN apt-get -y update \
 && apt-get -y install curl \
 && apt-get -y --purge autoremove \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -L -o /usr/local/bin/azurectl https://github.com/pharmpress/azurectl/releases/download/v0.0.4/azurectl-linux-amd64 && \
    chmod +x /usr/local/bin/azurectl

COPY init-dbs.sh /docker-entrypoint-initdb.d
