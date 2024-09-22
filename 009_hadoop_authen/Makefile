IMAGE_NAME := "hadoop-auth"
VER := "0.0.1"
USER := "longpt233"

build: 
	@echo "build ${IMAGE_NAME}:${VER}"
	@docker build -f ./base/Dockerfile -t ${USER}/${IMAGE_NAME}:${VER} ./base
    # docker login registry.example.com or docker login. check: docker info
	# @docker push ${USER}/${IMAGE_NAME}:${VER}

nifi: 
	@docker build -f ./nifi/Dockerfile -t ${USER}/${nifi-auth}:${VER} ./nifi


