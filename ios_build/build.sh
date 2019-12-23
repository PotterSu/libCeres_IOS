#!/bin/sh
set -e

current_dir=$(cd `dirname $0`; pwd)
echo $current_dir

ALL_ARCHS="armv7 arm64 x86_64"

export IOS_DEPLOYMENT_TARGET=8.0

# 项目名称
export PROJECT_NAME="Ceres"

export BUILD_ROOT_DIR="$current_dir/lib${PROJECT_NAME}/iOS"
export OUT_ROOT_DIR="$current_dir/lib${PROJECT_NAME}/iOS/AllArch"
export EIGEN_ROOT_DIR="$current_dir/../3rdParty/eigen3/"
export Eigen3_DIR="$current_dir/../3rdParty/eigen3/build"

do_build()
{
    IOS_ARCH=$1

    BUILD_PATH="$BUILD_ROOT_DIR/$IOS_ARCH"
    rm -rf $BUILD_PATH
    mkdir -p $BUILD_PATH
    pushd $BUILD_PATH

    cmake -DCMAKE_TOOLCHAIN_FILE=$current_dir/../cmake/iOS.cmake            \
          -DIOS_DEPLOYMENT_TARGET="$IOS_DEPLOYMENT_TARGET"         \
          -DCMAKE_OSX_ARCHITECTURES="$IOS_ARCH"                    \
          -DEIGEN_INCLUDE_DIRS=$EIGEN_ROOT_DIR \
          -DEigen3_DIR=$Eigen3_DIR \
          $current_dir/..

    make -j8
    rm -rf $OUT_ROOT_DIR/$IOS_ARCH
    make -j8 install DESTDIR=$OUT_ROOT_DIR/$IOS_ARCH

    popd
}

for ARCH in $ALL_ARCHS
do
    do_build $ARCH
done

rm -rf $current_dir/libceres.a
ALL_ARCHS=(armv7 arm64 x86_64)
lipo -create $BUILD_ROOT_DIR/${ALL_ARCHS[0]}/lib/libceres.a $BUILD_ROOT_DIR/${ALL_ARCHS[1]}/lib/libceres.a $BUILD_ROOT_DIR/${ALL_ARCHS[2]}/lib/libceres.a -output $current_dir/libceres.a
