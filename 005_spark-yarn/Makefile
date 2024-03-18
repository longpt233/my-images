
hdfs-conf:
	@docker cp ./config/capacity-scheduler.xml hadoop-slave1:/usr/local/hadoop/etc/hadoop/
	@docker cp ./config/capacity-scheduler.xml hadoop-slave2:/usr/local/hadoop/etc/hadoop/
	@docker cp ./config/capacity-scheduler.xml hadoop-master:/usr/local/hadoop/etc/hadoop/

	@docker cp ./config/yarn-site.xml hadoop-slave1:/usr/local/hadoop/etc/hadoop/
	@docker cp ./config/yarn-site.xml hadoop-slave2:/usr/local/hadoop/etc/hadoop/
	@docker cp ./config/yarn-site.xml hadoop-master:/usr/local/hadoop/etc/hadoop/

spark-conf:
	@docker cp ./spark/config/log4j.properties hadoop-master:/usr/local/spark-3.1.2-bin-hadoop3.2/conf/