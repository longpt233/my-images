IMAGE_NAME := "postgres-ha"
VER := "0.0.1"
USER := "longpt233"

build: 
	@echo "build ${IMAGE_NAME}:${VER}"
	@docker build -f ./Dockerfile -t ${USER}/${IMAGE_NAME}:${VER} . 