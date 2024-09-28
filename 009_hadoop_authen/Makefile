IMAGE_NAME := "hadoop-secure"
NIFI_IMAGE_NAME := "nifi"
HADOOP_IMAGE_NAME := "hadoop-insecure"
VER := "0.0.1"
USER := "longpt233"
HTTP_PROXY := http://10.208.164.185:9999
HTTPS_PROXY := http://10.208.164.185:9999


.PHONY: build nifi

#  docker --build-arg HTTP_PROXY=${HTTP_PROXY} --build-arg HTTPS_PROXY=${HTTPS_PROXY} 



build: 
	@echo "build ${IMAGE_NAME}:${VER}"
	@docker build -f ./hadoop/Dockerfile -t ${USER}/${IMAGE_NAME}:${VER} . 
	@docker build -f ./hadoop-insecure/Dockerfile -t ${USER}/${HADOOP_IMAGE_NAME}:${VER} .
	@docker build -f ./nifi/Dockerfile -t ${USER}/${NIFI_IMAGE_NAME}:${VER} .


# @docker cp ../002_hadoop/conf/core-site.xml dragonnifi:/tmp/
# @docker cp ../002_hadoop/conf/hdfs-site.xml dragonnifi:/tmp/
# @docker cp ./nifi/hdfs-site.xml dragonnifi:/
# @docker cp ./nifi/core-site.xml dragonnifi:/
# @docker cp ./nifi/krb5.conf dragonnifi:/etc/


#  You need to persist the whole /opt/nifi/nifi-current/conf/ folder
# @docker cp  dragonnifi:/opt/nifi/conf/flow.json.gz ./nifi/conf/flow.json.gz
# @docker cp  dragonnifi:/opt/nifi/conf/flow.xml.gz ./nifi/conf/flow.xml.gz


# run once to get config to local
# @docker cp  dragonnifi:/opt/nifi/conf ./nifi/conf


# @docker cp /home/long/IdeaProjects/nifi/nifi-nar-bundles/nifi-extension-utils/nifi-hadoop-utils/target/nifi-hadoop-utils-1.19.2-SNAPSHOT.jar dragonnifi:/opt/nifi/lib/nifi-hadoop-nar-1.19.2-SNAPSHOT.nar


setup:
	@docker cp /home/long/IdeaProjects/nifi/nifi-nar-bundles/nifi-hadoop-bundle/nifi-hadoop-nar/target/nifi-hadoop-nar-1.19.2-SNAPSHOT.nar dragonnifi:/opt/nifi/lib/nifi-hadoop-nar-1.19.2-SNAPSHOT.nar
	@docker exec dragonnifi bash -c "./bin/nifi.sh restart"

keytab:
	@docker cp  dragonsecure:/hdfs.keytab ./nifi/hdfs.keytab
	@docker cp ./nifi/hdfs.keytab dragonnifi:/
	@docker exec dragonnifi bash -c "chmod 777 /hdfs.keytab"
	@docker exec dragonnifi bash -c "chown hadoop. /hdfs.keytab"
	@docker cp  dragonsecure:/nifi.keytab ./nifi/nifi.keytab
	@docker cp ./nifi/nifi.keytab dragonnifi:/
	@docker exec dragonnifi bash -c "chmod 777 /nifi.keytab"
	@docker exec dragonnifi bash -c "chown hadoop. /nifi.keytab"
