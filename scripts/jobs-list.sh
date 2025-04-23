#!/bin/sh

# See $GCLOUD dataproc jobs list \
# --cluster $CLUSTER_NAME --region $CLUSTER_REGION --format json 
# to get the names of the table header.

SCRIPT_HOME="$(realpath $(dirname $0))"
. ${SCRIPT_HOME}/config.sh
$GCLOUD dataproc jobs list --region $CLUSTER_REGION \
--format="table(reference.jobId,status.state,statusHistory[0].stateStartTime,status.stateStartTime)" \

