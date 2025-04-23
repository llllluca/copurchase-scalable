#!/bin/sh

set -e

SCRIPT_HOME="$(realpath $(dirname $0))"
. ${SCRIPT_HOME}/config.sh
workers=2

usage() {
    echo "Usage: $0 [--num-workers=[2-9]]"
}

for opt in "$@"; do
    case $opt in
        --num-workers=[2-9]) 
            workers=$(echo $opt | sed 's/[^=]*=//')
            ;;
        *) 
            echo "Error: \`${opt}' is an invalid option." >&2
            usage $0 >&2
            exit 1
            ;;
    esac
done

$GCLOUD dataproc clusters create $CLUSTER_NAME --region $CLUSTER_REGION \
--num-workers $workers --master-boot-disk-size 240 --worker-boot-disk-size 240 \
--image-version $CLUSTER_IMAGE_VERSION

