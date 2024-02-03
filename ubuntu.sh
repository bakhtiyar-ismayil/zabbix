#ip_address=$(docker exec -it zabbix-server-mysql bash -c 'ip a' | grep 'inet ' | awk '{print $2}' | cut -d '/' -f 1)


docker run -d --name ubuntu1 --net zabbix-net ubuntu sleep infinity 


docker exec -it ubuntu1  bash -c "apt update -y && apt upgrade -y && apt install zabbix-agent -y && apt install iproute2 -y"

echo "zabbix-agent installed" 


docker exec -it ubuntu1 bash -c "ip_address=\$(ip a | grep 'inet ' | awk '{print \$2}' | cut -d '/' -f 1); \
cat << EOF >> /etc/zabbix/zabbix_agentd.conf
PidFile=/var/run/zabbix/zabbix_agentd.pid
LogFile=/var/log/zabbix/zabbix_agentd.log
LogFileSize=0
EnableRemoteCommands=1
Server=\$ip_address
ServerActive=\$ip_address
Include=/etc/zabbix/zabbix_agentd.d/*.conf
Hostname=ubuntu1
User=zabbix
EOF"


#sed -i "s/Server=.*/Server=$ip_address/" /etc/zabbix/zabbix_agentd.conf
#sed -i "s/ServerActive=.*/ServerActive=$ip_address/" /etc/zabbix/zabbix_agentd.conf


