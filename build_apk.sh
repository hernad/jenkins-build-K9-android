#!/bin/bash
set -x

GITHUB_USER=${1:-hernad}
ANDROID_PROJECT=K9-android
BUILD_ROOT=/build/$GITHUB_USER/$ANDROID_PROJECT

APK_DIR=$BUILD_ROOT/k9mail/build/outputs/apk


mkdir /build/$GITHUB_USER
cd /build/$GITHUB_USER

git clone https://github.com/$GITHUB_USER/$ANDROID_PROJECT.git


cd $BUILD_ROOT
git checkout android -f
git pull
git log -1

tools/build_only_bosanski.sh DEBUG
APK_DIR_REL=k9mail/build/outputs/apk
find $APK_DIR_REL
cp -av $APK_DIR_REL/* /apk/

cd $BUILD_ROOT
tools/build_only_bosanski.sh
tools/bringout_sign_apk.sh
find $APK_DIR_REL
cp -av $APK_DIR_REL/* /apk/

