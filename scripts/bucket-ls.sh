#!/bin/sh

SCRIPT_HOME="$(realpath $(dirname $0))"
. ${SCRIPT_HOME}/config.sh
$GCLOUD storage ls $CLOUD_STORAGE_BUCKET
