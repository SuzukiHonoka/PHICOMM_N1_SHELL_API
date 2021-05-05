#!/bin/sh
echo "Starting aarch64 toolchain setup"
stage_dir="/opt/toolchain/aarch64"
tool_url="https://github.com/SuzukiHonoka/s905d-kernel-precompiled/releases/download/gcc-10.2/gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu.tar.xz"
mkdir -p $stage_dir
cd $stage_dir
wget $tool_url
xz -d gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu.tar.xz
tar xf gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu.tar && rm gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu.tar
echo "AARCH64_TOOLCHAIN_DIR=$stage_dir" >> ~/.bashrc
echo 'PATH=$PATH:$AARCH64_TOOLCHAIN_DIR/gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu/bin' >> ~/.bashrc
source ~/.bashrc
echo "Done"
