#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    export CORES=$((`sysctl -n hw.logicalcpu`+1))
else
    export CORES=$((`nproc`+1))
fi

export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$HOST_TAG
export CFLAGS="--sysroot=${TOOLCHAIN}/sysroot -fPIC"

# zlib common configuration arguments
# disable functionalities here to reduce size
ARGUMENTS=" \
    --uname=Linux
    --enable-shared
    "

mkdir -p build/zlib
cd zlib

# arm64
export TARGET_HOST=aarch64-linux-android
export ANDROID_ARCH=arm64-v8a
export AR=$TOOLCHAIN/bin/llvm-ar
export CC=$TOOLCHAIN/bin/$TARGET_HOST$MIN_SDK_VERSION-clang
export AS=$CC
export CXX=$TOOLCHAIN/bin/$TARGET_HOST$MIN_SDK_VERSION-clang++
export LD=$TOOLCHAIN/bin/ld
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip

./configure --prefix=$PWD/build/$ANDROID_ARCH $ARGUMENTS

make -j$CORES
make install
make clean
rm $PWD/build/$ANDROID_ARCH/lib/libz.a
rm $PWD/build/$ANDROID_ARCH/lib/libz.so
rm $PWD/build/$ANDROID_ARCH/lib/libz.so.1
mv $PWD/build/$ANDROID_ARCH/lib/libz.so.1.* $PWD/build/$ANDROID_ARCH/lib/libz.so
patchelf --set-soname libz.so $PWD/build/$ANDROID_ARCH/lib/libz.so
mkdir -p ../build/zlib/$ANDROID_ARCH
cp -R $PWD/build/$ANDROID_ARCH ../build/zlib/

# arm
export TARGET_HOST=armv7a-linux-androideabi
export ANDROID_ARCH=armeabi-v7a
export AR=$TOOLCHAIN/bin/llvm-ar
export CC=$TOOLCHAIN/bin/$TARGET_HOST$MIN_SDK_VERSION-clang
export AS=$CC
export CXX=$TOOLCHAIN/bin/$TARGET_HOST$MIN_SDK_VERSION-clang++
export LD=$TOOLCHAIN/bin/ld
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip
export SSL_DIR=$PWD/../openssl/build/$ANDROID_ARCH

./configure --prefix=$PWD/build/$ANDROID_ARCH $ARGUMENTS

make -j$CORES
make install
make clean
rm $PWD/build/$ANDROID_ARCH/lib/libz.a
rm $PWD/build/$ANDROID_ARCH/lib/libz.so
rm $PWD/build/$ANDROID_ARCH/lib/libz.so.1
mv $PWD/build/$ANDROID_ARCH/lib/libz.so.1.* $PWD/build/$ANDROID_ARCH/lib/libz.so
patchelf --set-soname libz.so $PWD/build/$ANDROID_ARCH/lib/libz.so
mkdir -p ../build/zlib/$ANDROID_ARCH
cp -R $PWD/build/$ANDROID_ARCH ../build/zlib/

# x86
export TARGET_HOST=i686-linux-android
export ANDROID_ARCH=x86
export AR=$TOOLCHAIN/bin/llvm-ar
export CC=$TOOLCHAIN/bin/$TARGET_HOST$MIN_SDK_VERSION-clang
export AS=$CC
export CXX=$TOOLCHAIN/bin/$TARGET_HOST$MIN_SDK_VERSION-clang++
export LD=$TOOLCHAIN/bin/ld
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip
export SSL_DIR=$PWD/../openssl/build/$ANDROID_ARCH

./configure --prefix=$PWD/build/$ANDROID_ARCH $ARGUMENTS

make -j$CORES
make install
make clean
rm $PWD/build/$ANDROID_ARCH/lib/libz.a
rm $PWD/build/$ANDROID_ARCH/lib/libz.so
rm $PWD/build/$ANDROID_ARCH/lib/libz.so.1
mv $PWD/build/$ANDROID_ARCH/lib/libz.so.1.* $PWD/build/$ANDROID_ARCH/lib/libz.so
patchelf --set-soname libz.so $PWD/build/$ANDROID_ARCH/lib/libz.so
mkdir -p ../build/zlib/$ANDROID_ARCH
cp -R $PWD/build/$ANDROID_ARCH ../build/zlib/

# x64
export TARGET_HOST=x86_64-linux-android
export ANDROID_ARCH=x86_64
export AR=$TOOLCHAIN/bin/llvm-ar
export CC=$TOOLCHAIN/bin/$TARGET_HOST$MIN_SDK_VERSION-clang
export AS=$CC
export CXX=$TOOLCHAIN/bin/$TARGET_HOST$MIN_SDK_VERSION-clang++
export LD=$TOOLCHAIN/bin/ld
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip
export SSL_DIR=$PWD/../openssl/build/$ANDROID_ARCH

./configure --prefix=$PWD/build/$ANDROID_ARCH $ARGUMENTS

make -j$CORES
make install
make clean
rm $PWD/build/$ANDROID_ARCH/lib/libz.a
rm $PWD/build/$ANDROID_ARCH/lib/libz.so
rm $PWD/build/$ANDROID_ARCH/lib/libz.so.1
mv $PWD/build/$ANDROID_ARCH/lib/libz.so.1.* $PWD/build/$ANDROID_ARCH/lib/libz.so
patchelf --set-soname libz.so $PWD/build/$ANDROID_ARCH/lib/libz.so
mkdir -p ../build/zlib/$ANDROID_ARCH
cp -R $PWD/build/$ANDROID_ARCH ../build/zlib/

cd ..
