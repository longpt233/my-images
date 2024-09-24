FROM longpt233/ubuntu-base:2.0.0
# ban base nay da co ssh + java 8



WORKDIR /

USER root

# install hadoop
# ARG HADOOP_VERSION=3.2.4
# ARG HADOOP_TAR=hadoop-$HADOOP_VERSION.tar.gz
# ARG HADOOP_URL="https://mirror.downloadvn.com/apache/hadoop/common/hadoop-${HADOOP_VERSION}/${HADOOP_TAR}"
# LABEL Description="Hadoop Dev" \
#     "Hadoop Version"="$HADOOP_VERSION"
# RUN set -x \
#     && curl -fSL "$HADOOP_URL" -o /tmp/${HADOOP_TAR} \
#     && tar -xvf /tmp/${HADOOP_TAR} 

# local tar
COPY hadoop-3.3.5.tar.gz /tmp/hadoop-3.3.5.tar.gz

RUN set -x && tar -xvf /tmp/hadoop-3.3.5.tar.gz -C /tmp/ \
    && mv /tmp/hadoop-3.3.5 /usr/local/hadoop \
    && rm /tmp/hadoop-3.3.5.tar.gz

# end local tar

ENV HADOOP_HOME=/usr/local/hadoop 
ENV PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin 

ENV HDFS_NAMENODE_USER=root
ENV HDFS_DATANODE_USER=root
ENV HDFS_SECONDARYNAMENODE_USER=root

RUN mkdir -p ~/hdfs/namenode && \ 
    mkdir -p ~/hdfs/datanode && \
    mkdir $HADOOP_HOME/logs

COPY hadoop-insecure/* /tmp/

RUN mv /tmp/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh \
    && mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml \
    && mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml

EXPOSE  50070 50075 8042 8088 9000 9870 8020 8485 22

ADD hadoop-insecure/entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

# chay cho lan dau tien thoi 
RUN $HADOOP_HOME/bin/hdfs namenode -format  

ENTRYPOINT [ "/entrypoint.sh" ]

# CMD [ "sh", "-c", "service ssh start; bash"]