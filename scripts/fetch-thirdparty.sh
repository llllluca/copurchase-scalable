#!/bin/sh

PWD=$(pwd)
SCRIPT_HOME="$(realpath $(dirname $0))"
. ${SCRIPT_HOME}/config.sh
mkdir -p $THIRDPARTY
cd $THIRDPARTY

wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz
tar xvf google-cloud-cli-linux-x86_64.tar.gz

wget https://www.scala-lang.org/files/archive/scala-${SCALA_VERSION}.tgz
tar xvf scala-${SCALA_VERSION}.tgz

#wget https://github.com/apache/spark/archive/refs/tags/v3.5.4.tar.gz
#tar xf v3.5.4.tar.gz
#./thirdparty/spark-3.5.4/build/mvn -DskipTests clean package

wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz
tar xvf spark-${SPARK_VERSION}-bin-hadoop3.tgz

cd $PWD
