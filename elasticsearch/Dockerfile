FROM elasticsearch:1.7.5

#https://github.com/weaveworks/weave/issues/68
RUN sed 's/^hosts:\([\ ]+\)files dns$/hosts:\1dns files/' -i /etc/nsswitch.conf

RUN /usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head/1.x

RUN /usr/share/elasticsearch/bin/plugin install elasticsearch/elasticsearch-cloud-azure/2.8.2
