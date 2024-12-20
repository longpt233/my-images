HBASE_IMAGE_NAME := "hbase"
HADOOP_IMAGE_NAME := "hadoop-insecure"
VER := "0.0.1"
USER := "longpt233"


build: 
	@echo "build ${IMAGE_NAME}:${VER}"
	@docker build -f ./hadoop/Dockerfile -t ${USER}/${HADOOP_IMAGE_NAME}:${VER} .
	@docker build -f ./hbase/Dockerfile  -t ${USER}/${HBASE_IMAGE_NAME}:${VER} . 

test:
	@docker run -it ${USER}/${HBASE_IMAGE_NAME}:${VER}

run:
	@docker compose up -d

clean: 
	@docker compose down -v 

# https://community.cloudera.com/t5/Community-Articles/How-to-integrate-Spark3-with-HBase/ta-p/371238
# https://github.com/LucaCanali/Miscellaneous/blob/master/Spark_Notes/Spark_HBase_Connector.md

get: 
	@docker cp dragonhbase:/hbase.ipynb /data/repo/my-images/006_hbase-hadoop/docker/phoenix/hbase.ipynb 
	@docker cp dragonhbase:/mysql.ipynb /data/repo/my-images/006_hbase-hadoop/docker/phoenix/mysql.ipynb 
	@docker cp dragonhbase:/phoenix.ipynb /data/repo/my-images/006_hbase-hadoop/docker/phoenix/phoenix.ipynb 

sync:

	@docker cp /home/long/IdeaProjects/custom-libs/hbase-connector/hbase-connectors/spark/hbase-spark/target/hbase-spark-1.1.0-SNAPSHOT.jar dragonhbase:/tmp
	@docker cp /home/long/IdeaProjects/custom-libs/datahub/datahub/metadata-integration/java/spark-lineage-beta/build/libs/acryl-spark-lineage-5206f9d-SNAPSHOT.jar dragonhbase:/tmp


	# @docker cp /data/jar/phoenix-hbase-compat-2.4.1-5.1.3.jar dragonhbase:/tmp
	# @docker cp /data/jar/phoenix-core-5.1.3.jar dragonhbase:/tmp
	# @docker cp /data/jar/phoenix5-spark3-6.0.0.7.2.17.0-334.jar dragonhbase:/tmp
	# @docker cp /data/my-images/006_hbase-hadoop/docker/hbase-spark-1.0.0.jar dragonhbase:/tmp
	# @docker cp /data/my-images/006_hbase-hadoop/docker/hbase-spark-1.0.1.jar dragonhbase:/tmp
	# @docker cp /data/my-images/006_hbase-hadoop/docker/hbase-server-2.4.14.jar dragonhbase:/tmp
	# @docker cp /data/my-images/006_hbase-hadoop/docker/hbase-client-2.4.14.jar dragonhbase:/tmp
	# @docker cp /data/my-images/006_hbase-hadoop/docker/hbase-spark3-protocol-shaded-1.0.0.7.2.17.0-334.jar dragonhbase:/tmp
	# @docker cp /data/my-images/006_hbase-hadoop/docker/hbase-spark-1.0.1-SNAPSHOT_spark331_hbase2415.jar dragonhbase:/tmp
	# @docker cp /data/my-images/006_hbase-hadoop/docker/hbase-spark-protocol-shaded-1.0.1-SNAPSHOT_spark331_hbase2415.jar dragonhbase:/tmp
	# @docker cp /data/my-images/006_hbase-hadoop/docker/hbase-shaded-mapreduce-2.4.15.jar dragonhbase:/tmp
	# @docker cp /data/my-images/006_hbase-hadoop/docker/scala-library-2.12.1.jar dragonhbase:/tmp
	# @docker cp /data/my-images/006_hbase-hadoop/docker/htrace-core4-4.2.0-incubating.jar dragonhbase:/tmp
	# @docker cp /data/my-images/006_hbase-hadoop/docker/mysql-connector-java-8.0.29.jar dragonhbase:/tmp
	# @docker cp /data/my-images/006_hbase-hadoop/docker/hbase-spark3-1.0.0.7.2.17.0-334.jar dragonhbase:/tmp
	# @docker cp /data/my-images/006_hbase-hadoop/docker/scala-parser-combinators_2.12-2.1.1.jar dragonhbase:/tmp
	# @docker cp /data/my-images/006_hbase-hadoop/docker/hbase-mapreduce-2.4.15.jar dragonhbase:/tmp
	