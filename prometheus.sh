docker run -d --name prometheus --net zabbix-net --ip 172.20.240.10 -p 9090:9090 --restart always ubuntu/prometheus

docker exec -it prometheus bash -c "apt update -y && apt upgrade -y && apt install zabbix-agent -y && apt install iproute2 -y"

echo "zabbix-agent installed"

docker exec -it prometheus bash -c "sed -i 's/^Server=.*/Server=172.20.240.5/' /etc/zabbix/zabbix_agentd.conf"

docker exec -it prometheus bash -c "sed -i 's/^ServerActive=.*/ServerActive=172.20.240.5/' /etc/zabbix/zabbix_agentd.conf"

docker exec -it prometheus bash -c "service zabbix-agent  start"
