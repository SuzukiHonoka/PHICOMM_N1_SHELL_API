#!/bin/bash
openssl_ver="1.1.1i"
stage_dir="/tmp/openssl"
openssl_src="https://www.openssl.org/source/openssl-$openssl_ver.tar.gz"
[ ! -d "$stage_dir" ] && mkdir -p $stage_dir
cd $stage_dir
rm -r $stage_dir/*
wget $openssl_src -4
tar xzvf openssl-$openssl_ver.tar.gz
cd openssl-$openssl_ver
./config -Wl,--enable-new-dtags,-rpath,'$(LIBRPATH)'
make -j$(nproc)
make install
