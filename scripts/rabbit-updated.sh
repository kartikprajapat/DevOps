#!/bin/bash
sudo apt-get -y update
sudo apt-get -y upgrade
cd ~
wget http://packages.erlang-solutions.com/site/esl/esl-erlang/FLAVOUR_1_general/esl-erlang_20.1-1~ubuntu~xenial_amd64.deb
sudo dpkg -i esl-erlang_20.1-1\~ubuntu\~xenial_amd64.deb
echo "deb https://dl.bintray.com/rabbitmq/debian xenial main" | sudo tee /etc/apt/sources.list.d/bintray.rabbitmq.list
wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | sudo apt-key add -
sudo apt-get -y update
sudo apt-get -y -f install
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
sudo dpkg -i erlang-solutions_1.0_all.deb
sudo apt-get update
sudo apt-get -y install erlang
sudo apt-get -y install rabbitmq-server
sudo systemctl start rabbitmq-server.service
sudo systemctl enable rabbitmq-server.service
sudo rabbitmqctl delete_user guest
sudo rabbitmqctl add_user radmin radmin
sudo rabbitmqctl set_user_tags radmin administrator
sudo rabbitmqctl set_permissions -p / radmin ".*" ".*" ".*"
rabbitmqctl list_users
sudo rabbitmq-plugins enable rabbitmq_management
sudo chown -R rabbitmq:rabbitmq /var/lib/rabbitmq/
touch /etc/rabbitmq/rabbitmq.conf
echo "loopback_users.guest = false
listeners.tcp.default = 5672
hipe_compile = false
log.file = rabbit.log
log.dir = /var/log/rabbitmq
log.file.level = error
log.file.rotation.size = 1048576
log.file.rotation.count = 25
log.console = false" > /etc/rabbitmq/rabbitmq.conf
sudo systemctl restart rabbitmq-server.service
