#!/bin/sh

. "$(pwd)/$(dirname $0)/config.sh"
$GCLOUD storage cp $1 "$CLOUD_STORAGE_BUCKET/${2}"
