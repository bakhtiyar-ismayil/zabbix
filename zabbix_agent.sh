docker exec -it ubuntu1 bash -c "service zabbix-agent  start"

docker exec -it ubuntu1 bash -c "service zabbix-agent status"

docker exec -it ubuntu2 bash -c "service zabbix-agent  start"

docker exec -it ubuntu2 bash -c "service zabbix-agent status"
