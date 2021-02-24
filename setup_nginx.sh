#!/bin/bash
# Ths is used for compile NGINX For Starx.
#vars
nginx_ver="1.19.4"
openssl_ver="1.1.1j"
stage_dir="/tmp/web"
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
git clone --depth=1 $naxsi_src --single-branch
#ex
tar xf nginx-$nginx_ver.tar.gz
tar xf openssl-$openssl_ver.tar.gz
#stage
cd nginx-$nginx_ver
#submod init
cd ../ngx_brotli && git submodule update --init && cd $stage_dir/nginx-$nginx_ver
#config
sudo apt install libpcre++-dev zlib1g-dev libgeoip-dev gcc g++ make -y
./configure --with-stream_ssl_preread_module --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-http_mp4_module --with-http_flv_module --with-file-aio --with-threads --with-pcre-jit --with-http_addition_module --with-http_dav_module --with-http_geoip_module --with-http_stub_status_module --with-http_ssl_module --with-http_v2_module --with-http_auth_request_module --with-http_realip_module --with-http_gzip_static_module --with-http_gunzip_module --with-mail --with-mail_ssl_module --with-stream --with-openssl=../openssl-$openssl_ver --add-module=../ngx_brotli --add-module=../naxsi/naxsi_src

make -j$(nproc)
sudo make install
