#!/bin/bash

set -xe

pushd $TRANSCORER_DIR


	if [ -f "/transfer-checkpoint/checkpoint" -a ! -f "/mnt/models/wav2vec2-common_voice-fr/pytorch_model.bin" ]; then
		echo "Using checkpoint from /transfer-checkpoint/checkpoint"
		CHECKPOINT_FLAG='--model_name_or_path="/mnt/models/wav2vec2-common_voice-fr/" --output_dir="/mnt/models/wav2vec2-common_voice-fr" --resume_from_checkpoint="/transfer-checkpoint/checkpoint"'
	else
		echo "Using checkpoint from facebook/wav2vec2-large-xlsr-53-french"
		CHECKPOINT_FLAG='--model_name_or_path="facebook/wav2vec2-large-xlsr-53-french" --output_dir="/mnt/models/wav2vec2-common_voice-fr" --overwrite_output_dir'
	fi;

	AMP_FLAG=""
	if [ "${AMP}" = "1" ]; then
		AMP_FLAG="--automatic_mixed_precision True"
	fi;

	HUB_FLAG=""
	if [ -z "$HUB_API_TOKEN" ]; then
		if [ -n "$MODEL_ID" ]; then
			echo "Missing MODEL_ID=${MODEL_ID}"
			echo "Please set MODEL_ID as environment variable or use --model_id"
		fi
		HUB_FLAG="--push_to_hub --hub_token '${HUB_API_TOKEN}' --push_to_hub_model_id '${MODEL_ID}' --use_auth_token y"
	fi;

	AMP_FLAG="--fp32"
	if [ "${AMP}" = "1" ]; then
		AMP_FLAG="--fp16"
	fi;

	GRADIENT_ACCUMULATION_FLAG=""
	if [ "${GAS}" -gt "0" ]; then
		GRADIENT_ACCUMULATION_FLAG="--gradient_accumulation_steps='${GAS}'"
	fi;

	EVAL_STRAT="steps"

	if [ ! -f "/mnt/models/wav2vec2-common_voice-fr/checkpoint-*/*model.bin" ]; then
		trainscorer \
		--data_path '/mnt/extracted/data' \
		--model_name_or_path="facebook/wav2vec2-large-xlsr-53" \
		--dataset_name "wav2vec" \
		--dataset_config_name="fr" \
		${CHECKPOINT_FLAG} \
		--preprocessing_num_workers="${NPROC}" \
		--num_train_epochs="${EPOCHS}" \
		--per_device_train_batch_size="${BATCH_SIZE}" \
		${GRADIENT_ACCUMULATION_FLAG} \
		--learning_rate="${LEARNING_RATE}" \
		--warmup_steps="500" \
		--evaluation_strategy="${EVAL_STRAT}" \
		--text_column_name="transcript" \
		--audio_column_name="wav_filename" \
		--length_column_name="wav_filesize" \
		--save_steps="400" \
		--eval_steps="100" \
		--layerdrop="${DROPOUT}" \
		--save_total_limit="3" \
		--freeze_feature_encoder \
		--gradient_checkpointing \
		--chars_to_ignore ${IGNORE_CHARS} \
		${AMP_FLAG} \
		--cache_dir "/mnt/tmp/wav2vec2-common_voice-fr" \
		--group_by_length \
		${HUB_FLAG} \
		--do_train y --do_eval y
	fi;
popd
