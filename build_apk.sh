#!/bin/bash
set -x

BUILD_DEBUG_APK=no # yes
GITHUB_USER=${1:-hernad}
ANDROID_PROJECT=K9-android
BUILD_ROOT=/build/$GITHUB_USER/$ANDROID_PROJECT

APK_DIR=$BUILD_ROOT/k9mail/build/outputs/apk
mkdir -p $APK_DIR

#mkdir /build/$GITHUB_USER
cd /build/$GITHUB_USER

git clone https://github.com/$GITHUB_USER/$ANDROID_PROJECT.git


cd $BUILD_ROOT
git checkout android -f
git pull
git log -1

APK_DIR_REL=k9mail/build/outputs/apk

if [ x$BUILD_DEBUG_APK == xyes ] ; then
 tools/build_only_bosanski.sh DEBUG 
 find $APK_DIR_REL
 cp -av $APK_DIR_REL/* /apk/
fi

cd $BUILD_ROOT
tools/build_only_bosanski.sh
find $APK_DIR_REL
cp /bringout-android.keystore ${APK_DIR_REL}/release
echo $BRINGOUT_KEYSTORE_PASSWORD | tools/bringout_sign_apk.sh


cd $BUILD_ROOT
cp -av $APK_DIR_REL/* /apk/
