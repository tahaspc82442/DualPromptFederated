#!/bin/bash

#cd ../..

# custom config
DATA=/raid/biplab/taha
TRAINER=DualPromptFL

DATASET=$1
SEED=$2

EP=2

CFG=vit_b16_c2_ep5_batch4_2ctx_cross_datasets
SHOTS=16

#DIR=output/evaluation/${TRAINER}/${CFG}_${SHOTS}shots/${DATASET}/seed${SEED}
DIR=output/evaluation/DualPromptFL/${CFG}_${SHOTS}shots/${DATASET}/seed${SEED}
if [ -d "$DIR" ]; then
    echo "Results are available in ${DIR}. Skip this job"
else
    echo "Run this job and save the output to ${DIR}"

    python train.py \
    --root ${DATA} \
    --seed ${SEED} \
    --trainer ${TRAINER} \
    --dataset-config-file configs/datasets/${DATASET}.yaml \
    --config-file configs/trainers/${TRAINER}/${CFG}.yaml \
    --output-dir ${DIR} \
    --model-dir output/${DATASET}/DualPromptFL/${CFG}_${SHOTS}shots/seed${SEED} \
    --load-epoch ${EP} \
    --eval-only
fi