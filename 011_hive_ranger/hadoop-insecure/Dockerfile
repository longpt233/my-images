ARG BASE_VERSION

FROM $BASE_VERSION

WORKDIR /

USER root


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


# https://archive.apache.org/dist/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz
# Cannot find hadoop installation: $HADOOP_HOME or $HADOOP_PREFIX must be set or hadoop must be in the path
# chay sang ben day cho nhanh
COPY apache-hive-3.1.3-bin.tar.gz /tmp/apache-hive-3.1.3-bin.tar.gz

# hive standalone hinh nhu truoc bi thieu lib -> cai full di
RUN set -x && tar -xvf /tmp/apache-hive-3.1.3-bin.tar.gz -C /tmp/ \
    && mv /tmp/apache-hive-3.1.3-bin /usr/local/hive \
    && rm /tmp/apache-hive-3.1.3-bin.tar.gz


COPY hms/hive-site.xml /usr/local/hive/conf/hive-site.xml
COPY postgresql-42.5.4.jar /usr/local/hive/lib/postgresql-42.5.4.jar


RUN cp /usr/local/hive/conf/hive-log4j2.properties.template /usr/local/hive/conf/hive-log4j2.properties

RUN cd /usr/local/hive \
&& cp lib/postgresql-9.4.1208.jre7.jar lib/postgresql-9.4.1208.jre7.jar.bk 

# RUN /usr/local/hive/bin/schematool -dbType postgres -initSchema --verbose

# RUN apt-get -y install postgresql-client

# ADD hadoop-insecure/wait-for-hive.sh /wait-for-hive.sh
# RUN chmod a+x /wait-for-hive.sh

ENTRYPOINT [ "/entrypoint.sh" ]
