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

