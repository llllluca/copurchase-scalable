#!/bin/sh

. "$(pwd)/$(dirname $0)/config.sh"
$GCLOUD dataproc \
jobs submit spark --cluster $CLUSTER_NAME --region $CLUSTER_REGION \
--jar ${CLOUD_STORAGE_BUCKET}/Hello.jar

