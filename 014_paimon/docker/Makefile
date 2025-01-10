# FILES = hadoop-common-3.4.0.jar paimon-flink-action-0.9.0.jar hadoop-aws-3.1.4.jar aws-java-sdk-bundle-1.11.901.jar

# hadoop-common-3.4.0.jar  java.lang.ClassNotFoundException: Class org.apache.hadoop.fs.s3a.S3AFileSystem not found

# paimon-flink-action-0.9.0.jar aws-java-sdk-1.12.461.jar hadoop-common-3.4.0.jar hadoop-aws-3.1.4.jar aws-java-sdk-bundle-1.11.901.jar

FILES = 



build: 
	@docker build -f ./hms/Dockerfile -t longpt233/hms:0.0.1 .

get: 
	@echo "download"
	bash get_jar.sh
	# @wget https://repo.maven.apache.org/maven2/org/apache/flink/flink-shaded-hadoop-2-uber/2.8.3-10.0/flink-shaded-hadoop-2-uber-2.8.3-10.0.jar 
	# @wget https://repo.maven.apache.org/maven2/org/apache/paimon/paimon-flink-1.18/0.8.1/paimon-flink-1.18-0.8.1.jar
	# @wget https://repo.maven.apache.org/maven2/org/apache/paimon/paimon-flink-action/0.8.1/paimon-flink-action-0.8.1.jar 

push: 
	@for file in $(FILES); do \
		echo "Processing $$file..."; \
		docker cp ./jars/$$file  jobmanager:/opt/flink/lib/$$file ;\
		docker cp ./jars/$$file docker-taskmanager-1:/opt/flink/lib/$$file; \
		docker cp ./jars/$$file  docker-taskmanager-2:/opt/flink/lib/$$file ;\
	done

# docker cp ./jars/${file}  jobmanager:/opt/flink/lib/${file} ;\
# docker cp ./jars/${file} docker-taskmanager-1:/opt/flink/lib/${file}; \
# docker cp ./jars/${file}  docker-taskmanager-2:/opt/flink/lib/${file} ;\

change: 


	docker cp log4j-cli.properties  jobmanager:/opt/flink/conf/log4j-cli.properties
	# docker cp log4j.properties jobmanager:/opt/flink/conf/log4j.properties
	# docker cp logback.xml jobmanager:/opt/flink/conf/logback.xml

	docker cp log4j-console.properties  jobmanager:/opt/flink/conf/log4j-console.properties
	docker cp log4j-console.properties  docker-taskmanager-1:/opt/flink/conf/log4j-console.properties
	docker cp log4j-console.properties  docker-taskmanager-2:/opt/flink/conf/log4j-console.properties

	# docker cp hive-site.xml  jobmanager:/opt/flink/conf/hive-site.xml
	# docker cp hive-site.xml  docker-taskmanager-1:/opt/flink/conf/hive-site.xml
	# docker cp hive-site.xml  docker-taskmanager-2:/opt/flink/conf/hive-site.xml


	# docker cp apt.conf jobmanager:/etc/apt/apt.conf.d/10apt.conf
	# docker cp apt.conf docker-taskmanager-1:/etc/apt/apt.conf.d/10apt.conf
	# docker cp apt.conf docker-taskmanager-1:/etc/apt/apt.conf.d/10apt.conf


	# docker exec jobmanager bash -c "chmod 775 /opt/flink/lib/*"
	# docker exec docker-taskmanager-1 bash -c "chmod 775 /opt/flink/lib/*"
	# docker exec docker-taskmanager-2 bash -c "chmod 775 /opt/flink/lib/*"
	# docker exec jobmanager bash -c "chown flink:flink /opt/flink/lib/*"
	# docker exec docker-taskmanager-1 bash -c "chown flink:flink /opt/flink/lib/*"
	# docker exec docker-taskmanager-2 bash -c "chown flink:flink /opt/flink/lib/*"


	# docker exec jobmanager bash -c "chmod 775 /opt/flink/conf/*"
	# docker exec docker-taskmanager-1 bash -c "chmod 775 /opt/flink/conf/*"
	# docker exec docker-taskmanager-2 bash -c "chmod 775 /opt/flink/conf/*"
	# docker exec jobmanager bash -c "chown flink:flink /opt/flink/conf/*"
	# docker exec docker-taskmanager-1 bash -c "chown flink:flink /opt/flink/conf/*"
	# docker exec docker-taskmanager-2 bash -c "chown flink:flink /opt/flink/conf/*"

	# docker exec jobmanager bash -c "rm -f  /opt/flink/lib/hadoop-aws-3.3.5.jar"
	# docker exec docker-taskmanager-1 bash -c "rm -f  /opt/flink/lib/hadoop-aws-3.3.5.jar"
	# docker exec docker-taskmanager-2 bash -c "rm -f  /opt/flink/lib/hadoop-aws-3.3.5.jar"

	# docker exec jobmanager bash -c "rm -f  /opt/flink/lib/aws-java-sdk-bundle-1.11.901.jar"
	# docker exec docker-taskmanager-1 bash -c "rm -f  /opt/flink/lib/aws-java-sdk-bundle-1.11.901.jar"
	# docker exec docker-taskmanager-2 bash -c "rm -f  /opt/flink/lib/aws-java-sdk-bundle-1.11.901.jar"

	# docker exec jobmanager bash -c "rm -f  /opt/flink/lib/paimon-flink-action-0.8.1.jar"
	# docker exec docker-taskmanager-1 bash -c "rm -f   /opt/flink/lib/paimon-flink-action-0.8.1.jar"
	# docker exec docker-taskmanager-2 bash -c "rm -f  /opt/flink/lib/paimon-flink-action-0.8.1.jar"


