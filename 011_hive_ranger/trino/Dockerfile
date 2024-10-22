FROM ubuntu:22.04

USER root
WORKDIR /

ADD trino/apt.conf /etc/apt/apt.conf.d/10apt.conf

RUN apt-get update && apt install -y --no-install-recommends\
    curl \
    net-tools \
    telnet \
    iputils-ping \
    nano \
    ssh  \
    curl \
    ca-certificates \
    lsb-release \
    vim \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt install -y 

RUN apt update && apt-get install python-is-python3 -y


COPY jdk-17_linux-x64_bin.tar.gz /tmp/jdk-17_linux-x64_bin.tar.gz

RUN tar -xvf /tmp/jdk-17_linux-x64_bin.tar.gz -C /tmp/ \
    && mv /tmp/jdk-17.0.12 /usr/local/java \
    && rm /tmp/jdk-17_linux-x64_bin.tar.gz


ENV JAVA_HOME=/usr/local/java
ENV PATH $PATH:$JAVA_HOME/bin

COPY trino-server-429.tar.gz /tmp/trino-server-429.tar.gz

RUN tar -xvf /tmp/trino-server-429.tar.gz -C /tmp/ \
    && mv /tmp/trino-server-429 /usr/local/trino \
    && rm /tmp/trino-server-429.tar.gz

COPY trino/etc  /usr/local/trino/etc

COPY hadoop-insecure/core-site.xml /usr/local/trino/etc/catalog/core-site.xml
COPY hadoop-insecure/hdfs-site.xml /usr/local/trino/etc/catalog/hdfs-site.xml

RUN apt-get install apache2-utils -y

ADD trino/entrypoint-coord.sh /entrypoint-coord.sh
RUN chmod a+x /entrypoint-coord.sh

ADD trino/entrypoint-worker.sh /entrypoint-worker.sh
RUN chmod a+x /entrypoint-worker.sh


# local tar
COPY ranger-3.0.0-SNAPSHOT-trino-plugin.tar.gz /tmp/ranger-3.0.0-SNAPSHOT-trino-plugin.tar.gz

RUN set -x && tar -xvf /tmp/ranger-3.0.0-SNAPSHOT-trino-plugin.tar.gz -C /tmp/ \
    && mv /tmp/ranger-3.0.0-SNAPSHOT-trino-plugin /opt/trino-ranger-plugin \
    && rm /tmp/ranger-3.0.0-SNAPSHOT-trino-plugin.tar.gz

RUN sed -i 's|^POLICY_MGR_URL=.*|POLICY_MGR_URL=http://172.25.1.16:6080|'  /opt/trino-ranger-plugin/install.properties
RUN sed -i 's|^REPOSITORY_NAME=.*|REPOSITORY_NAME=trino-repo|'  /opt/trino-ranger-plugin/install.properties
RUN sed -i 's|^COMPONENT_INSTALL_DIR_NAME=.*|COMPONENT_INSTALL_DIR_NAME=/usr/local/trino|'  /opt/trino-ranger-plugin/install.properties
RUN sed -i 's|^XAAUDIT.HDFS.IS_ENABLED=.*|XAAUDIT.HDFS.IS_ENABLED=false|'  /opt/trino-ranger-plugin/install.properties

RUN sed -i 's|^CUSTOM_USER=.*|CUSTOM_USER=root|'  /opt/trino-ranger-plugin/install.properties
RUN sed -i 's|^CUSTOM_GROUP=.*|CUSTOM_GROUP=root|'  /opt/trino-ranger-plugin/install.properties

RUN echo -e  "\n\nXAAUDIT.SUMMARY.ENABLE=false" >>   /opt/trino-ranger-plugin/install.properties



RUN cd /opt/trino-ranger-plugin 




