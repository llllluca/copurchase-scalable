#!/bin/sh

. "$(pwd)/$(dirname $0)/config.sh"
$GCLOUD dataproc \
jobs submit spark --cluster $CLUSTER_NAME --region $CLUSTER_REGION \
--jar ${CLOUD_STORAGE_BUCKET}/CoPurchaseAnalysis.jar \
-- ${CLOUD_STORAGE_BUCKET}/toy_dataset.csv ${CLOUD_STORAGE_BUCKET}/output/


