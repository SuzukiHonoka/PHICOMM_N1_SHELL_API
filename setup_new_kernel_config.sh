#!/bin/sh
chain="aarch64-none-linux-gnu-"
stage_dir="/opt/ramfs"
old_config="https://github.com/SuzukiHonoka/s905d-kernel-precompiled/raw/master/.config"
kver=linux-$1
archive=$kver.tar.xz
kurl="https://cdn.kernel.org/pub/linux/kernel/v5.x/$archive"
mkdir -p $stage_dir
mount -t tmpfs -o size=2G tmpfs $stage_dir
cd $stage_dir
wget $old_config
wget $kurl
xz -d $archive
rm $archive
tar xf $kver.tar
rm $kver.tar
cd $kver
cp ../.config .
make ARCH=arm64 CROSS_COMPILE=$chain oldconfig
make ARCH=arm64 CROSS_COMPILE=$chain menuconfig
