#!/bin/sh

. "$(pwd)/$(dirname $0)/config.sh"
$GCLOUD storage rm --recursive "$CLOUD_STORAGE_BUCKET/${1}"

