#!/bin/bash


GITHUB_USER=hernad
ANDROID_PROJECT=K9-android
APK_DIR=/build/$ANDROID_PROJECT/vector/build/outputs/apk


cd /build
git clone https://github.com/$GITHUB_USER/$ANDROID_PROJECT.git


cd $ANDROID_PROJECT
git checkout apps_modular -f
git pull
git log -1

./gradlew assembleDebug
./gradlew assembleRelease

cp -av $APK_DIR /apk

