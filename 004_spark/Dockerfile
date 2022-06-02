FROM longpt233/ubuntu-base:2.0.0

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