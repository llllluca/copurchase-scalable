#!/bin/sh

usage() {
    echo "Usage: $0 CLOUD_SOURCE_PATH DESTINATION_PATH"
}

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Missing file operand." >&2
    usage $0 >&2
    exit 1
fi

SCRIPT_HOME="$(realpath $(dirname $0))"
. ${SCRIPT_HOME}/config.sh
$GCLOUD storage cp --recursive "${CLOUD_STORAGE_BUCKET}/${1}" $2
