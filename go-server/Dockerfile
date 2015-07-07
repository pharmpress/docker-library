
FROM java:openjdk-7u79-jdk

ENV DEBIAN_FRONTEND noninteractive

ENV GO_SERVER_PORT 8153

# TODO find the key file of the repository
# RUN apt-key adv --keyserver hkp://thoughtworks.com:80 --recv C2518248EEA14886
# RUN echo 'deb http://download01.thoughtworks.com/go/debian contrib/' | sudo tee /etc/apt/sources.list.d/go-cd.list
# RUN apt-get -q -y update && apt-get -q -y --force-yes install supervisor libapparmor1 go-server

RUN wget -O /tmp/go-server.deb http://download.go.cd/gocd-deb/go-server-15.1.0-1863.deb && dpkg -i /tmp/go-server.deb && rm /tmp/go-server.deb

ADD run-go-server.sh /run-go-server.sh

CMD /run-go-server.sh