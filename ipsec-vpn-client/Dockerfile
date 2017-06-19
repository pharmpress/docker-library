FROM ubuntu:16.04

RUN echo "\n34.251.195.193  vpn.pharmpress.net" >> /etc/hosts

RUN apt-get update && apt-get -y install wget kmod \
        libstrongswan libstrongswan-extra-plugins libstrongswan-standard-plugins strongswan \
        strongswan-charon strongswan-ike strongswan-ikev2 strongswan-libcharon \
        strongswan-starter

ADD ./confd       /etc/confd
ADD ./boot.sh     /boot.sh

RUN wget -O /etc/ipsec.d/cacerts/pharmpress.net.crt http://vpn.pharmpress.net/cacert.crt \
 && wget -O /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 \
 && chmod +x /boot.sh && chmod +x /usr/local/bin/confd
