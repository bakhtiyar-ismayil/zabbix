FROM zabbix/zabbix-server-mysql

# Update package lists
USER root
RUN apk update

# Upgrade installed packages
RUN apk upgrade 

# Install zabbix-agent and iproute2
RUN apk add  zabbix-agent iproute2 vim
RUN apk add openrc 
# Replace Zabbix agent configuration with custom settings
RUN sed -i 's/^Server=.*/Server=172.20.240.5/' /etc/zabbix/zabbix_agentd.conf && \
    sed -i 's/^ServerActive=.*/ServerActive=172.20.240.5/' /etc/zabbix/zabbix_agentd.conf


# Expose port 3000 for Grafana
EXPOSE 3000
EXPOSE 10050

