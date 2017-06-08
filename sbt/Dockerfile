FROM pharmpress/java

ENV CONSCRIPT_HOME "/root/.conscript"
ENV CONSCRIPT_OPTS="-XX:MaxPermSize=512M -Dfile.encoding=UTF-8"
ENV PATH "$CONSCRIPT_HOME/bin:$PATH"

RUN apk update && apk add ca-certificates openssl vim && update-ca-certificates

RUN wget https://raw.githubusercontent.com/foundweekends/conscript/master/setup.sh -O - | sh || true
RUN cs sbt/sbt --branch 0.13

