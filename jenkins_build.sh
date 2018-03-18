#!/bin/bash

set -x

docker images
docker rmi -f android-dev
#if ! docker images android-dev | grep -q android-dev
#then
  docker build -t android-dev .
#fi

GITHUB_USER=${1:-hernad}

ANDROID_PROJECT=K9-android
CONTAINER_NAME=android-build-$GITHUB_USER-$ANDROID_PROJECT

docker rm -f $CONTAINER_NAME

echo === starting docker build $ANDROID_PROJECT in container $CONTAINER_NAME ========

docker run -t \
       	-v $(pwd)/dot.android:/root/.android \
       	-v $(pwd)/dot.gradle:/root/.gradle \
       	-v $(pwd)/build:/build \
       	-v $(pwd)/apk:/apk \
	-v $(pwd)/build_apk.sh:/build_apk.sh \
       	--name $CONTAINER_NAME android-dev /build_apk.sh $GITHUB_USER



cp -av apk/*.apk .
