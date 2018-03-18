#!/bin/bash

set -x

docker images
#docker rmi -f android-dev


if ! docker images android-dev | grep -q android-dev
then
  docker build -t android-dev .
fi

GITHUB_USER=${1:-hernad}

ANDROID_PROJECT=K9-android
CONTAINER_NAME=android-build-$GITHUB_USER-$ANDROID_PROJECT

docker rm -f $CONTAINER_NAME

echo === starting docker build $ANDROID_PROJECT in container $CONTAINER_NAME ========

HOST_KEYSTORE=${HOME}/bringout-android.keystore

if [ -z "${BRINGOUT_KEYSTORE_PASSWORD}" ] ; then
   echo mora se definisati keystore password BRINGOUT_KEYSTORE_PASSWORD
   exit 1
fi

docker run -t \
        -e BRINGOUT_KEYSTORE_PASSWORD=$BRINGOUT_KEYSTORE_PASSWORD \
       	-v $(pwd)/dot.android:/root/.android \
       	-v $(pwd)/dot.gradle:/root/.gradle \
       	-v $(pwd)/build:/build \
       	-v $(pwd)/apk:/apk \
		-v ${HOST_KEYSTORE}:/bringout-android.keystore \
	    -v $(pwd)/build_apk.sh:/build_apk.sh \
       	--name $CONTAINER_NAME android-dev /build_apk.sh $GITHUB_USER



cp -av apk/release/k9mail-signed.apk .
