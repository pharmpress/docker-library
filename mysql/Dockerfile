FROM mysql

RUN apt-get -y update && \
    apt-get -y install ca-certificates curl nano && \
    apt-get -y --purge autoremove && \
	apt-get -y clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -L -o /usr/local/bin/azurectl https://github.com/rrramiro/azurectl/releases/download/v0.0.1/azurectl-linux-amd64 && \
    chmod +x /usr/local/bin/azurectl

ADD backupToAzure.sh /usr/local/bin/backupToAzure.sh
ADD restoreFromAzure.sh /usr/local/bin/restoreFromAzure.sh
RUN chmod +x /usr/local/bin/*Azure.sh

WORKDIR /tmp
