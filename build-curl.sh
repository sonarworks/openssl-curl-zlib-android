#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    export CORES=$((`sysctl -n hw.logicalcpu`+1))
else
    export CORES=$((`nproc`+1))
fi

export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$HOST_TAG

# curl common configuration arguments
# disable functionalities here to reduce size
ARGUMENTS=" \
    --with-pic \
    --enable-http \
    --disable-ftp --disable-gopher --disable-file --disable-imap --disable-ldap \
    --disable-ldaps --disable-pop3 --disable-proxy --disable-rtsp --disable-smtp \
    --disable-telnet --disable-tftp --disable-dict \
    --without-librtmp
    "

mkdir -p build/curl
cd curl
autoreconf -fi

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
export SSL_DIR=$PWD/../openssl/build/$ANDROID_ARCH
export ZLIB_DIR=$PWD/../zlib/build/$ANDROID_ARCH

./configure --host=$TARGET_HOST \
            --target=$TARGET_HOST \
            --prefix=$PWD/build/$ANDROID_ARCH \
            --with-openssl=$SSL_DIR \
            --with-zlib=$ZLIB_DIR \
            $ARGUMENTS

make -j$CORES
make install
make clean
rm $PWD/build/$ANDROID_ARCH/lib/*.a
rm $PWD/build/$ANDROID_ARCH/lib/*.la
mkdir -p ../build/curl/$ANDROID_ARCH
cp -R $PWD/build/$ANDROID_ARCH ../build/curl/

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
export ZLIB_DIR=$PWD/../zlib/build/$ANDROID_ARCH

./configure --host=$TARGET_HOST \
            --target=$TARGET_HOST \
            --prefix=$PWD/build/$ANDROID_ARCH \
            --with-openssl=$SSL_DIR \
            --with-zlib=$ZLIB_DIR \
            $ARGUMENTS

make -j$CORES
make install
make clean
rm $PWD/build/$ANDROID_ARCH/lib/*.a
rm $PWD/build/$ANDROID_ARCH/lib/*.la
mkdir -p ../build/curl/$ANDROID_ARCH
cp -R $PWD/build/$ANDROID_ARCH ../build/curl/

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
export ZLIB_DIR=$PWD/../zlib/build/$ANDROID_ARCH

./configure --host=$TARGET_HOST \
            --target=$TARGET_HOST \
            --prefix=$PWD/build/$ANDROID_ARCH \
            --with-openssl=$SSL_DIR \
            --with-zlib=$ZLIB_DIR \
            $ARGUMENTS

make -j$CORES
make install
make clean
rm $PWD/build/$ANDROID_ARCH/lib/*.a
rm $PWD/build/$ANDROID_ARCH/lib/*.la
mkdir -p ../build/curl/$ANDROID_ARCH
cp -R $PWD/build/$ANDROID_ARCH ../build/curl/

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
export ZLIB_DIR=$PWD/../zlib/build/$ANDROID_ARCH

./configure --host=$TARGET_HOST \
            --target=$TARGET_HOST \
            --prefix=$PWD/build/$ANDROID_ARCH \
            --with-openssl=$SSL_DIR \
            --with-zlib=$ZLIB_DIR \
            $ARGUMENTS

make -j$CORES
make install
make clean
rm $PWD/build/$ANDROID_ARCH/lib/*.a
rm $PWD/build/$ANDROID_ARCH/lib/*.la
mkdir -p ../build/curl/$ANDROID_ARCH
cp -R $PWD/build/$ANDROID_ARCH ../build/curl/

cd ..
