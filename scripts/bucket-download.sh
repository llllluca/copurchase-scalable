#!/bin/sh

. "$(pwd)/$(dirname $0)/config.sh"
$GCLOUD storage cp --recursive "${CLOUD_STORAGE_BUCKET}/${1}" $2
