FROM bandsintown/alpine:3.5

# Install Java 8
RUN apk update && \
    apk upgrade && \
    apk add openjdk8 openssl && \
    rm -rf /var/cache/apk/*

# Install elasticsearch user
RUN adduser -D -u 1000 -h /usr/share/elasticsearch elasticsearch

ARG ELASTIC_VERSION
ARG ES_DOWNLOAD_URL
ARG ES_JAVA_OPTS

ENV PATH /usr/share/elasticsearch/bin:$PATH
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV ES_JAVA_OPTS=$ES_JAVA_OPTS

WORKDIR /usr/share/elasticsearch

# Download/extract defined ES version. busybox tar can't strip leading dir.
RUN wget ${ES_DOWNLOAD_URL}/elasticsearch-${ELASTIC_VERSION}.tar.gz && \
    EXPECTED_SHA=$(wget -O - ${ES_DOWNLOAD_URL}/elasticsearch-${ELASTIC_VERSION}.tar.gz.sha1) && \
    test $EXPECTED_SHA == $(sha1sum elasticsearch-${ELASTIC_VERSION}.tar.gz | awk '{print $1}') && \
    tar zxf elasticsearch-${ELASTIC_VERSION}.tar.gz && \
    chown -R elasticsearch:elasticsearch elasticsearch-${ELASTIC_VERSION} && \
    mv elasticsearch-${ELASTIC_VERSION}/* . && \
    rmdir elasticsearch-${ELASTIC_VERSION} && \
    rm elasticsearch-${ELASTIC_VERSION}.tar.gz

RUN set -ex && for esdirs in config data logs; do \
        mkdir -p "$esdirs"; \
        chown -R elasticsearch:elasticsearch "$esdirs"; \
    done

USER elasticsearch

# Install xpack, discovery-ec2 and consul-discovery plugins
RUN elasticsearch-plugin install --batch x-pack && \
    elasticsearch-plugin install discovery-ec2 && \
    wget https://github.com/vvanholl/elasticsearch-consul-discovery/releases/download/${ELASTIC_VERSION}/elasticsearch-consul-discovery-${ELASTIC_VERSION}.zip && \
    bin/elasticsearch-plugin install file:////usr/share/elasticsearch/elasticsearch-consul-discovery-${ELASTIC_VERSION}.zip && \
    rm elasticsearch-consul-discovery-${ELASTIC_VERSION}.zip


COPY elasticsearch.yml config/
COPY log4j2.properties config/
COPY bin/es-docker bin/es-docker

USER root
RUN chown elasticsearch:elasticsearch config/elasticsearch.yml config/log4j2.properties bin/es-docker && \
    chmod 0750 bin/es-docker

CMD ["su-exec", "elasticsearch", "bin/es-docker"]

EXPOSE 9200 9300