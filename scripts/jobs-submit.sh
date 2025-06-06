#!/bin/sh

usage() {
    echo "Usage: $0 --partitions=N --input-file=FILEPATH [--output-dir=FILEPATH]"
}

input_file=""
output_dir="output/"
partitions=""

for opt in "$@"; do
    case $opt in
        --input-file=*) 
            input_file=$(echo $opt | sed 's/[^=]*=//')
            ;;
        --output-dir=*) 
            output_dir=$(echo $opt | sed 's/[^=]*=//')
            ;;
        --partitions=[0-9]*)
            partitions=$(echo $opt | sed 's/[^=]*=//')
            ;;

        *) 
            echo "Error: \`${opt}' is an invalid option." >&2
            usage $0 >&2
            exit 1
            ;;
    esac
done

if [ -z "$input_file" ]; then
    echo "Missing input file." >&2
    usage $0 >&2
    exit 1
fi

# https://spark.apache.org/docs/3.5.3/configuration.html#available-properties
# https://sparkbyexamples.com/spark/what-is-spark-executor/
# https://sparkbyexamples.com/spark/difference-between-spark-driver-vs-executor/
# When a Spark driver program submits a task to a cluster, it is divided into smaller
# units of work called “tasks”. These tasks are then scheduled to run on available 
# Executors in the cluster. Executors are responsible for executing these tasks in 
# parallel and returning the results back to the driver program.
# By default, Spark creates one Executor per node in the cluster.
#
# spark.executor.memory=6g: the amount of memory that is allocated to each Executor.
# spark.executor.cores=4:   the number of CPU cores that are allocated to each Executor.
#
# The driver program in Apache Spark executes on the machine where the Spark application is launched.
# This can be your local machine (in local mode) or on a cluster manager (like YARN, Mesos, or Kubernetes)
# when running in a distributed environment. In a cluster setup, the driver can run on a dedicated 
# node or on one of the worker nodes, depending on the configuration and resource allocation.
# The driver is responsible for orchestrating the execution of tasks across the cluster and managing
# the overall workflow of the Spark application.
#
# spark.driver.memory=4g: the amount of memory to allocate for the driver
#
SCRIPT_HOME="$(realpath $(dirname $0))"
. ${SCRIPT_HOME}/config.sh

#SPARK_PROPERTIES="spark.executor.memory=6g,spark.executor.cores=4,spark.driver.memory=4g"
SPARK_PROPERTIES="spark.executor.memory=6g,spark.driver.memory=4g"
COMMON_PARAMS="\
    --cluster ${CLUSTER_NAME} \
    --region ${CLUSTER_REGION} \
    --properties=${SPARK_PROPERTIES} \
    --format json"

if [ -z "$partitions" ]; then
    $GCLOUD dataproc jobs submit spark \
        $COMMON_PARAMS \
        --jar ${CLOUD_STORAGE_BUCKET}/CoPurchaseAnalysisNoPartitioning.jar \
        -- ${CLOUD_STORAGE_BUCKET}/${input_file} ${CLOUD_STORAGE_BUCKET}/${output_dir}
else
    $GCLOUD dataproc jobs submit spark \
        $COMMON_PARAMS \
        --jar ${CLOUD_STORAGE_BUCKET}/CoPurchaseAnalysis.jar \
        -- $partitions ${CLOUD_STORAGE_BUCKET}/${input_file} ${CLOUD_STORAGE_BUCKET}/${output_dir}
fi



