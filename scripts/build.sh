#!/bin/sh

#https://stackoverflow.com/questions/73298692/how-to-compile-a-scala-program-without-any-builder

PWD="$(pwd)"
SCRIPT_HOME="$(realpath $(dirname $0))"
. ${SCRIPT_HOME}/config.sh
mkdir -p build/

echo "[INFO]: compiling CoPurchaseAnalysis.scala"
$SCALAC -cp  $SPARK_JARS -extdirs $SPARK_JARS -d $BUILD CoPurchaseAnalysis.scala
echo "[INFO]: compiling CoPurchaseAnalysisNoPartitioning.scala"
$SCALAC -cp  $SPARK_JARS -extdirs $SPARK_JARS -d $BUILD CoPurchaseAnalysisNoPartitioning.scala

cd $BUILD
echo "[INFO]: building CoPurchaseAnalysis.jar"
jar cvfe CoPurchaseAnalysis.jar CoPurchaseAnalysis CoPurchaseAnalysis\$.class CoPurchaseAnalysis.class
echo "[INFO]: building CoPurchaseAnalysisNoPartitioning.jar"
jar cvfe CoPurchaseAnalysisNoPartitioning.jar CoPurchaseAnalysisNoPartitioning CoPurchaseAnalysisNoPartitioning\$.class CoPurchaseAnalysisNoPartitioning.class
cd $PWD
