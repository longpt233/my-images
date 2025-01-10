# FILES = hadoop-common-3.4.0.jar paimon-flink-action-0.9.0.jar hadoop-aws-3.1.4.jar aws-java-sdk-bundle-1.11.901.jar hadoop-common-3.4.0.jar hadoop-aws-3.1.4.jar aws-java-sdk-bundle-1.11.901.jar guava-31.0.1-jre.jar

# hadoop-common-3.4.0.jar  java.lang.ClassNotFoundException: Class org.apache.hadoop.fs.s3a.S3AFileSystem not found

# paimon-flink-action-0.9.0.jar aws-java-sdk-1.12.461.jar hadoop-common-3.4.0.jar hadoop-aws-3.1.4.jar aws-java-sdk-bundle-1.11.901.jar

# paimon-flink-action-0.8.1.jar flink-sql-connector-postgres-cdc-3.1.0.jar connect-3.4.0.jar 
# flink-cdc-pipeline-connector-paimon-3.1.0.jar flink-connector-debezium-3.0.0.jar 
# flink-cdc-common-3.0.0.jar flink-cdc-base-3.0.0.jar flink-connector-postgres-cdc-3.0.0.jar 
# connect-2.8.0.jar connect-json-3.4.0.jar connect-api-0.9.0.0.jar  kafka-connect-storage-core-5.4.1.jar
 
FILES =    

# java.lang.NoClassDefFoundError: com/ververica/cdc/debezium/DebeziumDeserializationSchema
# -> flink-connector-debezium-3.0.0.jar
# Caused by: java.lang.ClassNotFoundException: com.ververica.cdc.debezium.DebeziumDeserializationSchema
# -> flink-cdc-pipeline-connector-paimon-3.1.0.jar
# java.lang.NoClassDefFoundError: com/ververica/cdc/connectors/base/source/jdbc/JdbcIncrementalSource
# -> flink-cdc-base-3.0.0.jar
# java.lang.NoClassDefFoundError: com/ververica/cdc/connectors/postgres/source/PostgresSourceBuilder$PostgresIncrementalSource
# -> flink-connector-postgres-cdc-3.0.0.jar
# Caused by: java.lang.NoClassDefFoundError: Lcom/ververica/cdc/connectors/shaded/org/apache/kafka/connect/json/JsonConverter;
# -> 

connector-create:
	@curl -X POST localhost:8083/connectors -H "Content-Type: application/json" -d @./connect/source-postgres.json

connector-status:
	@curl -i -X GET -H "Accept:application/json" localhost:8083/connectors/dwh.mydatabase.person/status

connector-reset:
	@curl -i -X POST -H "Accept:application/json" localhost:8083/connectors/dwh.mydatabase.person/restart
	# restart khong an thua, tot nhat la xoa di tao lai

connector-remove:
	@curl -i -X DELETE  localhost:8083/connectors/dwh.mydatabase.person

connector-kafka:
	@docker exec kafka bash -c "/usr/bin/kafka-console-consumer --bootstrap-server  localhost:9092 --topic dbz.public.person --from-beginning --group connect_configs"

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

LOGS = log4j-cli.properties log4j-console.properties
log:
	@for file in $(LOGS); do \
		echo "Processing $$file..."; \
		docker cp ./$$file           jobmanager:/opt/flink/conf/$$file ;\
		docker cp ./$$file docker-taskmanager-1:/opt/flink/conf/$$file; \
		docker cp ./$$file docker-taskmanager-2:/opt/flink/conf/$$file ;\
	done


change: 


	# docker cp log4j-cli.properties  jobmanager:/opt/flink/conf/log4j-cli.properties
	# docker cp log4j.properties jobmanager:/opt/flink/conf/log4j.properties
	# docker cp logback.xml jobmanager:/opt/flink/conf/logback.xml

	# docker cp log4j-console.properties  jobmanager:/opt/flink/conf/log4j-console.properties
	# docker cp log4j-console.properties  docker-taskmanager-1:/opt/flink/conf/log4j-console.properties
	# docker cp log4j-console.properties  docker-taskmanager-2:/opt/flink/conf/log4j-console.properties

	# docker cp hive-site.xml  jobmanager:/opt/flink/conf/hive-site.xml
	# docker cp hive-site.xml  docker-taskmanager-1:/opt/flink/conf/hive-site.xml
	# docker cp hive-site.xml  docker-taskmanager-2:/opt/flink/conf/hive-site.xml


	# docker cp apt.conf jobmanager:/etc/apt/apt.conf.d/10apt.conf
	# docker cp apt.conf docker-taskmanager-1:/etc/apt/apt.conf.d/10apt.conf
	# docker cp apt.conf docker-taskmanager-1:/etc/apt/apt.conf.d/10apt.conf


	docker exec jobmanager bash -c "chmod 775 /opt/flink/lib/*"
	docker exec docker-taskmanager-1 bash -c "chmod 775 /opt/flink/lib/*"
	docker exec docker-taskmanager-2 bash -c "chmod 775 /opt/flink/lib/*"
	docker exec jobmanager bash -c "chown flink:flink /opt/flink/lib/*"
	docker exec docker-taskmanager-1 bash -c "chown flink:flink /opt/flink/lib/*"
	docker exec docker-taskmanager-2 bash -c "chown flink:flink /opt/flink/lib/*"


	docker exec jobmanager bash -c           "chmod 775 /opt/flink/plugins/*"
	docker exec docker-taskmanager-1 bash -c "chmod 775 /opt/flink/plugins/*"
	docker exec docker-taskmanager-2 bash -c "chmod 775 /opt/flink/plugins/*"
	docker exec jobmanager bash -c           "chown flink:flink /opt/flink/plugins/*"
	docker exec docker-taskmanager-1 bash -c "chown flink:flink /opt/flink/plugins/*"
	docker exec docker-taskmanager-2 bash -c "chown flink:flink /opt/flink/plugins/*"


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

	# docker exec jobmanager bash -c "rm -f             /opt/flink/lib/flink-connector-postgres-cdc-3.0.0.jar"
	# docker exec docker-taskmanager-1 bash -c "rm -f   /opt/flink/lib/flink-connector-postgres-cdc-3.0.0.jar"
	# docker exec docker-taskmanager-2 bash -c "rm -f   /opt/flink/lib/flink-connector-postgres-cdc-3.0.0.jar"


