FROM java:7

ENV SONATYPE_WORK /sonatype-work
ENV NEXUS_VERSION 2.2.1

RUN mkdir -p /opt/sonatype/
RUN curl -sSL --fail --retry 3 https://download.sonatype.com/nexus/oss/nexus-${NEXUS_VERSION}-bundle.tar.gz | tar -xz -C /tmp
RUN mv /tmp/nexus-${NEXUS_VERSION} /opt/sonatype/nexus && rm -rf /tmp/nexus-${NEXUS_VERSION}

ADD nexus.properties /opt/sonatype/nexus/conf/nexus.properties

RUN useradd -r -u 200 -m -c "nexus role account" -d ${SONATYPE_WORK} -s /bin/false nexus

VOLUME ${SONATYPE_WORK}

EXPOSE 8081
WORKDIR /opt/sonatype/nexus


USER nexus
ENV CONTEXT_PATH /
ENV MAX_HEAP 768m
ENV MIN_HEAP 256m
ENV JAVA_OPTS -server -XX:MaxPermSize=192m -Djava.net.preferIPv4Stack=true
ENV LAUNCHER_CONF ./conf/jetty.xml
CMD java \
  -Dnexus-work=${SONATYPE_WORK} -Dnexus-webapp-context-path=${CONTEXT_PATH} \
  -Xms${MIN_HEAP} -Xmx${MAX_HEAP} \
  -cp 'conf/:lib/*' \
  ${JAVA_OPTS} \
  org.sonatype.nexus.bootstrap.Launcher ${LAUNCHER_CONF}
