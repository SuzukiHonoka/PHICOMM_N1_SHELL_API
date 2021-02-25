#!/bin/sh
chain="aarch64-none-linux-gnu-"
stage_dir="/opt/ramfs"
old_config="https://github.com/SuzukiHonoka/s905d-kernel-precompiled/raw/master/.config"
kver=linux-$1
archive=$kver.tar.xz
kurl="https://cdn.kernel.org/pub/linux/kernel/v5.x/$archive"
if [ -z $2 ]; then
  mkdir -p $stage_dir
  mount -t tmpfs -o size=4G tmpfs $stage_dir
  else
  mkdir -p $2
  stage_dir=$2
fi
cd $stage_dir
wget $old_config
wget $kurl
xz -d $archive
tar xf $kver.tar
rm $kver.tar
cd $kver
cp ../.config .
make ARCH=arm64 CROSS_COMPILE=$chain oldconfig
make ARCH=arm64 CROSS_COMPILE=$chain menuconfig
