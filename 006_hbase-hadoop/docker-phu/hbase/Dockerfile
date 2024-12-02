FROM ubuntu:20.04

WORKDIR /root

# install openssh-server, openjdk and wget
RUN apt-get update && apt-get install -y openssh-server openjdk-8-jdk wget

RUN wget https://dlcdn.apache.org/hbase/2.4.16/hbase-2.4.16-bin.tar.gz && \
tar -xzvf hbase-2.4.16-bin.tar.gz && \
mv hbase-2.4.16 /usr/local/hbase && \
rm hbase-2.4.16-bin.tar.gz

# set environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 
ENV HBASE_HOME=/usr/local/hbase
ENV PATH=$PATH:/usr/local/hbase/bin

# ssh without key
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys


COPY config/* /tmp/

RUN mv /tmp/ssh_config ~/.ssh/config && \
    mv /tmp/hbase-env.sh /usr/local/hbase/conf/hbase-env.sh && \
    mv /tmp/hbase-site.xml /usr/local/hbase/conf/hbase-site.xml && \ 
    mv /tmp/regionservers /usr/local/hbase/conf/regionservers && \
    mv /tmp/start-hbase.sh ~/start-hbase.sh

RUN chmod +x ~/start-hbase.sh    

CMD [ "sh", "-c", "service ssh start; bash"]
