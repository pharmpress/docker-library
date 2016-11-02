FROM alpine:3.2

RUN apk update \
    && apk add curl squid \
    && rm -rf /var/cache/apk/*

RUN echo >> /etc/squid/squid.conf && echo "shutdown_lifetime 3 seconds" >> /etc/squid/squid.conf

EXPOSE 3128

CMD squid -NYCd 1
