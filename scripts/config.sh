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
SPARK_JARS="${THIRDPARTY}/spark-${SPARK_VERSION}-bin-without-hadoop/jars"

CLOUD_STORAGE_BUCKET="gs://scalable-project-bucket"
CLUSTER_NAME="rosita"
CLUSTER_REGION="us-central1"



