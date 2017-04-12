#!/bin/bash

if ! docker images android-dev | grep -q android-dev
then
  docker build -t android-dev .
fi


GITHUB_USER=hernad
ANDROID_PROJECT=K9-android

docker rm -f android-build-$ANDROID_PROJECT

echo === starting docker build $ANDROID_PROJECT in container android-build-$ANDROID_PROJECT ========

docker run -t \
       	-v $(pwd)/dot.android:/root/.android \
       	-v $(pwd)/dot.m2:/root/.m2 \
       	-v $(pwd)/build:/build \
       	-v $(pwd)/apk:/apk \
	-v $(pwd)/build_apk.sh:/build_apk.sh \
       	--name android-build-$ANDROID_PROJECT android-dev /build_apk.sh



cp -av apk/*.apk .
