## Installation Guide

YOLO-World is built based on `pytorch=1.11.0` and `mmcv=2.0.0`.

We provide the `requirements` files in [./requirements](./../requirements/):

* `basic_requirements`: training, finetuning, evaluation, demo.
* `onnx_requirements`: converting YOLO-World to ONNX or TFLite models (TFLite is coming soon).


**1. Use inside conda environment:**

- Create conda environment with python<=3.11:

```bash
conda create -n yoloworld python=3.11
```

- Install basic requirements:

```bash
pip install --no-cache-dir -r requirements/basic_requirements.txt
```

- Install `mmyolo` from the `third_party` as editable dependance:

```bash
pip install -e third_party/mmyolo
```

- Download LVIS annotations and weights for one of the demo models:

```bash
bash requirements/download_assets.sh
```

**2. Or use docker image**

- Build docker image:

```bash
bash docker_build.sh
```

- Download LVIS annotations and weights for one of the demo models:

```bash
bash requirements/download_assets.sh
```

- Run docker image in an interactive shell:

```bash
YOLO_DATA=<PATH_TO_DATA> OUTPUT=<PATH_TO_OUTPUT> bash docker_shell.sh
```