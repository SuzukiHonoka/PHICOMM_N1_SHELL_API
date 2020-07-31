#!/bin/bash
# Ths is used for compile NGINX For Starx.
#vars
nginx_ver="1.19.1"
openssl_ver="1.1.1g"
stage_dir="/media/Samsung128/SRC/web"
#urls
nginx_src="http://nginx.org/download/nginx-$nginx_ver.tar.gz"
openssl_src="https://www.openssl.org/source/openssl-$openssl_ver.tar.gz"
brotli_src="https://github.com/google/ngx_brotli"
naxsi_src="https://github.com/nbs-system/naxsi"
#Download
[ ! -d "$stage_dir" ] && mkdir -p $stage_dir
cd $stage_dir
rm -r $stage_dir/*
wget $nginx_src -4
wget $openssl_src -4
git clone --depth=1 $brotli_src
git clone --depth=1 $naxsi_src
#ex
tar xzvf nginx-$nginx_ver.tar.gz
tar xzvf openssl-$openssl_ver.tar.gz
#stage
cd nginx-$nginx_ver
#submod init
cd ../ngx_brotli && git submodule update --init && cd $stage_dir/nginx-$nginx_ver
#config
./configure --with-pcre-jit --with-openssl=../openssl-$openssl_ver --add-module=../ngx_brotli --with-http_stub_status_module --with-http_ssl_module --with-http_v2_module --with-openssl-opt=enable-tls1_3 --with-http_realip_module --with-http_gzip_static_module --with-http_gunzip_module --add-module=../naxsi/naxsi_src/ --with-stream
make -j$(nproc)
make install
