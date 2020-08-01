#!/bin/bash
ARG1=$1
BUILD_DIR="/tmp"
REPO="Amlogic_s905-kernel"
SRCURL="https://github.com/SuzukiHonoka/$REPO"
KVERV="5.7.12"
if [ -z "$ARG1" ]; then
KVERV=$ARG1
fi
KVER="linux-$KVERV"
KURL="https://cdn.kernel.org/pub/linux/kernel/v5.x"
KDURL="$KURL/$KVER.tar.xz"
cd $BUILD_DIR
if [ ! -f "$BUILD_DIR/$REPO" ]; then
git clone --depth=1 --single-branch -b master $SRCURL
fi
wget $KDURL
xz -d "$KVER.tar.xz"
rm "$KVER.tar.xz"
tar xvf "$KVER.tar"
rm "$KVER.tar"
cd "$BUILD_DIR/$REPO"
rsync -av --progress $BUILD_DIR/$KVER/* .
sed -i "s/0x00080000/0x01080000/g" arch/arm64/Makefile
sed -i "s/#error TEXT_OFFSET must be less than 2MB/\/\/#error TEXT_OFFSET must be less than 2MB/g" arch/arm64/kernel/head.S
cat > arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts <<EOF
&external_phy {
        /delete-property/ reset-gpios;
        interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
};
EOF
git status
git add .
git commit -m "Update Kernel to $KVER"
git push
