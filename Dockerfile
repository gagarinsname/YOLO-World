FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

ENV FORCE_CUDA="1"
ENV MMCV_WITH_OPS=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    python-is-python3 \
    curl \ 
    python3-pip     \
    libgl1-mesa-glx \
    libsm6          \
    libxext6        \
    libxrender-dev  \
    libglib2.0-0    \
    git             \
    python3-dev     \
    python3-wheel

COPY requirements/basic_requirements.txt ./

RUN pip install --upgrade pip \
    && pip install -r basic_requirements.txt

WORKDIR /yoloworld

COPY . /yoloworld

RUN pip install -e /yoloworld/third_party/mmyolo \
    && pip install -e .[dev]

ENTRYPOINT [ "/bin/bash" ]