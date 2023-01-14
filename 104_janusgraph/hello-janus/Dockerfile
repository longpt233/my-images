FROM ubuntu:18.04

ARG JANUS_VERSION=0.6.2

ENV JANUS_VERSION=${JANUS_VERSION} \
    JANUSGRAPH_HOME=/opt/janusgraph

WORKDIR /opt

RUN apt update -y && apt install -y gpg unzip curl && \
    apt install net-tools && \
    apt install htop && \
    curl -fSL https://github.com/JanusGraph/janusgraph/releases/download/v${JANUS_VERSION}/janusgraph-${JANUS_VERSION}.zip -o janusgraph.zip &&\
    curl -fSL https://github.com/JanusGraph/janusgraph/releases/download/v${JANUS_VERSION}/janusgraph-${JANUS_VERSION}.zip.asc -o janusgraph.zip.asc && \
    curl -fSL https://github.com/JanusGraph/janusgraph/releases/download/v${JANUS_VERSION}/KEYS -o KEYS && \
    gpg --import KEYS && \
    gpg --batch --verify janusgraph.zip.asc janusgraph.zip && \
    unzip janusgraph.zip && \
    mv janusgraph-${JANUS_VERSION} /opt/janusgraph && \
    rm -rf ${JANUSGRAPH_HOME}/elasticsearch && \
    rm -rf ${JANUSGRAPH_HOME}/javadocs && \
    rm -rf ${JANUSGRAPH_HOME}/log && \
    rm -rf ${JANUSGRAPH_HOME}/examples && \
    rm -rf ${JANUSGRAPH_HOME}/conf/janusgraph-*.properties && \
    rm -rf ${JANUSGRAPH_HOME}/conf/gremlin-server

# Install OpenJDK-8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get clean;

# Fix certificate issues
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;

# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
RUN export JAVA_HOME

WORKDIR /opt/janusgraph

USER root

COPY pii-schema/conf/* ${JANUSGRAPH_HOME}/conf/

ENV JANUSGRAPH_CONF=${JANUSGRAPH_HOME}/conf

#ENTRYPOINT tail -f /dev/null
ENTRYPOINT  ./bin/janusgraph-server.sh ./conf/gremlin-server-longpt.yaml