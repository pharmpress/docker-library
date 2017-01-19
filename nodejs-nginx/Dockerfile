FROM pharmpress/nodejs

RUN apk update && apk add --no-cache nginx && rm -rf /tmp/* /var/cache/apk/*

ADD nginx.conf /etc/nginx/nginx.conf

