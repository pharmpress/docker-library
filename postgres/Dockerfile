FROM postgres:9.6.3

ENV PHARMPRESS_PASSWORD <SET_SECRET>

RUN apt-get -y update \
 && apt-get -y install ca-certificates curl nano \
 && apt-get -y --purge autoremove \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -L -o /usr/local/bin/storagectl https://github.com/pharmpress/storagectl/releases/download/v0.0.1/storagectl-linux-amd64 && \
    chmod +x /usr/local/bin/storagectl

ADD backupToStorage.sh /usr/local/bin/backupToStorage.sh
ADD restoreFromStorage.sh /usr/local/bin/restoreFromStorage.sh
RUN chmod +x /usr/local/bin/*Storage.sh

COPY init-dbs.sh /docker-entrypoint-initdb.d
