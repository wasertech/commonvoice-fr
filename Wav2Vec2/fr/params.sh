#!/bin/sh

set -xe

# This file will contain default values

export IMPORTERS_VALIDATE_LOCALE=""

export CV_RELEASE_FILENAME=""
export CV_RELEASE_SHA256=""

export LINGUA_LIBRE_QID=""
export LINGUA_LIBRE_ISO639=""
export LINGUA_LIBRE_ENGLISH=""
export LINGUA_LIBRE_SKIPLIST=""

export M_AILABS_LANG=""
export M_AILABS_SKIP=""

export LM_ICONV_LOCALE=""

export MODEL_EXPORT_SHORT_LANG=""
export MODEL_EXPORT_LONG_LANG=""
export MODEL_EXPORT_ZIP_LANG=""


export IGNORE_CHAR_FILE="${MODEL_LANGUAGE}/ignore_chars.txt"

export AUDIO_COLUMN="wav_filename"
export SIZE_COLUMN="wav_filesize"
export TEXT_COLUMN="transcript"