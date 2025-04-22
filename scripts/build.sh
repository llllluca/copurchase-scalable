#!/bin/sh

#https://stackoverflow.com/questions/73298692/how-to-compile-a-scala-program-without-any-builder

PWD="$(pwd)"
. "${PWD}/$(dirname $0)/config.sh"
mkdir -p build/
$SCALAC -cp  $SPARK_JARS -extdirs $SPARK_JARS -d $BUILD Hello.scala

cd $BUILD
jar cvfe Hello.jar Hello Hello*.class
cd $PWD
