#!/bin/bash

CUDA_ARCH=${1:-$(nvidia-smi --query-gpu=compute_cap --format=noheader,csv)}
COMPUTE_CAPABILITY=$(sed s/\\.// <<< $CUDA_ARCH)

echo "Builing base image for compute capability ${COMPUTE_CAPABILITY}"
docker build --rm -t yoloworld $(dirname $(realpath $0)) \
    --build-arg TORCH_CUDA_ARCH_LIST=${CUDA_ARCH} \
    --build-arg COMPUTE_CAPABILITY=${COMPUTE_CAPABILITY}
