# Install zabbix server:

docker run -d -P --name zabbix  berngp/docker-zabbix

# Install zabbix agent:

docker run \
 --name=zabbix-agent-xxl \
 -h $(hostname) \
 -p 10050:10050 \
 -v /:/rootfs \
 -v /var/run:/var/run \
 -e "ZA_Server=192.168.1.19" \
 -d monitoringartist/zabbix-agent-xxl-limited:latest

# Test the zabbix installation:

docker exec -it zabbix-agent-xxl zabbix_agent_bench -timelimit 30 -key stress.ping --threads 50


# Access zabbix on below IP port:

http://localhost:32771/zabbix/
