FROM openjdk:8-jdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
RUN apt-get update && apt-get install -y \
  curl gettext-base postgresql-client \
  && rm -rf /var/lib/apt/lists/*

RUN curl -o /usr/local/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-latest" && chmod +x /usr/local/bin/digdag

COPY entrypoint.sh /usr/local/bin
COPY server.properties /etc/digdag/server.properties
COPY params.yml /etc/digdag/params.yml
COPY env /etc/digdag/env
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]