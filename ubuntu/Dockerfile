# Ubuntu and Ubuntu/Grafana image 
FROM ubuntu as ubuntu-image

# Update package lists
USER root
RUN apt-get update -y

# Upgrade installed packages
RUN apt-get upgrade -y

# Install zabbix-agent and iproute2
RUN apt-get install -y zabbix-agent iproute2 vim 

# Replace Zabbix agent configuration with custom settings
RUN sed -i 's/^Server=.*/Server=172.20.240.5/' /etc/zabbix/zabbix_agentd.conf && \
    sed -i 's/^ServerActive=.*/ServerActive=172.20.240.5/' /etc/zabbix/zabbix_agentd.conf
RUN service zabbix-agent start




FROM ubuntu/grafana as grafana-image
USER root
RUN apt-get update  -y
RUN apt-get upgrade -y
RUN apt-get install -y zabbix-agent iproute2

# Replace Zabbix agent configuration with custom settings
RUN sed -i 's/^Server=.*/Server=172.20.240.5/' /etc/zabbix/zabbix_agentd.conf && \
    sed -i 's/^ServerActive=.*/ServerActive=172.20.240.5/' /etc/zabbix/zabbix_agentd.conf

# Start Zabbix agent service
RUN service zabbix-agent start

# Expose port 3000 for Grafana
EXPOSE 3000

# Start Grafana (this might also be different based on how you want to start Grafana)
# CMD ["grafana-server", "--config=/etc/grafana/grafana.ini"]

# Note: The installation and startup commands for Grafana will depend on how you want to install and run it.
