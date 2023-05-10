#!/bin/bash

set -xe

pushd $TRANSCORER_DIR


	if [ -z "${BASE_MODEL_NAME}" ]; then
		BASE_MODEL_NAME="facebook/wav2vec2-large-xlsr-53"
	fi

	if [ -f "/transfer-checkpoint/checkpoint" -a ! -f "/mnt/models/wav2vec2-common_voice-fr/pytorch_model.bin" ]; then
		echo "Using checkpoint from /transfer-checkpoint/checkpoint"
		CHECKPOINT_FLAG='--model_name_or_path="/mnt/models/wav2vec2-common_voice-fr/" --output_dir="/mnt/models/wav2vec2-common_voice-fr" --resume_from_checkpoint="/transfer-checkpoint/checkpoint"'
	else
		echo "Using checkpoint from facebook/wav2vec2-large-xlsr-53"
		CHECKPOINT_FLAG="--model_name_or_path=${BASE_MODEL_NAME} --output_dir='/mnt/models/wav2vec2-common_voice-fr' --overwrite_output_dir"
	fi;

	HUB_FLAG=""
	if [ -z "$HUB_API_TOKEN" ]; then
		if [ -n "$MODEL_ID" ]; then
			echo "Missing MODEL_ID=${MODEL_ID}"
			echo "Please set MODEL_ID as environment variable or use --model_id"
		fi
		huggingface-cli login --token "${HUB_API_TOKEN}"
		HUB_FLAG="--push_to_hub --hub_token '${HUB_API_TOKEN}' --push_to_hub_model_id '${MODEL_ID}' --use_auth_token y"
	fi;

	AMP_FLAG="--fp32"
	if [ "${AMP}" = "1" ]; then
		AMP_FLAG="--fp16"
	fi;

	ENCODER_FLAG=""
	if [ "${FREEZE_ENCODER}" = "1" ]; then
		ENCODER_FLAG="--freeze_feature_encoder"
	fi;

	GRADIENT_ACCUMULATION_FLAG=""
	if [ "${GAS}" -gt "0" ]; then
		GRADIENT_ACCUMULATION_FLAG="--gradient_accumulation_steps=${GAS}"
	fi;

	if [ "${GRAD_CHECK}" = "1" ]; then
		GRADIENT_ACCUMULATION_FLAG="${GRADIENT_ACCUMULATION_FLAG} --gradient_checkpointing"
	fi;
	
	IGNORE_CHARS_FLAG=""
	if [ -z "${IGNORE_CHARS}" ]; then
		IGNORE_CHARS_FLAG="--chars_to_ignore ${IGNORE_CHARS}"
	elif [ "${DONT_WARN_IGNORE_CHARS}" != "1" ]; then
		echo "You should probably ignore some characters like: [ , ? . ! - ; : \" “ % ‘ ” � ]" #noqa
		echo -n "Do wish to proceed with training session without ignoring any characters? [type any key to start training or Ctr + C to exit] "
		read -n 1
	fi;

	if [ -n "${AUDIO_COLUMN}" ]; then
		echo "Set AUDIO_COLUMN=${AUDIO_COLUMN}"
		exit 1
	fi;

	if [ -n "${SIZE_COLUMN}" ]; then
		echo "Set SIZE_COLUMN=${SIZE_COLUMN}"
		exit 1
	fi;

	if [ -n "${TEXT_COLUMN}" ]; then
		echo "Set TEXT_COLUMN=${TEXT_COLUMN}"
		exit 1
	fi;

	if [ "${WARMUP_RATIO}" -gt "0" ]; then
		WARMUP_FLAG="--warmup_ratio=${WARMUP_RATIO}"
	elif [ "${WARMUP_STEPS}" -gt "0" ]; then
		WARMUP_FLAG="--warmup_steps=${WARMUP_STEPS}"
	fi

	if [ ! -f "/mnt/models/wav2vec2-common_voice-fr/checkpoint-*/*model.bin" ]; then
		trainscorer \
		--data_path "/mnt/extracted/data" \
		--dataset_name "wav2vec" \
		--dataset_config_name="fr" \
		${CHECKPOINT_FLAG} \
		--preprocessing_num_workers="${NPROC}" \
		--num_train_epochs="${EPOCHS}" \
		--per_device_train_batch_size="${BATCH_SIZE}" \
		${GRADIENT_ACCUMULATION_FLAG} \
		--learning_rate="${LEARNING_RATE}" \
		${WARMUP_FLAG} \
		--evaluation_strategy="${EVAL_STRAT}" \
		--text_column_name="${TEXT_COLUMN}" \
		--audio_column_name="${AUDIO_COLUMN}" \
		--length_column_name="${SIZE_COLUMN}" \
		--save_steps="${SAVE_STEPS}" \
		--eval_steps="${EVAL_STEPS}" \
		--layerdrop="${DROPOUT}" \
		--save_total_limit="${MAX_CHECKPOINTS}" \
		${ENCODER_FLAG} \
		${IGNORE_CHARS_FLAG} \
		${AMP_FLAG} \
		--cache_dir "/mnt/tmp/wav2vec2-common_voice-fr" \
		--group_by_length \
		${HUB_FLAG} \
		--do_train y --do_eval y
	fi;
popd
