#!/bin/bash

if ! docker images android-dev | grep -q android-dev
then
  docker build -t android-dev .
fi

GITHUB_USER=${1:-hernad}

ANDROID_PROJECT=K9-android

docker rm -f android-build-$ANDROID_PROJECT

echo === starting docker build $ANDROID_PROJECT in container android-build-$ANDROID_PROJECT / github: $GITHUB_USER  ========

docker run -t \
       	-v $(pwd)/dot.android:/root/.android \
       	-v $(pwd)/dot.gradle:/root/.gradle \
       	-v $(pwd)/build:/build \
       	-v $(pwd)/apk:/apk \
	-v $(pwd)/build_apk.sh:/build_apk.sh \
       	--name android-build-$ANDROID_PROJECT android-dev /build_apk.sh $GITHUB_USER



cp -av apk/*.apk .
