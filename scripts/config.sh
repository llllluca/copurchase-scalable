ROOT_DIR=$(git rev-parse --show-toplevel)
THIRDPARTY="${ROOT_DIR}/thirdparty"
BUILD="${ROOT_DIR}/build"

# See the following link for the version of Scala and Apache Spark installed in CLUSTER_IMAGE_VERSION.
# https://cloud.google.com/dataproc/docs/concepts/versioning/dataproc-release-2.2
CLUSTER_IMAGE_VERSION="2.2.53-debian12"
SPARK_VERSION="3.5.3"
SCALA_VERSION="2.12.18"

SCALAC="${THIRDPARTY}/scala-${SCALA_VERSION}/bin/scalac"
GCLOUD="${THIRDPARTY}/google-cloud-sdk/bin/gcloud"
SPARK_JARS="${THIRDPARTY}/spark-${SPARK_VERSION}-bin-hadoop3/jars"

CLOUD_STORAGE_BUCKET="gs://scalable-project-bucket"
CLUSTER_NAME="rosita"
CLUSTER_REGION="us-west1"

# https://cloud.google.com/compute/docs/machine-resource
# n1-standard-4: 4 vCPU, 4 GB memory per vCPU (16 GB), N1 series machine
MACHINE_TYPE=n1-standard-4
MACHINE_CORE=4
MACHINE_MEMORY_GB=16
DISK_SIZE_GB=240

