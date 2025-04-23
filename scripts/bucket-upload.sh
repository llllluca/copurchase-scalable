#!/bin/sh

usage() {
    echo "Usage: $0 SOURCE_PATH [CLOUD_DESTINATION_PATH]"
}

if [ -z "$1" ]; then
    echo "Missing file operand." >&2
    usage $0 >&2
    exit 1
fi

SCRIPT_HOME="$(realpath $(dirname $0))"
. ${SCRIPT_HOME}/config.sh
$GCLOUD storage cp $1 "$CLOUD_STORAGE_BUCKET/${2}"
