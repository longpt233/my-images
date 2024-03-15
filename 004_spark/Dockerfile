FROM ubuntu:20.04

USER root
WORKDIR /

ENV https_proxy http://10.60.117.113:8080
ENV http_proxy http://10.60.117.113:8080
ENV HTTP_PROXY http://10.60.117.113:8080
ENV HTTPS_PROXY http://10.60.117.113:8080

ENV NO_PROXY 127.0.0.1,localhost,10.*.*.*,192.168.*.*,171.244.51.*,voffice.viettel.vn,dauthau.viettel.vn,hr.viettelpost.vn,evtp.viettelpost.vn,quanlynhansu.viettel.vn,thongtinnhansu.viettel.vn,quanlytinhluong.viettel.vn,quanlytuyendung.viettel.vn,vtt.viettel.vn,qlsxpm.viettel.vn,sso.viettel.vn,bankplus.viettel.vn,bankplus2.viettel.vn,quanlybaohanh.bccs.viettel.vn,acc.viettel.vn,cas.sirc.viettel.com,datasecurity.viettel.vn,oc.viettelpost.vn,quanlytaisan.viettel.vn,skyt.viettel.vn,sso2.viettel.vn,cvos.sfive.vn,chinhtri.viettel.vn,ams.tinnhanthuonghieu.vn,merchant.bankplus.vn,*.tinnhanthuonghieu.vn,congtacdang-congtacchinhtri.viettel.vn,*.dttt.vn,chat.viettel.vn,pmtc.viettel.vn,ch.viettelpost.vn,bankplus1.viettel.vn,gboc.viettel.vn,vps.viettel.vn,manhinhsanhviettel.com,cms-tracking.viettelpost.vn,jira.viettelpost.vn,confluence.viettelpost.vn,callvts.cyberbot.vn,171.244.0.182,vtt.cyberbot.vn,fwt.fialda.com,daututaisan.viettel.vn,hz-connection.lab.vn,edrawind.com,*.sirc.viettel.com,pay.bankplus.vn,*.cloudrity.com.vn,*.local,tinhluong.viettelpost.vn,emp-tinhluong.viettelpost.vn,report-tinhluong.viettelpost.vn,payroll-tinhluong.viettelpost.vn,file-tinhluong.viettelpost.vn,system-tinhluong.viettelpost.vn,vsds.viettel.vn,apis.viettel.vn,notify.viettel.vn,adms.viettel.vn,*vhkt*.viettelpost.vn,teleport.viettelpost.vn,fininvest.viettel.vn,bi-yarn.viettelpost.vn,bi-hdfs.viettelpost.vn,bi-nifi.viettelpost.vn,tms-nifi.viettelpost.vn,bi-kafka-nifi.viettelpost.vn,bi-pentaho.viettelpost.vn,bi-airflow.viettelpost.vn,bi-zeppelin.viettelpost.vn,dev-bi-grafana.viettelpost.vn,dev-bi-victoriametrics.viettelpost.vn,dev-bi-pentaho.viettelpost.vn,teleport-partner.viettelpost.vn,wms-nifi.viettelpost.vn,teleport-dev.viettelpost.vn,noc-dev-pc.viettelpost.vn,noc-dev-api.viettelpost.vn,staging-bi-kong.viettelpost.vn,staging-bi-zeppelin.viettelpost.vn,staging-bi-hdfs.viettelpost.vn,staging-bi-yarn.viettelpost.vn,staging-bi-nifi.viettelpost.vn,staging-bi-nifi2.viettelpost.vn,staging-bi-airflow.viettelpost.vn,noc-staging-pc.viettelpost.vn,noc-staging-api.viettelpost.vn,noc-staging-resource.viettelpost.vn,staging-bi-trino.viettelpost.vn,bi-airflow2.viettelpost.vn,dev-bi-trino.viettelpost.vn,bi-hbase2.viettelpost.vn,bi-hbase3.viettelpost.vn,bi-trino-da.viettelpost.vn,vops.viettel.vn,bi-hbase.viettelpost.vn,staging-bi-superset.viettelpost.vn,noc-airflow.viettelpost.vn,noc-airflow-flower.viettelpost.vn
ENV no_proxy 127.0.0.1,localhost,10.*.*.*,192.168.*.*,171.244.51.*,voffice.viettel.vn,dauthau.viettel.vn,hr.viettelpost.vn,evtp.viettelpost.vn,quanlynhansu.viettel.vn,thongtinnhansu.viettel.vn,quanlytinhluong.viettel.vn,quanlytuyendung.viettel.vn,vtt.viettel.vn,qlsxpm.viettel.vn,sso.viettel.vn,bankplus.viettel.vn,bankplus2.viettel.vn,quanlybaohanh.bccs.viettel.vn,acc.viettel.vn,cas.sirc.viettel.com,datasecurity.viettel.vn,oc.viettelpost.vn,quanlytaisan.viettel.vn,skyt.viettel.vn,sso2.viettel.vn,cvos.sfive.vn,chinhtri.viettel.vn,ams.tinnhanthuonghieu.vn,merchant.bankplus.vn,*.tinnhanthuonghieu.vn,congtacdang-congtacchinhtri.viettel.vn,*.dttt.vn,chat.viettel.vn,pmtc.viettel.vn,ch.viettelpost.vn,bankplus1.viettel.vn,gboc.viettel.vn,vps.viettel.vn,manhinhsanhviettel.com,cms-tracking.viettelpost.vn,jira.viettelpost.vn,confluence.viettelpost.vn,callvts.cyberbot.vn,171.244.0.182,vtt.cyberbot.vn,fwt.fialda.com,daututaisan.viettel.vn,hz-connection.lab.vn,edrawind.com,*.sirc.viettel.com,pay.bankplus.vn,*.cloudrity.com.vn,*.local,tinhluong.viettelpost.vn,emp-tinhluong.viettelpost.vn,report-tinhluong.viettelpost.vn,payroll-tinhluong.viettelpost.vn,file-tinhluong.viettelpost.vn,system-tinhluong.viettelpost.vn,vsds.viettel.vn,apis.viettel.vn,notify.viettel.vn,adms.viettel.vn,*vhkt*.viettelpost.vn,teleport.viettelpost.vn,fininvest.viettel.vn,bi-yarn.viettelpost.vn,bi-hdfs.viettelpost.vn,bi-nifi.viettelpost.vn,tms-nifi.viettelpost.vn,bi-kafka-nifi.viettelpost.vn,bi-pentaho.viettelpost.vn,bi-airflow.viettelpost.vn,bi-zeppelin.viettelpost.vn,dev-bi-grafana.viettelpost.vn,dev-bi-victoriametrics.viettelpost.vn,dev-bi-pentaho.viettelpost.vn,teleport-partner.viettelpost.vn,wms-nifi.viettelpost.vn,teleport-dev.viettelpost.vn,noc-dev-pc.viettelpost.vn,noc-dev-api.viettelpost.vn,staging-bi-kong.viettelpost.vn,staging-bi-zeppelin.viettelpost.vn,staging-bi-hdfs.viettelpost.vn,staging-bi-yarn.viettelpost.vn,staging-bi-nifi.viettelpost.vn,staging-bi-nifi2.viettelpost.vn,staging-bi-airflow.viettelpost.vn,noc-staging-pc.viettelpost.vn,noc-staging-api.viettelpost.vn,noc-staging-resource.viettelpost.vn,staging-bi-trino.viettelpost.vn,bi-airflow2.viettelpost.vn,dev-bi-trino.viettelpost.vn,bi-hbase2.viettelpost.vn,bi-hbase3.viettelpost.vn,bi-trino-da.viettelpost.vn,vops.viettel.vn,bi-hbase.viettelpost.vn,staging-bi-superset.viettelpost.vn,noc-airflow.viettelpost.vn,noc-airflow-flower.viettelpost.vn

