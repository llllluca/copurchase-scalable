#!/bin/sh

SCRIPT_HOME="$(realpath $(dirname $0))"
. ${SCRIPT_HOME}/config.sh

INPUT_FILE=order_products.csv
summary_file=""
workers=""

usage() {
    echo "Usage: $0 --workers=[1-9]"
}

for opt in "$@"; do
    case $opt in
        --workers=[1-9]) 
            workers=$(echo $opt | sed 's/[^=]*=//')
            ;;
        *) 
            echo "Error: \`${opt}' is an invalid option." >&2
            usage $0 >&2
            exit 1
            ;;
    esac
done

if [ -z "$workers" ]; then
    echo "Missing workers number." >&2
    usage $0 >&2
    exit 1
fi

output_dir=output_${workers}_workers/
summary_file=summary_${workers}_workers.json
# https://engineering.salesforce.com/how-to-optimize-your-apache-spark-application-with-partitions-257f2c1bb414/
partitions=$(echo "3 * ${workers} * ${MACHINE_CORE}" | bc)

#echo "[INFO]: deleting old cluster if it is still active."
#${SCRIPT_HOME}/delete-cluster.sh

#echo "[INFO]: uploading ${INPUT_FILE}."
#${SCRIPT_HOME}/bucket-upload.sh dataset/$INPUT_FILE

echo "[INFO]: creating cluster with ${workers} workers."
${SCRIPT_HOME}/create-cluster.sh --num-workers=$workers

echo "[INFO]: deleting ${output_dir} from cloud bucket."
${SCRIPT_HOME}/bucket-rm.sh $output_dir

echo "[INFO]: starting new job, partitions=${partitions} input-file=${INPUT_FILE}, output-dir=${output_dir}."
log=$(${SCRIPT_HOME}/jobs-submit.sh --partitions=$partitions --input-file=$INPUT_FILE --output-dir=$output_dir)
echo "$log" >> $summary_file

echo "[INFO]: downlaod ${output_dir} from cloud bucket."
${SCRIPT_HOME}/bucket-download.sh $output_dir .

echo "[INFO]: deleting cluster with ${workers} workers."
${SCRIPT_HOME}/delete-cluster.sh

