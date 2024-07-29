FROM ubuntu:20.04

USER root
WORKDIR /

# ENV https_proxy http://10.60.117.113:8080
# ENV http_proxy http://10.60.117.113:8080
# ENV HTTP_PROXY http://10.60.117.113:8080
# ENV HTTPS_PROXY http://10.60.117.113:8080

# ENV NO_PROXY 127.0.0.1,localhost,10.*.*.*,192.168
# ENV no_proxy 127.0.0.1,localhost,10.*.*.*,192.1

# nhung cai tren cung co the cau hinh bang docker

# nma apt su dung proxy trong /etc/apt/apt.conf -> cau hinh trong entrypoint 


ADD apt.conf /etc/apt/apt.conf.d/10apt.conf
# ADD environment /etc/environment
# install supported tools
RUN apt-get update
RUN apt-get install -y \
    curl  \
    net-tools \
    telnet \
    iputils-ping \
    nano \
    ssh \
    openjdk-8-jdk \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y openjdk-8-jdk
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
ENV PATH $PATH:$JAVA_HOME/bin

ARG SPARK_VERSION=3.1.2
ARG HADOOP_VERSION=3.2
ARG SPARK_TAR=spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
ARG SPARK_URL=https://mirror.downloadvn.com/apache/spark/spark-${SPARK_VERSION}/${SPARK_TAR}

LABEL Description="Apache Spark" \
    "Spark Version"="$SPARK_VERSION"

WORKDIR /

USER root

RUN set -x \
    && curl -fSL "$SPARK_URL" -o /tmp/${SPARK_TAR} \
    && tar -xvf /tmp/${SPARK_TAR} -C /opt/ \
    && rm /tmp/${SPARK_TAR}*

#install python, pyspark
RUN apt-get update && apt-get install -y gcc \
    python3.8 \
    python3-pip

RUN pip3 install --upgrade pip \
    && pip3 install pyspark

RUN mv /opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /opt/spark

ENV PATH $PATH:/opt/spark/bin
ENV SPARK_HOME=/opt/spark

EXPOSE 4040 7077 8080 8081 18080 34047

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]