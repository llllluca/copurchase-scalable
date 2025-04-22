#!/bin/sh

. "$(pwd)/$(dirname $0)/config.sh"
$GCLOUD storage ls $CLOUD_STORAGE_BUCKET
