FROM java:openjdk-7u79-jdk

MAINTAINER Ramiro Calle <ramiro.calle@rpharms.com>

ENV FITNESSE_PORT 8080

ADD http://www.fitnesse.org/fitnesse-standalone.jar?responder=releaseDownload&release=20150424 /opt/fitnesse/fitnesse.jar

ADD https://repo1.maven.org/maven2/smartrics/restfixture/smartrics-RestFixture/4.0/smartrics-RestFixture-4.0-bin.zip /opt/fitnesse/smartrics-RestFixture-4.0-bin.zip

WORKDIR /opt/fitnesse/

RUN unzip /opt/fitnesse/smartrics-RestFixture-4.0-bin.zip && rm /opt/fitnesse/smartrics-RestFixture-4.0-bin.zip

CMD java -jar /opt/fitnesse/fitnesse.jar -p $FITNESSE_PORT
