#!/bin/sh

SCRIPT_HOME="$(realpath $(dirname $0))"
. ${SCRIPT_HOME}/config.sh

$GCLOUD storage buckets create $CLOUD_STORAGE_BUCKET --location $BUCKET_LOCATION
