#!/bin/sh
#
# Note: This build script assumes it can find the archive for libwebp 
# in the current directory. You can download it from the following URL:
#  http://code.google.com/speed/webp/download.html
#
# The resulting framework will can be found in the current directory 
# with the name WebP.framework
#

SDK=11.2
PLATFORMS="iPhoneSimulator iPhoneSimulator64"
PLATFORMS+=" iPhoneOS-V7 iPhoneOS-V7s iPhoneOS-V7-arm64"
DEVELOPER=`xcode-select -print-path`
SRCDIR=$(dirname $0)
TOPDIR=`pwd`
BUILDDIR="$TOPDIR/tmp"
FINALDIR="$TOPDIR/WebP.framework"
DECTARGETDIR="${TOPDIR}/WebPDecoder.framework"
LIBLIST=''
DECLIBLIST=''
DEVROOT="${DEVELOPER}/Toolchains/XcodeDefault.xctoolchain"

mkdir -p $BUILDDIR
mkdir -p $FINALDIR
mkdir $FINALDIR/Headers/
mkdir -p $DECTARGETDIR
mkdir $DECTARGETDIR/Headers/

for PLATFORM in ${PLATFORMS}
do
  if [ "${PLATFORM}" == "iPhoneOS-V7" ]
  then
    SDKPATH="${DEVELOPER}/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS11.2.sdk/"
    ARCH="armv7"
    HOST=${ARCH}-apple-darwin
  elif [ "${PLATFORM}" == "iPhoneOS-V7s" ]
  then
    SDKPATH="${DEVELOPER}/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS11.2.sdk/"
    ARCH="armv7s"
    HOST=${ARCH}-apple-darwin
  elif [ "${PLATFORM}" == "iPhoneOS-V7-arm64" ]
  then
    SDKPATH="${DEVELOPER}/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS11.2.sdk/"
    ARCH="arm64"
    HOST="aarch64-apple-darwin"
  elif [ "${PLATFORM}" == "iPhoneSimulator64" ]
  then
    SDKPATH="${DEVELOPER}/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator11.2.sdk/"
    ARCH="x86_64"
    HOST=${ARCH}-apple-darwin
  else
    SDKPATH="${DEVELOPER}/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator11.2.sdk/"
    ARCH="i386"
    HOST=${ARCH}-apple-darwin
  fi

  export CC=${DEVROOT}/usr/bin/cc
  export LD=${DEVROOT}/usr/bin/ld
  export CPP=${DEVROOT}/usr/bin/cpp
  export CXX=${DEVROOT}/usr/bin/g++
  export AR=${DEVROOT}/usr/bin/ar
  export AS=${DEVROOT}/usr/bin/as
  export NM=${DEVROOT}/usr/bin/nm
  export CXXCPP=${DEVROOT}/usr/bin/cpp
  export RANLIB=${DEVROOT}/usr/bin/ranlib

  rm -rf libwebp-0.6.1
  tar xzf libwebp-0.6.1.tar.gz
  cd libwebp-0.6.1

  sh autogen.sh

  ROOTDIR="/tmp/install.$$.${ARCH}"
  rm -rf "${ROOTDIR}"
  mkdir -p "${ROOTDIR}"

  export LDFLAGS="-arch ${ARCH} -miphoneos-version-min=9.0 -pipe -isysroot ${SDKPATH} -O3 -DNDEBUG"
  export CFLAGS="-arch ${ARCH} -miphoneos-version-min=9.0 -pipe -isysroot ${SDKPATH} -O3 -DNDEBUG"
  export CXXFLAGS="-arch ${ARCH} -miphoneos-version-min=9.0 -pipe -isysroot ${SDKPATH} -O3 -DNDEBUG"

./configure --host=${HOST} --prefix=${ROOTDIR} --disable-shared --enable-static \
            --enable-libwebpdecoder --enable-swap-16bit-csp --build=$(./config.guess)
  make
  make install

  LIBLIST="${LIBLIST} ${ROOTDIR}/lib/libwebp.a"
  DECLIBLIST="${DECLIBLIST} ${ROOTDIR}/lib/libwebpdecoder.a"

  cd ..
done

cp -a ${SRCDIR}/src/webp/{decode,encode,types}.h ${FINALDIR}/Headers/
${DEVROOT}/usr/bin/lipo -create ${LIBLIST} -output ${FINALDIR}/WebP

cp -a ${SRCDIR}/src/webp/{decode,types}.h ${DECTARGETDIR}/Headers/
${DEVROOT}/usr/bin/lipo -create ${DECLIBLIST} -output ${DECTARGETDIR}/WebPDecoder

rm -rf libwebp-0.6.1
rm -rf ${BUILDDIR}
