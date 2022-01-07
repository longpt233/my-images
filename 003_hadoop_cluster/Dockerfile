FROM longpt233/ubuntu-base:2.0.0


ARG HADOOP_VERSION=3.2.2
ARG HADOOP_TAR=hadoop-$HADOOP_VERSION.tar.gz
ARG HADOOP_URL="https://mirror.downloadvn.com/apache/hadoop/common/hadoop-${HADOOP_VERSION}/${HADOOP_TAR}"

LABEL Description="Hadoop Dev" \
    "Hadoop Version"="$HADOOP_VERSION"

WORKDIR /

USER root

# install hadoop
RUN set -x \
    && curl -fSL "$HADOOP_URL" -o /tmp/${HADOOP_TAR} \
    && tar -xvf /tmp/${HADOOP_TAR} \
    && mv /hadoop-${HADOOP_VERSION} /usr/local/hadoop \
    && rm /tmp/${HADOOP_TAR}

# set environment variable 
ENV HADOOP_HOME=/usr/local/hadoop 
ENV PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin 

RUN mkdir -p ~/hdfs/namenode && \ 
    mkdir -p ~/hdfs/datanode && \
    mkdir $HADOOP_HOME/logs

COPY config/* /tmp/

RUN mv /tmp/ssh_config ~/.ssh/config && \
    mv /tmp/hadoop-env.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \ 
    mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    mv /tmp/slaves $HADOOP_HOME/etc/hadoop/slaves && \
    mv /tmp/start-hadoop.sh ~/start-hadoop.sh && \
    mv /tmp/run-wordcount.sh ~/run-wordcount.sh

RUN chmod +x ~/start-hadoop.sh && \
    chmod +x ~/run-wordcount.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh 

# format namenode
RUN /usr/local/hadoop/bin/hdfs namenode -format

CMD [ "sh", "-c", "service ssh start; bash"]

