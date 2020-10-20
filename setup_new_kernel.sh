#!/bin/bash
ARG1=$1
ROOT_DIR="/tmp/ramfs"
BUILD_DIR="$ROOT_DIR/build"
SRCURL="https://github.com/SuzukiHonoka/$REPO"
CONFIG="https://github.com/SuzukiHonoka/s905d-kernel-precompiled/raw/master/.config"
KVERV="5.9.1"

if [ ! -z "$ARG1" ]; then
KVERV=$ARG1
fi

KVER="linux-$KVERV"
KURL="https://cdn.kernel.org/pub/linux/kernel/v5.x"
KDURL="$KURL/$KVER.tar.xz"

if [ ! -d "$ROOT_DIR" ];then
mkdir -p $ROOT_DIR
fi

if [ -d "$BUILD_DIR" ];then
umount $ROOT_DIR
fi

sudo mount -t tmpfs -o size=6G tmpfs $ROOT_DIR
mkdir $BUILD_DIR
cd $BUILD_DIR

wget $KDURL
xz -d "$KVER.tar.xz" && rm "$KVER.tar.xz"
tar xf "$KVER.tar"
rm "$KVER.tar"
cd "$BUILD_DIR/$KVER"
curl -o .config https://github.com/SuzukiHonoka/s905d-kernel-precompiled/raw/master/.config

sed -i "s/TEXT_OFFSET := 0x0/TEXT_OFFSET := 0x01080000/g" arch/arm64/Makefile
sed -i "s/#error TEXT_OFFSET must be less than 2MB/\/\/#error TEXT_OFFSET must be less than 2MB/g" arch/arm64/kernel/head.S
cat >> arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts <<EOF
&external_phy {
        /delete-property/ reset-gpios;
        interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
};
EOF
