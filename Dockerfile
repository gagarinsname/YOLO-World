FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

ARG MODEL="yolo_world_v2_x_vlpan_bn_2e-3_100e_4x8gpus_obj365v1_goldg_train_lvis_minival.py"
ARG WEIGHT="yolo_world_v2_x_obj365v1_goldg_cc3mlite_pretrain_1280ft-14996a36.pth"
ARG ANNOTATIONS="lvis_v1_minival_inserted_image_name.json"

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

RUN mkdir weights && curl -o weights/$WEIGHT -L https://huggingface.co/wondervictor/YOLO-World/resolve/main/$WEIGHT

RUN mkdir -p data/coco/lvis \
    &&  curl -o data/coco/lvis/${ANNOTATIONS} https://huggingface.co/GLIPModel/GLIP/resolve/main/${ANNOTATIONS}

ENTRYPOINT [ "/bin/bash" ]