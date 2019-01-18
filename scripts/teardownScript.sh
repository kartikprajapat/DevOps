#!/bin/bash
cd /home/ubuntu/fabric-dev-servers/

######### Tear Down #############
./teardownFabric.sh

###DELETES CARDS#####
rm -rf ~/.composer/*

###DELETES OLD PRODUCTION DATA#######
rm -rf /var/hyperledger/production/*

echo "\n\n-----Stopping the dev-peer docker process-------"
docker stop $(docker ps -aq --filter=name=dev-peer) 
echo "\n\n-----Removing the dev-peer docker process image-------"
docker rm --force $(docker ps -aq --filter=name=dev-peer)
echo "\n\n-----Removing the dev-peer docker image-------"
docker rmi --force $(docker images -aq --filter=reference=dev-peer*)

######### Tear Up ############
./startFabric.sh

#####CREATES CARDS#######
./createPeerAdminCard.sh

######STARTS COMPOSER REST SERVER##########
cd /home/ubuntu/blockchain-services/aob-erp-order-mgmt-service/aob-erp-order-mgmt
sed -i 's/"version": .*\,/"version": "0.0.1"\,/g' package.json
./deployFabric.sh
cd /home/ubuntu/blockchain-services/aob-erp-inventory-mgmt-service/aob-erp-inventory-mgmt
sed -i 's/"version": .*\,/"version": "0.0.1"\,/g' package.json
./deployFabric.sh
cd /home/ubuntu/blockchain-services/aob-sales-order-invoice-service/aob-sales-invoice
sed -i 's/"version": .*\,/"version": "0.0.1"\,/g' package.json
./deployFabric.sh
cd /home/ubuntu/blockchain-services/aob-labs-service/aob-labs
sed -i 's/"version": .*\,/"version": "0.0.1"\,/g' package.json
./deployFabric.sh
cd /home/ubuntu/blockchain-services/aob-erp-discount-mgmt/aob-erp-discount-mgmt-service

######REPLACES VERION TO 0.0.1, because after teardown or first time tearup everything is new and set to version 0.0.1#######
sed -i 's/"version": .*\,/"version": "0.0.1"\,/g' package.json

####THIS DEPLOYS BNA ON BLOCKCHAIN NETWORK(made by us)#########
./deployFabric.sh
