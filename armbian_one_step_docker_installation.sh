#Starx's work
echo "即将开始安装docker并安装管理平台启用自启。"
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh --mirror Aliyun
#
docker volume create portainer_data
docker run --restart=always -d -p 7000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer:linux-arm64
echo '脚本结束。管理地址IP:9000'
