FROM ubuntu:16.04

# https://github.com/thyrlian/AndroidSDK/blob/master/android-sdk/

MAINTAINER hernad

# update
RUN apt-get update

# for slack notification
RUN apt-get -y install curl

# Install for running 32-bit applications
# 64-bit distribution capable of running 32-bit applications
# https://developer.android.com/studio/index.html
RUN apt-get -y install lib32stdc++6 lib32z1

# For DeployGate
RUN apt-get -y install build-essential ruby ruby-dev

# Install Java8
RUN apt-get install -y openjdk-8-jdk wget

# RUN mkdir -p /user/local/android-sdk-linux


ENV ANDROID_SDK_VERSION 3859397

# Download Android SDK
#RUN apt-get -y install wget \
#  && cd /usr/local \
#  && wget http://dl.google.com/android/android-sdk_r${ANDROID_SDK_VER}-linux.tgz \
#  && tar zxvf android-sdk_r${ANDROID_SDK_VER}-linux.tgz \
#  && rm -rf /usr/local/android-sdk_r${ANDROID_SDK_VER}-linux.tgz

#RUN ls /usr/local


# download and install Android SDK
ENV ANDROID_SDK_VERSION 3859397
RUN mkdir -p /opt/android-sdk && cd /opt/android-sdk && \
    wget -q https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip && \
    unzip *tools*linux*.zip && \
    rm *tools*linux*.zip

#RUN cd /usr/local/android-sdk-linux && rm -r tools && wget --output-document=tools_r${ANDROID_SDK_VER}-linux.zip --quiet https://dl.google.com/android/repository/tools_r${ANDROID_SDK_VER}-linux.zip && \
#  unzip tools_r${ANDROID_SDK_VER}-linux.zip

# # Download Android SDK
# RUN apt-get -y install wget \
#   && cd /usr/local \
#   && wget https://dl.google.com/android/repository/tools_r25.2.2-linux.zip \
#   && unzip tools_r25.2.2-linux.zip \
#   && rm -rf /usr/local/tools_r25.2.2-linux.zip

# Environment variables
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV ANDROID_HOME /opt/android-sdk

ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools
#ENV ANDROID_EMULATOR_FORCE_32BIT true

ADD license_accepter.sh /opt/
RUN /opt/license_accepter.sh $ANDROID_HOME

# Update of Android SDK
#RUN echo y | android update sdk --no-ui --all --filter "android-25,build-tools-25.0.0,build-tools-${ANDROID_SDK_VER}" \
#  && echo y | android update sdk --no-ui --all --filter "extra-android-support,extra-google-m2repository,extra-android-m2repository,extra-google-google_play_services" \
#  && echo y | android update sdk -a -u -t "sys-img-armeabi-v7a-android-24" \
#  && echo y | android update sdk --no-ui  --all --filter "platform-tools"

# android update sdk --no-ui  でplatform-toolsが現れる

# RUN echo y | android update sdk --all --no-ui --filter platform-tools,tools && \
#     echo y | android update sdk --all --no-ui --filter platform-tools,tools,build-tools-24.0.1,android-24,addon-google_apis-google-24,extra-android-support,extra-android-m2repository,extra-google-m2repository,sys-img-armeabi-v7a-android-24

# Fix build error
# > You have not accepted the license agreements of the following SDK components
# http://stackoverflow.com/a/38381577
#RUN mkdir "$ANDROID_SDK/licenses" || true \
#  && echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > "$ANDROID_SDK/licenses/android-sdk-license"

# RUN which adb
# RUN which android


# Create emulator
#RUN echo "no" | android create avd \
#                --force \
#                --device "Nexus 5" \
#                --name test \
#                --target android-24 \
#                --abi armeabi-v7a \
#                --skin WVGA800 \
#                --sdcard 512M

RUN apt-get install git vim -y

# Cleaning
RUN apt-get clean -y

# GO to workspace
#RUN mkdir -p /opt/workspace
WORKDIR /build
