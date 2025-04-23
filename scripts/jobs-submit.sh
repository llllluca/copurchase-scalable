#!/bin/sh

# See $GCLOUD dataproc jobs list \
# --cluster $CLUSTER_NAME --region $CLUSTER_REGION --format json 
# to get the names of the table header.
#
usage() {
    echo "Usage: $0 [--input-file=FILEPATH] [--output-file=FILEPATH]"
}

input_file="toy_dataset.csv"
output_dir="output/"

for opt in "$@"; do
    case $opt in
        --input-file=*) 
            input_file=$(echo $opt | sed 's/[^=]*=//')
            ;;
        --output-dir=*) 
            output_dir=$(echo $opt | sed 's/[^=]*=//')
            ;;

        *) 
            echo "Error: \`${opt}' is an invalid option." >&2
            usage $0 >&2
            exit 1
            ;;
    esac
done

SCRIPT_HOME="$(realpath $(dirname $0))"
. ${SCRIPT_HOME}/config.sh
$GCLOUD dataproc jobs submit spark --cluster $CLUSTER_NAME --region $CLUSTER_REGION \
--format="table(reference.jobId,status.state,statusHistory[0].stateStartTime,status.stateStartTime)" \
--jar ${CLOUD_STORAGE_BUCKET}/CoPurchaseAnalysis.jar \
-- ${CLOUD_STORAGE_BUCKET}/${input_file} ${CLOUD_STORAGE_BUCKET}/${output_dir}

