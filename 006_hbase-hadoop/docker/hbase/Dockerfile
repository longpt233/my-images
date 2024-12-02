FROM longpt233/ubuntu-base:2.0.0
# ban base nay da co ssh + java 8

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

ENTRYPOINT [ "/entrypoint.sh" ]