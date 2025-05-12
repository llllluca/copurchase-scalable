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
    --enable-component-gateway \
    --region ${CLUSTER_REGION} \
    --zone ${CLUSTER_ZONE} \
    --master-boot-disk-size ${DISK_SIZE_GB} \
    --worker-boot-disk-size ${DISK_SIZE_GB} \
    --image-version ${CLUSTER_IMAGE_VERSION} \
    --worker-machine-type ${MACHINE_TYPE} \
    --master-machine-type ${MACHINE_TYPE}"


if [ "$WORKERS" -eq 1 ]; then
    $GCLOUD dataproc clusters create $CLUSTER_NAME \
        $COMMON_PARAMS \
        --single-node
else
    $GCLOUD dataproc clusters create $CLUSTER_NAME \
        $COMMON_PARAMS \
        --num-workers $WORKERS
fi

