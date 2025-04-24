#!/bin/sh

SCRIPT_HOME="$(realpath $(dirname $0))"
. ${SCRIPT_HOME}/config.sh

WORKERS=1

usage() {
    echo "Usage: $0 [--num-workers=[1-9]]"
}

for opt in "$@"; do
    case $opt in
        --num-workers=[1-9]) 
            WORKERS=$(echo $opt | sed 's/[^=]*=//')
            ;;
        *) 
            echo "Error: \`${opt}' is an invalid option." >&2
            usage $0 >&2
            exit 1
            ;;
    esac
done

COMMON_PARAMS="\
    --region ${CLUSTER_REGION} \
    --master-boot-disk-size ${MASTER_DISK_SIZE} \
    --worker-boot-disk-size ${WORKER_DISK_SIZE} \
    --image-version ${CLUSTER_IMAGE_VERSION} \
    --worker-machine-type ${WORKER_MACHINE} \
    --master-machine-type ${MASTER_MACHINE}"


if [ "$WORKERS" -eq 1 ]; then
    $GCLOUD dataproc clusters create $CLUSTER_NAME \
        $COMMON_PARAMS \
        --single-node
else
    $GCLOUD dataproc clusters create $CLUSTER_NAME \
        $COMMON_PARAMS \
        --num-workers $WORKERS
fi

