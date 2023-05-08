#!/bin/sh

set -xe

THIS=$(dirname "$0")
export PATH=${THIS}:${THIS}/${MODEL_LANGUAGE}:$PATH

env

checks.sh

export TMP=/mnt/tmp
export TEMP=/mnt/tmp

. params.sh
. ${MODEL_LANGUAGE}/params.sh

cd ${MODEL_LANGUAGE} && importers.sh && cd ..

train.sh

test.sh