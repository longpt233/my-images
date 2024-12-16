FROM ubuntu:20.04

USER root
WORKDIR /


ADD apt.conf /etc/apt/apt.conf.d/10apt.conf

# install supported tools
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    net-tools \
    telnet \
    iputils-ping \
    nano \
    ssh \
    krb5-user \
    openjdk-8-jdk \
    sudo  \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --proxy http://10.60.117.103:8085 jupyterlab

RUN pip3 install --proxy http://10.60.117.103:8085 pyspark==3.3.1

WORKDIR /

USER root


# local tar
COPY hbase-2.4.17-bin.tar.gz /tmp/hbase-2.4.17-bin.tar.gz

RUN set -x && tar -xvf /tmp/hbase-2.4.17-bin.tar.gz -C /tmp/ \
    && mv /tmp/hbase-2.4.17 /usr/local/hbase \
    && rm /tmp/hbase-2.4.17-bin.tar.gz

# end local tar

ENV HBASE_HOME=/usr/local/hbase 
# ENV PATH=$PATH:/usr/local/hbase/bin:/usr/local/hbase/sbin 


COPY hbase/* /tmp/

RUN mv /tmp/hbase-env.sh $HBASE_HOME/conf/hbase-env.sh \
    && mv /tmp/hbase-site.xml $HBASE_HOME/conf/hbase-site.xml 
    # && mv /tmp/regionservers $HBASE_HOME/conf/regionservers

# sed "s/<\/configuration>/<property>\n<name>hbase.rootdir<\/name>\n<value>hdfs:\/\/'$c':54310\/hbase<\/value>\n<\/property>\n
# <property>\n<name>hbase.cluster.distributed<\/name>\n<value>true<\/value>\n<\/property>\n
# <property>\n<name>hbase.zookeeper.property.clientPort<\/name>\n<value>2181<\/value>\n<\/property>\n
# <property>\n<name>hbase.zookeeper.quorum<\/name>\n<value>'$c'<\/value>\n<\/property>\n<\/configuration>/g" -i.bak hbase/conf/hbase-site.xml

ADD hbase/entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh


# local tar
COPY phoenix-hbase-2.4-5.1.3-bin.tar.gz /tmp/phoenix-hbase-2.4-5.1.3-bin.tar.gz

# RUN cp /tmp/phoenix-hbase-2.4-5.1.3-bin.tar.gz $HBASE_HOME/lib

RUN set -x && tar -xvf /tmp/phoenix-hbase-2.4-5.1.3-bin.tar.gz -C /tmp/ \
    && mv /tmp/phoenix-hbase-2.4-5.1.3-bin /usr/local/phoenix \
    && rm /tmp/phoenix-hbase-2.4-5.1.3-bin.tar.gz

ENV PHOENIX_HOME=/usr/local/phoenix
ENV PATH=$PATH:$PHOENIX_HOME/bin 

RUN cp /usr/local/phoenix/phoenix-server-hbase-2.4-5.1.3.jar $HBASE_HOME/lib
RUN sed -i 's|#!/usr/bin/env python|#!/usr/bin/python3|g' /usr/local/phoenix/bin/sqlline.py 

ADD hadoop/hdfs-site.xml /hdfs-site.xml
RUN cp  /hdfs-site.xml /usr/local/hbase/conf/hdfs-site.xml

ENV TZ "Asia/Ho_Chi_Minh"
RUN date

ENTRYPOINT [ "/entrypoint.sh" ]