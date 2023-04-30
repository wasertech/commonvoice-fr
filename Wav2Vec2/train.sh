#!/bin/bash

set -xe

pushd $TRANSCORER_DIR
	trainscorer \
	--data_path '/mnt/extracted/data' \
	--model_name_or_path="facebook/wav2vec2-large-xlsr-53" \
	--dataset_name "wav2vec" \
	--dataset_config_name="fr" \
	--output_dir="/mnt/models/wav2vec2-common_voice-fr" \
	--overwrite_output_dir \
	--num_train_epochs="15" \
	--per_device_train_batch_size="16" \
	--gradient_accumulation_steps="2" \
	--learning_rate="3e-4" \
	--warmup_steps="500" \
	--evaluation_strategy="steps" \
	--text_column_name="transcript" \
	--audio_column_name="wav_filename" \
	--length_column_name="wav_filesize" \
	--save_steps="400" \
	--eval_steps="100" \
	--layerdrop="0.0" \
	--save_total_limit="3" \
	--freeze_feature_encoder \
	--gradient_checkpointing \
	--chars_to_ignore , ? . ! - \; \: \" “ % ‘ ” � \
	--fp16 \
	--group_by_length \
	--push_to_hub \
	--do_train y --do_eval y
popd
