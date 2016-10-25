FROM jenkins:alpine

USER root

ENV SBT_VERSION 0.13.12
ENV SBT_HOME /usr/share/sbt
ENV PATH ${PATH}:${SBT_HOME}/bin

RUN apk add --no-cache --update bash \
 && wget -q -O - "http://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz" | gunzip | tar -x -C /usr/share \
 && echo -ne "- with sbt $SBT_VERSION\n" >> /root/.builtremove 

USER jenkins
