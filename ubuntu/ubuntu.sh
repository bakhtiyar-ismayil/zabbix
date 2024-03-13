#ip_address=$(docker exec -it zabbix-server-mysql bash -c 'ip a' | grep 'inet ' | awk '{print $2}' | cut -d '/' -f 1)


docker run -d --name ubuntu1 --net zabbix-net --ip 172.20.240.2 --restart unless-stopped ubuntu sleep infinity

docker exec -it ubuntu1  bash -c "apt update -y && apt upgrade -y && apt install zabbix-agent -y && apt install iproute2 -y"

echo "zabbix-agent installed" 


docker exec -it ubuntu1 bash -c "sed -i 's/^Server=.*/Server=172.20.240.5/' /etc/zabbix/zabbix_agentd.conf"

docker exec -it ubuntu1 bash -c "sed -i 's/^ServerActive=.*/ServerActive=172.20.240.5/' /etc/zabbix/zabbix_agentd.conf"


docker run -d --name ubuntu2 --net zabbix-net --ip 172.20.240.3 --restart unless-stopped ubuntu sleep infinity

docker exec -it ubuntu2  bash -c "apt update -y && apt upgrade -y && apt install zabbix-agent -y && apt install iproute2 -y"

echo "zabbix-agent installed"


docker exec -it ubuntu2 bash -c "sed -i 's/^Server=.*/Server=172.20.240.5/' /etc/zabbix/zabbix_agentd.conf"

docker exec -it ubuntu2 bash -c "sed -i 's/^ServerActive=.*/ServerActive=172.20.240.5/' /etc/zabbix/zabbix_agentd.conf"

