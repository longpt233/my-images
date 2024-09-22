FROM openjdk:11-jre-slim

# Set environment variables
ENV NIFI_VERSION=1.20.0
ENV NIFI_HOME=/opt/nifi

# Download Apache NiFi and extract
RUN apt-get update && apt-get install -y wget curl \
    && wget https://archive.apache.org/dist/nifi/${NIFI_VERSION}/nifi-${NIFI_VERSION}-bin.tar.gz \
    && mkdir -p /opt/nifi \
    && tar -xvzf nifi-${NIFI_VERSION}-bin.tar.gz --strip-components=1 -C /opt/nifi \
    && rm nifi-${NIFI_VERSION}-bin.tar.gz

# Copy local configuration files to NiFi configuration directory
# COPY ./conf/ ${NIFI_HOME}/conf/


RUN sed -i 's/nifi.zookeeper.connect.string=$/nifi.zookeeper.connect.string=localhost:2181/g' ${NIFI_HOME}/conf/nifi.properties \
sed -i 's/server.1=$/server.1=localhost:2888:3888;2181/g' ${NIFI_HOME}/conf/zookeeper.properties \
sed -i 's/nifi.state.management.embedded.zookeeper.start=false$/nifi.state.management.embedded.zookeeper.start=true/g' ${NIFI_HOME}/conf/nifi.properties \
sed  -i 's/<property name="Connect String"><\/property>$/<property name="Connect String">localhost:2181<\/property>/g' ${NIFI_HOME}/conf/state-management.xml \


RUN mkdir ${NIFI_HOME}/state  \
mkdir ${NIFI_HOME}/state/zookeeper \
echo 1 > ${NIFI_HOME}/state/zookeeper/myid


# Set NiFi's default port for web UI
EXPOSE 8080

# Set the working directory
WORKDIR ${NIFI_HOME}

# Set the entry point to run NiFi

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]