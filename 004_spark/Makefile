IMAGE_NAME := "spark-alone"
VER := "vtp-1.0.1"
USER := "longpt233"

build: 
	@echo "build ${IMAGE_NAME}:${VER}"
# --build-arg HTTP_PROXY="http://10.63:8080" --build-arg HTTPS_PROXY="http://10.3:8080" 
	@docker build  --network=host --no-cache -f ./vtp/Dockerfile -t ${USER}/${IMAGE_NAME}:${VER} ./vtp

# @docker build --build-arg NO_PROXY="127.0.0.1,l" -f ./Dockerfile  -t ${USER}/${IMAGE_NAME}:${VER} .
# docker login registry.example.com or docker login. check: docker info
# @docker push ${USER}/${IMAGE_NAME}:${VER}

start:
	@docker compose up