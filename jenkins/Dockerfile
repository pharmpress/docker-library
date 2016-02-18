FROM jenkins:1.642.1

USER root

RUN curl -L https://bintray.com/user/downloadSubjectPublicKey?username=sbt | apt-key add -
RUN echo "deb http://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list
RUN apt-get update && apt-get install -y sbt && rm -rf /var/lib/apt/lists/*

USER jenkins