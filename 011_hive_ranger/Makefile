USER := "longpt233"

UBUNTU_NAME := "ubuntu"
UBUNTU_VER := "base-22.04"

HADOOP_NAME := "hadoop"
HADOOP_VER := "insecure"

HMS_NAME := "hms"
HMS_VER := "stanalone"

TRINO_NAME := "trino"
TRINO_VER := "standalone"

build:
	@echo "build ${UBUNTU_NAME}:${UBUNTU_VER}"
	@docker build -f ./base/Dockerfile -t ${USER}/${UBUNTU_NAME}:${UBUNTU_VER} ./base
	@echo "build ${HADOOP_NAME}:${HADOOP_VER}"
	@docker build --build-arg BASE_VERSION=${USER}/${UBUNTU_NAME}:${UBUNTU_VER} -f ./hadoop-insecure/Dockerfile -t ${USER}/${HADOOP_NAME}:${HADOOP_VER} .
	@echo "build ${TRINO_NAME}:${TRINO_VER}"
	@docker build --build-arg BASE_VERSION=${USER}/${UBUNTU_NAME}:${UBUNTU_VER} -f ./trino/Dockerfile -t ${USER}/${TRINO_NAME}:${TRINO_VER} .
	@docker build -f ./ranger/Dockerfile -t ${USER}/ranger:admin .

build-base: 
	@echo "build ${UBUNTU_NAME}:${UBUNTU_VER}"
	@docker build -f ./base/Dockerfile -t ${USER}/${UBUNTU_NAME}:${UBUNTU_VER} ./base

build-hadoop-hms:
	@echo "build ${HADOOP_NAME}:${HADOOP_VER}"
	@docker build --build-arg BASE_VERSION=${USER}/${UBUNTU_NAME}:${UBUNTU_VER} -f ./hadoop-insecure/Dockerfile -t ${USER}/${HADOOP_NAME}:${HADOOP_VER} .

# build-hms:
# 	@echo "build ${HMS_NAME}:${HMS_VER}"
# 	@docker build --build-arg BASE_VERSION=${USER}/${UBUNTU_NAME}:${UBUNTU_VER} -f ./hms/Dockerfile -t ${USER}/${HMS_NAME}:${HMS_VER} .

build-trino:
	@echo "build ${TRINO_NAME}:${TRINO_VER}"
	@docker build -f ./trino/Dockerfile -t ${USER}/${TRINO_NAME}:${TRINO_VER} .

# khoong lam nhu nay duoc vi k co duong mang tu cho build sang ben container
#@docker compose up -d postgres
#@docker compose stop postgres
build-ranger:	
	@docker build -f ./ranger/Dockerfile -t ${USER}/ranger:admin .
	