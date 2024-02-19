docker run -d --name grafana --net zabbix-net --ip 172.20.240.11 --user root -p 3000:3000 --restart always ubuntu/grafana

docker exec -it grafana bash -c "apt update -y && apt upgrade -y && apt install zabbix-agent -y && apt install iproute2 -y"

echo "zabbix-agent installed"

docker exec -it grafana bash -c "sed -i 's/^Server=.*/Server=172.20.240.5/' /etc/zabbix/zabbix_agentd.conf"

docker exec -it grafana bash -c "sed -i 's/^ServerActive=.*/ServerActive=172.20.240.5/' /etc/zabbix/zabbix_agentd.conf"

docker exec -it grafana bash -c "service zabbix-agent  start"
