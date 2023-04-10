#ENTRY POINT COMMANDS REQUIRED


# CREATE SEGMENTATION MAPS FROM .PNGS FOR TASK_01
CUDA_VISIBLE_DEVICEs=0 python3 validation_inference_part_1.py \
--input /input/01_MANUAL \
--output /predict \
--architecture unet \
--normalise True \
--model_path "/app/SemiCOL-inference-docker/trained_models/g4jx4n9k/checkpoint_epoch37.pth" \
--overlap 192 \
--num_classes 11

# CREATE LIST OF PATCHES WHICH ARE NOT BACKGROUND (CLAM'S CREATE_PATCHES)
CUDA_VISIBLE_DEVICES=0 python3 create_patches.py \
--source /input/02_BX \
--save_dir ./coords \
--patch_size 256 \
--seg --patch --stitch \
--preset semicol.csv

# RUN INFERENCE FOR TASK-02 AND GET PIXEL COUNTS
CUDA_VISIBLE_DEVICES=0 python3 validation_inference_part_2_01.py \
--coords ./coords/patches/ --input_data /input/02_BX \
--model_path "/app/SemiCOL-inference-docker/trained_models/g4jx4n9k/checkpoint_epoch37.pth" \
--num_classes 11

# CONVERT CLASS COUNT INSIDENCE TO PERCENTAGE THEN RUN THROUGH THRESHHOLDING
# TO OUTPUT A JSON FILE (classification.json)
CUDA_VISIBLE_DEVICES=0 python3 validation_inference_part_2_02.py