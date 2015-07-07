
FROM java:openjdk-7u79-jdk

ENV DEBIAN_FRONTEND noninteractive

# TODO find the key file of the repository
# RUN apt-key adv --keyserver hkp://thoughtworks.com:80 --recv XXXX
#RUN echo 'deb http://download01.thoughtworks.com/go/debian contrib/' | tee /etc/apt/sources.list.d/go-cd.list
#RUN echo "deb http://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list 
#RUN echo "deb-src http://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list
#RUN apt-get -q -y update && apt-get -q -y --force-yes install supervisor libapparmor1 sbt go-agent

RUN wget -O /tmp/go-agent.deb http://download.go.cd/gocd-deb/go-agent-15.1.0-1863.deb && dpkg -i /tmp/go-agent.deb && rm /tmp/go-agent.deb

ADD run-go-agent.sh /run-go-agent.sh

CMD /run-go-agent.sh

