IMAGE_NAME := "hadoop-ha"
VER := "1.0.2"
USER := "longpt233"

build-base: 
	@echo "build ${IMAGE_NAME}:${VER}"
	@docker build -f ./base/Dockerfile -t ${USER}/${IMAGE_NAME}:${VER} ./base
    # docker login registry.example.com or docker login. check: docker info
	@docker push ${USER}/${IMAGE_NAME}:${VER}

krb-conf:
	@docker cp ./conf/kdc/krb5.conf datanode1_name:/etc/krb5.conf
	@docker cp ./conf/kdc/kdc.conf datanode1_name:/etc/krb5kdc/kdc.conf 

krb-sync:
	@docker cp ./conf/kdc/krb5.conf namenode_name:/etc/krb5.conf
	@docker cp ./conf/kdc/krb5.conf datanode2_name:/etc/krb5.conf
	@docker cp datanode1_name:/hdfs.keytab ./conf/kdc/
	@docker cp ./conf/kdc/hdfs.keytab namenode_name:/
	@docker cp ./conf/kdc/hdfs.keytab datanode2_name:/
	@docker cp datanode1_name:/http.keytab ./conf/kdc/
	@docker cp ./conf/kdc/http.keytab namenode_name:/
	@docker cp ./conf/kdc/http.keytab datanode2_name:/

hdfs-conf:
	@docker exec namenode_name bash -c "mkdir -p /data && chown hdfs:hadoop /data"
	@docker exec datanode1_name bash -c "mkdir -p /data && chown hdfs:hadoop /data"
	@docker exec datanode2_name bash -c "mkdir -p /data && chown hdfs:hadoop /data"
	@docker cp ./conf/hadoop/. namenode_name:/usr/local/hadoop/etc/hadoop/
	@docker cp ./conf/hadoop/. datanode1_name:/usr/local/hadoop/etc/hadoop/
	@docker cp ./conf/hadoop/. datanode2_name:/usr/local/hadoop/etc/hadoop/

hdfs-run:
	@docker exec -u hdfs namenode_name bash -c "whoami"

	
