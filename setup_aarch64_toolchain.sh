#!/bin/sh
echo "Starting aarch64 toolchain setup"
tool_url="https://github.com/SuzukiHonoka/s905d-kernel-precompiled/releases/download/gcc-10.2/gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu.tar.xz"
mkdir -p /tmp/stage
cd /tmp/stage
wget $tool_url
xz -d gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu.tar.xz
tar xf gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu.tar
 echo 'PATH=$PATH:/tmp/ramfs/toolchain/gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu/bin' > ~/.bashrc
source ~/.bashrc
echo "Done"
