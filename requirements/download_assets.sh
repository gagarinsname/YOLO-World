ANNOTATIONS_NAME=lvis_v1_minival_inserted_image_name.json
WEIGHTS_NAME=yolo_world_v2_x_obj365v1_goldg_cc3mlite_pretrain_1280ft-14996a36.pth

# NOTE: this is the model config file to use with the downloaded weigts added for reference
MODEL_CONFIG=yolo_world_v2_x_vlpan_bn_2e-3_100e_4x8gpus_obj365v1_goldg_train_lvis_minival.py

mkdir -p ./data/coco/lvis
wget -p data/coco/lvis/ https://huggingface.co/GLIPModel/GLIP/resolve/main/${ANNOTATIONS_NAME}

mkdir -p ./weights
wget -p weights https://huggingface.co/wondervictor/YOLO-World/resolve/main/$WEIGHTS_NAME