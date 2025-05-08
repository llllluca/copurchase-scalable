#!/bin/sh

SCRIPT_HOME="$(realpath $(dirname $0))"
. ${SCRIPT_HOME}/config.sh

$GCLOUD dataproc clusters describe $CLUSTER_NAME --region $CLUSTER_REGION

