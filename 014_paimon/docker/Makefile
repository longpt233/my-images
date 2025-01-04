build: 
	@docker build -f ./hms/Dockerfile -t longpt233/hms:0.0.1 .

get-lib: 
	@cd ./spark-delta && wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.375/aws-java-sdk-bundle-1.11.375.jar
	@cd ./spark-delta && wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.1/hadoop-aws-3.3.1.jar 
	@cd ./spark-delta && wget https://repo1.maven.org/maven2/io/delta/delta-core_2.12/1.0.0/delta-core_2.12-1.0.0.jar

run: 
	@docker run -it -p 18080:18080 -v ./spark-delta:/home longpt233/spark-delta:0.0.1