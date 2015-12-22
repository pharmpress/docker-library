FROM java:8

ENV ARCHIVA_VERSION 2.2.0
ENV MYSQL_CONNECTOR_VERSION 5.1.35

RUN apt-get -q -y update
RUN apt-get -q -y install cron git

#
# Go get the needed tar/jar we'll installing
#
RUN curl -sSLo /apache-archiva-$ARCHIVA_VERSION-bin.tar.gz http://archive.apache.org/dist/archiva/$ARCHIVA_VERSION/binaries/apache-archiva-$ARCHIVA_VERSION-bin.tar.gz \
  && tar xzf apache-archiva-$ARCHIVA_VERSION-bin.tar.gz --directory / \
  && rm /apache-archiva-$ARCHIVA_VERSION-bin.tar.gz && mv /apache-archiva-$ARCHIVA_VERSION /opt/archiva \
  && curl -sSLo /opt/archiva/lib/mysql-connector-java-$MYSQL_CONNECTOR_VERSION.jar http://search.maven.org/remotecontent?filepath=mysql/mysql-connector-java/$MYSQL_CONNECTOR_VERSION/mysql-connector-java-$MYSQL_CONNECTOR_VERSION.jar
  && wget -o /usr/local/bin/git-fat https://raw.githubusercontent.com/jedbrown/git-fat/master/git-fat && chmod a+x /usr/local/bin/git-fat

#
# Adjust ownership and Perform the data directory initialization
#
ADD data_dirs.env /data_dirs.env
ADD init.bash /init.bash
ADD jetty_conf /jetty_conf
# Sync calls are due to https://github.com/docker/docker/issues/9547
RUN useradd -d /opt/archiva/data -m archiva &&\
  cd /opt && chown -R archiva:archiva archiva &&\
  cd / && chown -R archiva:archiva /jetty_conf &&\
  chmod 755 /init.bash &&\
  sync && /init.bash &&\
  sync && rm /init.bash

#
# Add the bootstrap cmd
#
ADD run.bash /run.bash
RUN chmod 755 /run.bash


RUN apt-get -q -y install nano

#
# All data is stored on the root data volume.
# USER archiva

VOLUME ["/archiva-data"]

# Standard web ports exposted
EXPOSE 8080/tcp 8443/tcp

CMD ["/run.bash"]