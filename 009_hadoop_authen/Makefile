IMAGE_NAME := "hadoop-auth"
NIFI_IMAGE_NAME := "nifi-auth"
VER := "0.0.1"
USER := "longpt233"
HTTP_PROXY := http://10.208.164.185:9999
HTTPS_PROXY := http://10.208.164.185:9999


.PHONY: build nifi

build: 
	@echo "build ${IMAGE_NAME}:${VER}"
	@docker build -f ./base/Dockerfile -t ${USER}/${IMAGE_NAME}:${VER} ./base
nifi: 
	@docker build --build-arg HTTP_PROXY=${HTTP_PROXY} --build-arg HTTPS_PROXY=${HTTPS_PROXY} -f ./nifi/Dockerfile -t ${USER}/${NIFI_IMAGE_NAME}:${VER} ./nifi
