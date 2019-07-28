ppp0=$(ip addr show ppp0 | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*')
echo "当前外网IP"  $ppp0
remote=$(nslookup router.starx.ml | grep -Eo 'Address: (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*')
location=$(iptables -t nat -L -n --line-number | grep DNAT | head -n 1 | awk '{print $1}')
echo "远程域名A记录" $remote
if [ $ppp0 != $remote ]
then
	retry=0
	echo "远程域名与本机地址不匹配"
	/usr/bin/python /home/starx/DDNS/run.py -c /home/starx/DDNS/config.json
	if [ $location -gt 0 ]
		then
	echo "Index of" $location
	result=$(iptables -t nat -D PREROUTING $location 2>&1)
	failm="iptables: Index of deletion too big."
	while [[ $result != $failm ]]
	do
	result=$(iptables -t nat -D PREROUTING $location 2>&1)
	echo $result
	done
		fi
	while [ $ppp0 != $(nslookup router.starx.ml | grep -Eo 'Address: (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*') ]
	do
	retry=`expr $retry + 1`
	if [ $retry -gt 30 ]
	then
	echo "重新次数超过最大值"
	exit
	return
	fi
	echo "等待DNS生效.."
	sleep 1
	done
	echo "DNS已生效.."
	iptables -t nat -A PREROUTING -p tcp -d $ppp0 --dport 443 -j DNAT --to 192.168.31.105:443
	iptables -t nat -A PREROUTING -p tcp -d $ppp0 --dport 2221 -j DNAT --to 192.168.31.105:22
	iptables -t nat -A PREROUTING -p tcp -d $ppp0 --dport 2099 -j DNAT --to 192.168.31.105:2099
	iptables -t nat -A PREROUTING -p tcp -d $ppp0 --dport 2333 -j DNAT --to 192.168.31.105:2323
	iptables -t nat -A PREROUTING -p tcp -d $ppp0 --dport 9090 -j DNAT --to 192.168.31.105:9090
	iptables -t nat -A PREROUTING -p tcp -d $ppp0 --dport 8083 -j DNAT --to 192.168.31.105:8083
	iptables -t nat -A PREROUTING -p tcp -d $ppp0 --dport 446 -j DNAT --to 192.168.31.105:445
	iptables -t nat -A PREROUTING -p tcp -d $ppp0 --dport 2222 -j DNAT --to 192.168.31.243:22
else
	echo "远程域名与本机地址匹配"
fi
