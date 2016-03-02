FROM java:8

ENV JMETER_VERSION=2.13
ENV JMETER_HOME=/usr/local/apache-jmeter-${JMETER_VERSION}
ENV PATH=${JMETER_HOME}/bin:${PATH}

RUN apt-get -y update && \
    apt-get -y install curl && \
    apt-get -y --purge autoremove && \
	apt-get -y clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -fsSL http://www.eu.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz | tar xzf - -C /usr/local/
RUN rm -rf  ${JMETER_HOME}/bin/examples \
 			${JMETER_HOME}/bin/templates \
 			${JMETER_HOME}/bin/*.cmd \
 			${JMETER_HOME}/bin/*.bat \
 			${JMETER_HOME}/docs \
 			${JMETER_HOME}/printable_docs

ADD jmeter.properties ${JMETER_HOME}/bin/jmeter.properties

EXPOSE 1099 60000

ENTRYPOINT ["jmeter"]

