#!/bin/sh
MONGO_IP=$1
MONGO_PORT=$2
MONGO_EXPRESS_PASSWORD=$3

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
sudo echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo apt install -y mongodb-org=4.0.1 mongodb-org-server=4.0.1 mongodb-org-shell=4.0.1 mongodb-org-mongos=4.0.1 mongodb-org-tools=4.0.1
sudo systemctl start mongod
sudo systemctl enable mongod
sudo sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/g' /etc/mongod.conf
sudo sed -i 's/port: 27017/port: '"$MONGO_PORT"'/g' /etc/mongod.conf
sudo chmod -R 777 /var/lib/mongodb
sudo systemctl restart mongod

sudo apt-get install -y docker.io
docker run -d --restart always --name mongo-express -p 28020:8081 -e ME_CONFIG_MONGODB_SERVER=${MONGO_IP} -e ME_CONFIG_MONGODB_PORT=${MONGO_PORT} -e ME_CONFIG_BASICAUTH_USERNAME="admin" -e ME_CONFIG_BASICAUTH_PASSWORD=${MONGO_EXPRESS_PASSWORD} mongo-express




####### Run this script as below #####
###    sh mongo-as-service.sh <mongo-ip> <mongo-port> <mongo-express-password>  ####