# RUN env 

# install supported tools
# RUN apt-get update
# RUN apt-get install -y \
#     curl  
#     net-tools \
#     telnet \
#     iputils-ping \
#     nano \
#     ssh \
#     openjdk-8-jdk \
#     && rm -rf /var/lib/apt/lists/*

# RUN apt-get update && apt-get install -y openjdk-8-jdk
# ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
# ENV PATH $PATH:$JAVA_HOME/bin

# ARG SPARK_VERSION=3.1.2
# ARG HADOOP_VERSION=3.2
# ARG SPARK_TAR=spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
# ARG SPARK_URL=https://mirror.downloadvn.com/apache/spark/spark-${SPARK_VERSION}/${SPARK_TAR}

# LABEL Description="Apache Spark" \
#     "Spark Version"="$SPARK_VERSION"

# WORKDIR /

# USER root

# RUN set -x \
#     && curl -fSL "$SPARK_URL" -o /tmp/${SPARK_TAR} \
#     && tar -xvf /tmp/${SPARK_TAR} -C /opt/ \
#     && rm /tmp/${SPARK_TAR}*

# #install python, pyspark
# RUN apt-get update && apt-get install -y gcc \
#     python3.8 \
#     python3-pip

# RUN pip3 install --upgrade pip \
#     && pip3 install pyspark

# RUN mv /opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /opt/spark

# ENV PATH $PATH:/opt/spark/bin
# ENV SPARK_HOME=/opt/spark

# EXPOSE 4040 7077 8080 8081 18080 34047

# ADD entrypoint.sh /entrypoint.sh
# RUN chmod a+x /entrypoint.sh
# ENTRYPOINT [ "/entrypoint.sh" ]