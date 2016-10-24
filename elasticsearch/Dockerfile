FROM pharmpress/java

ENV GOSU_VERSION 1.10
ENV ELASTICSEARCH_VERSION 1.7.5

RUN set -x \
    && sed 's/^hosts:\([\ ]+\)files dns$/hosts:\1dns files/' -i /etc/nsswitch.conf \
    && apk upgrade --update \
    && apk add --update gnupg curl \
	&& curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64" \
	&& curl -o /usr/local/bin/gosu.asc -sSL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64.asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true \
    && curl -fsSL https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz  | tar xzf - -C /usr/share \
    && mv /usr/share/elasticsearch-$ELASTICSEARCH_VERSION /usr/share/elasticsearch \
    && /usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head/1.x \
    && /usr/share/elasticsearch/bin/plugin install elasticsearch/elasticsearch-cloud-azure/2.8.2 \
    && addgroup -S elasticsearch && adduser -S -G elasticsearch elasticsearch \
    && apk del curl && rm -rf /var/cache/apk/*

ENV PATH /usr/share/elasticsearch/bin:$PATH

WORKDIR /usr/share/elasticsearch

RUN set -ex \
	&& for path in \
		./data \
		./logs \
		./config \
		./config/scripts \
	; do \
		mkdir -p "$path"; \
		chown -R elasticsearch:elasticsearch "$path"; \
	done

COPY config ./config

VOLUME /usr/share/elasticsearch/data

COPY ./docker-entrypoint.sh /usr/local/bin

EXPOSE 9200 9300
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["elasticsearch"]
