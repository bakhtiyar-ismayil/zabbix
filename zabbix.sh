docker network create --subnet 172.20.0.0/16 --ip-range 172.20.240.0/20 zabbix-net

echo "docker network created"

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


#echo "docker network created" 

docker run --name mysql-server -t \
      -e MYSQL_DATABASE="zabbix" \
      -e MYSQL_USER="zabbix" \
      -e MYSQL_PASSWORD="zabbix_pwd" \
      -e MYSQL_ROOT_PASSWORD="root_pwd" \
      --network=zabbix-net \
      --restart unless-stopped \
      -d mysql:8.0-oracle \
      --character-set-server=utf8 --collation-server=utf8_bin \
      --default-authentication-plugin=mysql_native_password

echo "mysql server created" 


docker run --name zabbix-java-gateway -t \
      --network=zabbix-net \
      --restart unless-stopped \
      -d zabbix/zabbix-java-gateway

echo "zabbix-java-gateway created" 


docker run --name zabbix-server-mysql -t \
      -e DB_SERVER_HOST="mysql-server" \
      -e MYSQL_DATABASE="zabbix" \
      -e MYSQL_USER="zabbix" \
      -e MYSQL_PASSWORD="zabbix_pwd" \
      -e MYSQL_ROOT_PASSWORD="root_pwd" \
      -e ZBX_JAVAGATEWAY="zabbix-java-gateway" \
      --ip=172.20.240.5 \
      --network=zabbix-net \
      -p 10051:10051 \
      --restart unless-stopped \
      -d zabbix/zabbix-server-mysql
      

echo "zabbix-server-mysql created" 


docker run --name zabbix-web-nginx-mysql -t \
      -e ZBX_SERVER_HOST="zabbix-server-mysql" \
      -e DB_SERVER_HOST="mysql-server" \
      -e MYSQL_DATABASE="zabbix" \
      -e MYSQL_USER="zabbix" \
      -e MYSQL_PASSWORD="zabbix_pwd" \
      -e MYSQL_ROOT_PASSWORD="root_pwd" \
      --network=zabbix-net \
      -p 80:8080 \
      --restart unless-stopped \
      -d zabbix/zabbix-web-nginx-mysql


echo "zabbix-web-nginx created" 


docker exec -it ubuntu1 bash -c "service zabbix-agent  start"

docker exec -it ubuntu1 bash -c "service zabbix-agent status"

docker exec -it ubuntu2 bash -c "service zabbix-agent  start"

docker exec -it ubuntu2 bash -c "service zabbix-agent status"


