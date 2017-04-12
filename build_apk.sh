#!/bin/bash


GITHUB_USER=${1:-hernad}
ANDROID_PROJECT=K9-android
APK_DIR=/build/$GITHUB_USER/$ANDROID_PROJECT/k9mail/build/outputs/apk


mkdir /build/$GITHUB_USER
cd /build/$GITHUB_USER

git clone https://github.com/$GITHUB_USER/$ANDROID_PROJECT.git


cd $ANDROID_PROJECT
git checkout android -f
git pull
git log -1

tools/build_only_bosanski.sh DEBUG
cp -av $APK_DIR/* /apk/

tools/build_only_bosanski.sh
cp -av $APK_DIR/* /apk/

