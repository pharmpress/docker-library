FROM pharmpress/java

ENV PYTHON_VERSION=2.7.12-r0
ENV PY_PIP_VERSION=8.1.2-r0
ENV SUPERVISOR_VERSION=3.3.0

RUN apk update \
 && apk add --no-cache curl nginx python=$PYTHON_VERSION py-pip=$PY_PIP_VERSION \
 && pip install supervisor==$SUPERVISOR_VERSION \
 && mkdir /var/log/supervisor/ && mkdir /etc/supervisor/ mkdir /etc/supervisor/conf.d/ \
 && rm -rf /tmp/* /var/cache/apk/*


ADD supervisord.conf /etc/supervisor/supervisord.conf
ADD nginx.conf /etc/nginx/nginx.conf
ADD nginx.supervisor.conf /etc/supervisor/conf.d/nginx.supervisor.conf
