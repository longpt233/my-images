# docker build -t longpt233/hadoop-spark:2.0.0 .
# docker push longpt233/hadoop-spark:2.0.0

FROM longpt233/hadoop-base:2.0.0

ARG SPARK_VERSION=3.1.2
ENV HADOOP_VERSION=3.2
ARG SPARK_TAR=spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
ARG SPARK_URL=https://mirror.downloadvn.com/apache/spark/spark-${SPARK_VERSION}/${SPARK_TAR}

WORKDIR /

USER root

RUN echo ${SPARK_URL}&&\
    wget "$SPARK_URL"  \
    && tar -xvf /${SPARK_TAR} -C /usr/local/ \
    && rm /${SPARK_TAR}*
  
ENV SPARK_HOME=/usr/local/spark-3.1.2-bin-hadoop3.2
ENV YARN_CONF_DIR=$HADOOP_HOME/etc/hadoop   
ENV PATH=$PATH:$SPARK_HOME/bin


ADD config/* /usr/local/

EXPOSE 4040 7077 8080 8081 18080 34047 8088