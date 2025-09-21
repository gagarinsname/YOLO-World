#!/bin/bash

ENTRYPOINT=${ENTRYPOINT:-/bin/bash}
CONTAINER_NAME=${CONTAINER_NAME:-yoloworld10}
mkdir -p $OUTPUT

# YOLO_DATA is the path to the data directory
YOLO_DATA=${YOLO_DATA:-$PWD}

echo "======================================================================================="
echo "Container name: $CONTAINER_NAME"
echo "Data directory: $YOLO_DATA"
echo "Command: $@"
echo "======================================================================================="

docker run --name ${CONTAINER_NAME} \
	--gpus all \
	--shm-size 24gb \
	--network host \
	-it \
	--rm \
	-u $(id -u):$(id -g) \
	-v $PWD:/yoloworld \
	-v $YOLO_DATA:/data \
	-v $OUTPUT:/output \
	-e HISTFILE=/yoloworld/.docker_bash_history \
	--workdir /yoloworld \
	yoloworld "$@"
