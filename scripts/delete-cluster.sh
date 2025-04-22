#!/bin/sh

. "$(pwd)/$(dirname $0)/config.sh"
$GCLOUD dataproc \
clusters delete $CLUSTER_NAME  --region $CLUSTER_REGION
