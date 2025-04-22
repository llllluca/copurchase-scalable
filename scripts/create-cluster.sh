#!/bin/sh

. "$(pwd)/$(dirname $0)/config.sh"
$GCLOUD dataproc \
clusters create $CLUSTER_NAME --region $CLUSTER_REGION \
--num-workers 2 --master-boot-disk-size 240 --worker-boot-disk-size 240 \
--image-version $CLUSTER_IMAGE_VERSION

