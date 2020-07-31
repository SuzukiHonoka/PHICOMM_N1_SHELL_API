#!/bin/bash
BUILD_DIR="/tmp"
SRCURL="https://github.com/SuzukiHonoka/s905d-kernel-precompiled"
KVER="5.7.9"
KURL="https://cdn.kernel.org/pub/linux/kernel/v5.x"
KDURL="$KURL/$KVER.tar.xz"
cd $BUILD_DIR
git clone --depth=1 --single-branch -b master $SRCURL
wget $KDURL
xz -d $KVER.tar.xz
tar xvf $KVER.tar
cd $BUILD_DIR/s905d-kernel-precompiled
sed -i "s/0x00080000/0x01080000/g" arch/arm64/Makefile
sed -i "s/#error TEXT_OFFSET must be less than 2MB/\/\/#error TEXT_OFFSET must be less than 2MB/g" arch/arm64/kernel/head.S
rsync -av --progress $BUILD_DIR/linux-$KVER/* .