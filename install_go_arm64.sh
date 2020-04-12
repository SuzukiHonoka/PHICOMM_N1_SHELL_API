prefix=/usr/local
socks5_ip=192.168.31.99
socks5_port=10808
curl --socks5 $socks5_ip:$socks5_port https://dl.google.com/go/go1.14.2.linux-arm64.tar.gz -o $prefix/go.tgz
cd $prefix && tar xzvf $prefix/go.tgz
echo 'GOROOT=/usr/local/go
PATH=$PATH:$GOROOT/bin' >> ~/.bashrc
source ~/.bashrc
