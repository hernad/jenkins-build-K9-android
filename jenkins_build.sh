#!/bin/bash

if ! docker images android-dev | grep -q android-dev
then
  docker build -t android-dev .
fi

docker rm -f android-dev

GITHUB_USER=hernad
ANDROID_PROJECT=K9-android

docker run -ti \
       	-v $(pwd)/dot.android:/root/.android \
       	-v $(pwd)/build:/build \
       	-v $(pwd)/apk:/apk \
	-v $(pwd)/build_assembly.sh:/build_apk.sh \
       	--name android-dev android-dev /build_apk.sh



cp -av apk/*.apk .
