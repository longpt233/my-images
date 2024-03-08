FROM ubuntu:18.04

USER root
WORKDIR /

# install supported tools
RUN apt-get update
RUN apt-get install -y \
    curl \
    net-tools \
    telnet \
    iputils-ping \
    nano \
    ssh \
    krb5-user \
    openjdk-8-jdk \
    && rm -rf /var/lib/apt/lists/*


# check tai https://mirror.downloadvn.com/apache/hadoop/common
ARG HADOOP_VERSION=3.2.4
LABEL Description="Hadoop Dev" \
    "Hadoop Version"="$HADOOP_VERSION"

# install java-8
RUN apt-get install -y openjdk-8-jdk
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
ENV PATH $PATH:$JAVA_HOME/bin

ARG HADOOP_TAR=hadoop-$HADOOP_VERSION.tar.gz
ARG HADOOP_URL="https://mirror.downloadvn.com/apache/hadoop/common/hadoop-${HADOOP_VERSION}/${HADOOP_TAR}"


RUN addgroup hadoop

# -m: --create-home, -s: --shell SHELL
RUN useradd -m -s /bin/bash -g hadoop  hdfs

# hoặc tạo xong rồi add vào group: usermod -g hdfs hdfs
# check user o group nao: id hdfs

RUN mkdir /storage


# install hadoop
RUN set -x \
    && curl -fSL "$HADOOP_URL" -o /tmp/${HADOOP_TAR} \
    && tar -xvf /tmp/${HADOOP_TAR} 
RUN mv /hadoop-${HADOOP_VERSION} /usr/local/hadoop \
    && rm /tmp/${HADOOP_TAR}

# krb5-user cho client(hdfs cần cái này)
# cái này để chạy server kdc
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install krb5-kdc krb5-admin-server -y 

ENV HADOOP_HOME=/usr/local/hadoop 
ENV PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin 

ENV TZ="Asia/Ho_Chi_Minh"
RUN date

# RUN timedatectl set-timezone "Asia/Ho_Chi_Minh"

RUN apt-get install sudo

RUN adduser longpt
RUN usermod -aG sudo longpt

ARG ZOO_TAR=apache-zookeeper-3.7.2-bin.tar.gz
ARG ZOO_DIR="apache-zookeeper-3.7.2-bin"
ARG ZOO_URL="https://dlcdn.apache.org/zookeeper/zookeeper-3.7.2/${ZOO_TAR}"
# install hadoop
RUN set -x \
    && curl -fSL "$ZOO_URL" -o /tmp/${ZOO_TAR} \
    && tar -xvf /tmp/${ZOO_TAR} 
RUN mv /${ZOO_DIR} /usr/local/zoo \
    && rm /tmp/${ZOO_TAR}

RUN apt-get update && apt-get install build-essential -y 

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]




