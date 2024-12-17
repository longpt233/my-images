# 1. cau hinh chuan hbase tren mang 
# 
# https://github.com/Abhey/phoenix-spark-connector-demo/blob/main/Dockerfile
  
# .config("spark.jars", 
#"/tmp/hbase-spark-1.0.1-SNAPSHOT_spark331_hbase2415.jar,\
# /tmp/hbase-spark-protocol-shaded-1.0.1-SNAPSHOT_spark331_hbase2415.jar,
# /tmp/acryl-spark-lineage-5206f9d-SNAPSHOT.jar,\
# /tmp/hbase-shaded-mapreduce-2.4.15.jar,
# /hbase-site.xml.jar,
# /tmp/scala-parser-combinators_2.12-2.1.1.jar,
# /tmp/htrace-core4-4.2.0-incubating.jar") \


# 2. cấu hình build ra 1 file spark habse
# https://kontext.tech/article/628/spark-connect-to-hbase


# 3. mysql 
# /tmp/mysql-connector-java-8.0.29.jar

# backup
    # .config("spark.hadoop.hbase.zookeeper.quorum", "localhost") \
    # .config("spark.hadoop.hbase.zookeeper.property.clientPort", "2181") \
    # .config("spark.hadoop.hbase.master", "localhost:16000") \
    # .config("spark.executor.extraClassPath", "/usr/local/hbase/lib/")\
    # .config("spark.driver.extraClassPath", "/usr/local/hbase/lib/")\
# /hbase-site.xml.jar, ?????
#     /tmp/hbase-client-2.4.14.jar,/tmp/hbase-server-2.4.14.jar,/tmp/hbase-mapreduce-2.4.15.jar
#     /tmp/hbase-spark3-protocol-shaded-1.0.0.7.2.17.0-334.jar
#    /tmp/phoenix5-spark3-6.0.0.7.2.17.0-334.jar,/tmp/phoenix-hbase-compat-2.4.1-5.1.3.jar,/tmp/scala-parser-combinators_2.12-2.1.1.jar,\
#    /usr/local/phoenix/phoenix-client-hbase-2.4-5.1.3.jar,/tmp/phoenix-core-5.1.3.jar,\
    # /tmp/hbase-client-2.4.14.jar,/tmp/hbase-server-2.4.14.jar,/tmp/hbase-mapreduce-2.4.15.jar, \


# https://mrudulamadiraju.medium.com/hello-hbaseworld-from-spark-world-73d06c5d2552
# https://medium.com/@abhey.mnnit/olap-on-apache-phoenix-in-python-using-apache-spark-422dc6ec92e5