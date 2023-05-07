#!/bin/bash

set -xe

pushd $TRANSCORER_DIR
	python -m scorer.evaluate
popd
