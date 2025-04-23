#!/bin/sh

SCRIPT_HOME="$(realpath $(dirname $0))"
. ${SCRIPT_HOME}/config.sh
$GCLOUD storage rm --recursive "$CLOUD_STORAGE_BUCKET/${1}"

