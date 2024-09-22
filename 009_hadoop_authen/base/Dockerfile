FROM ubuntu:20.04

USER root
WORKDIR /


ADD apt.conf /etc/apt/apt.conf.d/10apt.conf

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
    sudo  \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install krb5-kdc krb5-admin-server -y 


# check tai https://mirror.downloadvn.com/apache/hadoop/common
ARG HADOOP_VERSION=3.2.4
LABEL Description="Hadoop Dev" \
    "Hadoop Version"="$HADOOP_VERSION"

# install java-8
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
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
# RUN set -x \
#     && curl -fSL "$HADOOP_URL" -o /tmp/${HADOOP_TAR} \
#     && tar -xvf /tmp/${HADOOP_TAR} 
# RUN mv /hadoop-${HADOOP_VERSION} /usr/local/hadoop \
#     && rm /tmp/${HADOOP_TAR}

COPY hadoop-3.3.5.tar.gz /tmp/hadoop-3.3.5.tar.gz

RUN set -x && tar -xvf /tmp/hadoop-3.3.5.tar.gz -C /tmp/ \
    && mv /tmp/hadoop-3.3.5 /opt/hadoop \
    && rm /tmp/hadoop-3.3.5.tar.gz

ENV HADOOP_HOME /opt/hadoop
ENV PATH $PATH:/opt/hadoop/bin:/opt/hadoop/sbin 

ENV TZ "Asia/Ho_Chi_Minh"
RUN date

# RUN timedatectl set-timezone "Asia/Ho_Chi_Minh"

RUN adduser longpt
RUN usermod -aG sudo longpt

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ADD kdc.conf /etc/krb5kdc/kdc.conf  
ADD krb5.conf /etc/krb5.conf 


# Tạo file mật khẩu tạm thời và chạy krb5_newrealm
# RUN apt-get update && apt-get install -y  expect
# COPY realm_create.sh /realm_create.sh
# RUN chmod 777 /realm_create.sh
# RUN /realm_create.sh

RUN kdb5_util create -s -r HADOOP.REALM -P "yourpassword"


RUN sudo kadmin.local -q "addprinc -randkey namenode/hadoop110@HADOOP.REALM" && \
    sudo kadmin.local -q "addprinc -randkey datanode/hadoop110@HADOOP.REALM" && \
    sudo kadmin.local -q "addprinc -randkey HTTP/hadoop110@HADOOP.REALM" && \
    sudo kadmin.local -q "xst -k /hdfs.keytab HTTP/hadoop110@HADOOP.REALM  namenode/hadoop110@HADOOP.REALM datanode/hadoop110@HADOOP.REALM"

# Đảm bảo rằng các file keytab có quyền truy cập phù hợp
RUN chmod 777 /hdfs.keytab


ADD core-site.xml /opt/hadoop/etc/hadoop/
ADD hdfs-site.xml /opt/hadoop/etc/hadoop/
ADD hadoop-env.sh /opt/hadoop/etc/hadoop/

ENTRYPOINT [ "/entrypoint.sh" ]




