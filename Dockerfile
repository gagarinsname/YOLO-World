FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

ENV LC_ALL="en_US.UTF-8" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    MMCV_WITH_OPS=1 \
    FORCE_CUDA="1" \
    OPENCV_IO_ENABLE_OPENEXR=1 \
    CMAKE_VERSION=3.25.2 \
    CMAKE_POLICY_VERSION_MINIMUM=3.5 \
    DISPLAY=:99

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y locales apt-utils \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=en_US.UTF-8 \
    && apt-get install -y --no-install-recommends \
    python-is-python3 \
    curl \ 
    wget \
    python3-pip     \
    libgl1-mesa-glx \
    libsm6          \
    libxext6        \
    libxrender-dev  \
    libglib2.0-0    \
    git             \
    python3-dev     \
    python3-wheel

# COPY requirements/basic_requirements.txt ./

ENV PYTHONPATH="/yoloworld"

WORKDIR /root

RUN curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.6.0/fixuid-0.6.0-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: user\ngroup: user\n" > /etc/fixuid/config.yml

COPY . /yoloworld
WORKDIR /yoloworld

RUN pip install --upgrade pip \
    && pip install -r /yoloworld/requirements/basic_requirements.txt

RUN addgroup user \
    && useradd user -s /bin/bash -g user -md /home/user

RUN pip install -e /yoloworld/third_party/mmyolo \
    && pip install -e .[dev]

USER user:user
WORKDIR /home/user

ENTRYPOINT [ "fixuid"]

CMD ["/bin/bash"]

