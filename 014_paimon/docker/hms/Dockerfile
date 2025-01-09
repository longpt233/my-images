FROM openjdk:8-jre-slim-buster

WORKDIR /opt

ENV HADOOP_VERSION=3.2.0
ENV METASTORE_VERSION=3.0.0

ADD apt.conf /etc/apt/apt.conf.d/10apt.conf

RUN apt-get update && apt-get install -y netcat curl

ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
ENV HIVE_HOME=/opt/apache-hive-metastore-${METASTORE_VERSION}-bin

RUN curl -x "http://10.60.117.103:8085" -L https://downloads.apache.org/hive/hive-standalone-metastore-${METASTORE_VERSION}/hive-standalone-metastore-${METASTORE_VERSION}-bin.tar.gz | tar zxf - && \
    curl -x "http://10.60.117.103:8085" -L https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | tar zxf - 
    
RUN curl -x "http://10.60.117.103:8085" -L https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.19.tar.gz | tar zxf - && \
    curl -x "http://10.60.117.103:8085" -L --output postgresql-42.5.6.jar https://jdbc.postgresql.org/download/postgresql-42.5.6.jar
    
# RUN curl -x "http://10.60.117.103:8085" -L --output hive-exec-${METASTORE_VERSION}.jar https://repo1.maven.org/maven2/org/apache/hive/hive-exec/${METASTORE_VERSION}/hive-exec-${METASTORE_VERSION}.jar
    
RUN cp mysql-connector-java-8.0.19/mysql-connector-java-8.0.19.jar ${HIVE_HOME}/lib/ && \
    cp postgresql-42.5.6.jar ${HIVE_HOME}/lib/
# RUN cp hive-exec-${METASTORE_VERSION}.jar ${HIVE_HOME}/lib/ && \
RUN rm -rf mysql-connector-java-8.0.19 && \
    rm -rf postgresql-42.5.6.jar && \
    rm -rf hive-exec-${METASTORE_VERSION}.jar

COPY ./hms/entrypoint.sh /entrypoint.sh
# COPY ./hive-exec-3.0.0.jar ${HIVE_HOME}/lib/

COPY ./hms/metastore-site.xml /opt/apache-hive-metastore-3.0.0-bin/conf/metastore-site.xml

# COPY ./jars/hadoop-common-3.4.0.jar /opt/apache-hive-metastore-3.0.0-bin/lib/hadoop-common-3.4.0.jar

# COPY ./jars/aws-java-sdk-1.12.461.jar /opt/apache-hive-metastore-3.0.0-bin/lib/aws-java-sdk-1.12.461.jar
# vẫn bị MetaException(message:Got exception: org.apache.hadoop.fs.UnsupportedFileSystemException No FileSystem for scheme "s3")

RUN groupadd -r hive --gid=1000 && \
    useradd -r -g hive --uid=1000 -d ${HIVE_HOME} hive && \
    chown hive:hive -R ${HIVE_HOME} && \
    chown hive:hive /entrypoint.sh && chmod +x /entrypoint.sh

USER hive
EXPOSE 9083

ENTRYPOINT ["sh", "-c", "/entrypoint.sh"]