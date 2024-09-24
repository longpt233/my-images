FROM openjdk:11-jre-slim

# Set environment variables
ENV NIFI_VERSION 1.20.0
ENV NIFI_HOME /opt/nifi

ADD apt.conf /etc/apt/apt.conf.d/10apt.conf

# -m: --create-home, -s: --shell SHELL
#RUN useradd -m -s /bin/bash -g nifi

#USER nifi 

RUN apt-get update && apt-get install -y wget curl unzip

# ADD wgetrc /etc/wgetrc

COPY nifi-1.20.0-bin.zip /tmp/nifi-1.20.0-bin.zip
# Download Apache NiFi and extract
#RUN  wget https://archive.apache.org/dist/nifi/${NIFI_VERSION}/nifi-${NIFI_VERSION}-bin.zip \
#RUN mkdir -p /opt/nifi \
RUN  unzip /tmp/nifi-${NIFI_VERSION}-bin.zip -d  /tmp \
	&& mv /tmp/nifi-1.20.0 /opt/nifi  \
    && rm /tmp/nifi-${NIFI_VERSION}-bin.zip

# Copy local configuration files to NiFi configuration directory
# COPY ./conf/ ${NIFI_HOME}/conf/


RUN sed -i 's/nifi.zookeeper.connect.string=$/nifi.zookeeper.connect.string=localhost:2181/g' ${NIFI_HOME}/conf/nifi.properties \
    && sed -i 's/server.1=$/server.1=localhost:2888:3888;2181/g' ${NIFI_HOME}/conf/zookeeper.properties \
    && sed -i 's/nifi.state.management.embedded.zookeeper.start=false$/nifi.state.management.embedded.zookeeper.start=true/g' ${NIFI_HOME}/conf/nifi.properties \
    && sed -i 's/<property name="Connect String"><\/property>$/<property name="Connect String">localhost:2181<\/property>/g' ${NIFI_HOME}/conf/state-management.xml \
    && sed -i 's/^nifi.web.http.host=.*/nifi.web.http.host=0.0.0.0/' ${NIFI_HOME}/conf/nifi.properties \
    && sed -i 's/^nifi.web.http.port=.*/nifi.web.http.port=8080/' ${NIFI_HOME}/conf/nifi.properties \
    && sed -i 's/^nifi.remote.input.host=.*/nifi.remote.input.host=0.0.0.0/' ${NIFI_HOME}/conf/nifi.properties \
    && sed -i 's/^nifi.remote.input.socket.port=.*/nifi.remote.input.socket.port=8081/' ${NIFI_HOME}/conf/nifi.properties \
    && sed -i 's/^nifi.cluster.is.node=.*/nifi.cluster.is.node=false/' ${NIFI_HOME}/conf/nifi.properties \
    && sed -i 's/^nifi.remote.input.secure=.*/nifi.remote.input.secure=false/' ${NIFI_HOME}/conf/nifi.properties \
 && sed -i 's/^nifi.web.https.host=.*/#nifi.web.https.host=/' ${NIFI_HOME}/conf/nifi.properties \
    && sed -i 's/^nifi.web.https.port=.*/#nifi.web.https.port=/' ${NIFI_HOME}/conf/nifi.properties

RUN sed -i \
    '/^nifi\.security\.keystore/d; \
     /^nifi\.security\.truststore/d; \
     /^nifi\.security\.protocol/d; \
     /^nifi\.security\.keyPass/d; \
     /^nifi\.security\.truststorePass/d; \
     /^nifi\.security\.keystoreType/d; \
     /^nifi\.security\.truststoreType/d; \
     /^nifi\.web\.https\./d' ${NIFI_HOME}/conf/nifi.properties

RUN sed -i 's/^nifi.kerberos.krb5.file=.*$/nifi.kerberos.krb5.file=\/etc\/krb5.conf/'  /opt/nifi/conf/nifi.properties 

RUN mkdir ${NIFI_HOME}/state  \
&& mkdir ${NIFI_HOME}/state/zookeeper \
&& echo 1 > ${NIFI_HOME}/state/zookeeper/myid


# Set NiFi's default port for web UI
EXPOSE 8080

# Set the working directory
WORKDIR ${NIFI_HOME}

RUN apt-get install -y \
    curl \
    net-tools \
    telnet \
    iputils-ping \
    nano \
    ssh \
    krb5-user \
    sudo  \
    && rm -rf /var/lib/apt/lists/*

ADD hadoop/krb5.conf /etc/krb5.conf 

RUN mkdir /opt/nifi/hadoop

# ADD hadoop/core-site.xml /opt/nifi/hadoop/core-site.xml
# ADD hadoop/hdfs-site.xml /opt/nifi/hadoop/hdfs-site.xml

ADD hadoop-insecure/core-site.xml /opt/nifi/hadoop/core-site-insecure.xml
ADD hadoop-insecure/hdfs-site.xml /opt/nifi/hadoop/hdfs-site-insecure.xml

RUN chmod -R 777 /opt/nifi/hadoop/core-site* /opt/nifi/hadoop/hdfs-site* 

# Set the entry point to run NiFi

ADD nifi/entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

RUN sed -i 's/^nifi.sensitive.props.key=.*/nifi.sensitive.props.key=faasdfaQWERlqAFLAS34rfadsfasfcacaaerfse/' ${NIFI_HOME}/conf/nifi.properties 

RUN sed -i 's/^java.arg.2=.*/java.arg.2=-Xms5g/' ${NIFI_HOME}/conf/bootstrap.conf
RUN sed -i 's/^java.arg.3=.*/java.arg.3=-Xmx5g/' ${NIFI_HOME}/conf/bootstrap.conf


ENV TZ "Asia/Ho_Chi_Minh"
RUN date

RUN ./bin/nifi.sh set-single-user-credentials admin admin12345678

ENTRYPOINT [ "/entrypoint.sh" ]
