#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    export CORES=$((`sysctl -n hw.logicalcpu`+1))
else
    export CORES=$((`nproc`+1))
fi

export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$HOST_TAG

export ANDROID_NDK_HOME=$NDK
PATH=$TOOLCHAIN/bin:$PATH

ARGUMENTS="shared zlib"

mkdir -p build/openssl
cd openssl

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
export ZLIB_DIR=$PWD/../zlib/build/$ANDROID_ARCH

./Configure android-arm64 $ARGUMENTS \
 -D__ANDROID_API__=$MIN_SDK_VERSION \
 --prefix=$PWD/build/$ANDROID_ARCH \
 --with-zlib-lib=$ZLIB_DIR/lib \
 --with-zlib-include=$ZLIB_DIR/include

make -j$CORES SHLIB_VERSION_NUMBER= SHLIB_EXT=_1_1.so
make SHLIB_VERSION_NUMBER= SHLIB_EXT=_1_1.so install_sw
make clean
mkdir -p ../build/openssl/$ANDROID_ARCH
cp -R $PWD/build/$ANDROID_ARCH ../build/openssl/

# arm
export TARGET_HOST=arm-linux-androideabi
export ANDROID_ARCH=armeabi-v7a
export AR=$TOOLCHAIN/bin/llvm-ar
export CC=$TOOLCHAIN/bin/$TARGET_HOST$MIN_SDK_VERSION-clang
export AS=$CC
export CXX=$TOOLCHAIN/bin/$TARGET_HOST$MIN_SDK_VERSION-clang++
export LD=$TOOLCHAIN/bin/ld
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip
export ZLIB_DIR=$PWD/../zlib/build/$ANDROID_ARCH

./Configure android-arm $ARGUMENTS \
 -D__ANDROID_API__=$MIN_SDK_VERSION \
 --prefix=$PWD/build/$ANDROID_ARCH \
 --with-zlib-lib=$ZLIB_DIR/lib \
 --with-zlib-include=$ZLIB_DIR/include

make -j$CORES SHLIB_VERSION_NUMBER= SHLIB_EXT=_1_1.so
make SHLIB_VERSION_NUMBER= SHLIB_EXT=_1_1.so install_sw
make clean
mkdir -p ../build/openssl/$ANDROID_ARCH
cp -R $PWD/build/$ANDROID_ARCH ../build/openssl/

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
export ZLIB_DIR=$PWD/../zlib/build/$ANDROID_ARCH

./Configure android-x86 $ARGUMENTS \
 -D__ANDROID_API__=$MIN_SDK_VERSION \
 --prefix=$PWD/build/$ANDROID_ARCH \
 --with-zlib-lib=$ZLIB_DIR/lib \
 --with-zlib-include=$ZLIB_DIR/include

make -j$CORES SHLIB_VERSION_NUMBER= SHLIB_EXT=_1_1.so
make SHLIB_VERSION_NUMBER= SHLIB_EXT=_1_1.so install_sw
make clean
mkdir -p ../build/openssl/$ANDROID_ARCH
cp -R $PWD/build/$ANDROID_ARCH ../build/openssl/

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
export ZLIB_DIR=$PWD/../zlib/build/$ANDROID_ARCH

./Configure android-x86_64 $ARGUMENTS \
 -D__ANDROID_API__=$MIN_SDK_VERSION \
 --prefix=$PWD/build/$ANDROID_ARCH \
 --with-zlib-lib=$ZLIB_DIR/lib \
 --with-zlib-include=$ZLIB_DIR/include

make -j$CORES SHLIB_VERSION_NUMBER= SHLIB_EXT=_1_1.so
make SHLIB_VERSION_NUMBER= SHLIB_EXT=_1_1.so install_sw
make clean
mkdir -p ../build/openssl/$ANDROID_ARCH
cp -R $PWD/build/$ANDROID_ARCH ../build/openssl/

cd ..
