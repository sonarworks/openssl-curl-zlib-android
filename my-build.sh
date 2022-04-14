#!/bin/bash

export NDK=$ANDROID_NDK_ROOT
export HOST_TAG=$ANDROID_NDK_HOST
export MIN_SDK_VERSION=28

export CFLAGS="-Os"
export LDFLAGS="-Wl,-Bsymbolic"

./build.sh
