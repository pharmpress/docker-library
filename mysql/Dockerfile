FROM mysql:5.7.18

RUN apt-get -y update && \
    apt-get -y install ca-certificates curl nano && \
    apt-get -y --purge autoremove && \
	apt-get -y clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -L -o /usr/local/bin/azurectl https://github.com/pharmpress/azurectl/releases/download/v0.0.4/azurectl-linux-amd64 && \
    chmod +x /usr/local/bin/azurectl

ADD backupToAzure.sh /usr/local/bin/backupToAzure.sh
ADD restoreFromAzure.sh /usr/local/bin/restoreFromAzure.sh
RUN chmod +x /usr/local/bin/*Azure.sh

COPY init-dbs.sh /docker-entrypoint-initdb.d
