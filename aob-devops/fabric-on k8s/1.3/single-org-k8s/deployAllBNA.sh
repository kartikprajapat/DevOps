echo "Removing cards\n"
sudo rm -rf /home/ubuntu/.composer/* erpadmin composer *.card
echo "Setting certificates\n"
sudo mkdir org1 composer
sudo mv org1 composer
export ORG1=/opt/share/crypto-config/peerOrganizations/org1/users/Admin@org1/msp/
sudo cp -p $ORG1/signcerts/A*.pem composer/org1
sudo cp -p $ORG1/keystore/*_sk composer/org1
sudo chmod -R 777 /home/ubuntu/single-org-k8s
echo "Creating fabric netork admin card\n"
composer card create -p erp-business-network.json -u PeerAdmin -c composer/org1/Admin@org1-cert.pem -k composer/org1/*_sk -r PeerAdmin -r ChannelAdmin -f PeerAdmin@erp-network-org1.card
sudo chmod -R 777 /home/ubuntu/.composer/
composer card import -f  PeerAdmin@erp-network-org1.card --card PeerAdmin@erp-network-org1

######## Inventory management###############
echo "Deploying ERP Inventory management\n"
composer network install -c PeerAdmin@erp-network-org1 -a aob-erp-inventory-mgmt.bna -o npmrcFile=npmConfig
composer identity request -c PeerAdmin@erp-network-org1 -u admin -s adminpw -d erpadmin
composer network start -o npmrcFile=npmConfig --networkName aob-erp-inventory-mgmt --networkVersion 0.0.1 -c PeerAdmin@erp-network-org1 -o endorsementPolicyFile=endorsement-policy.json -A erpadmin -C erpadmin/admin-pub.pem
composer card create -p erp-business-network.json -u erpinventoryadmin -n aob-erp-inventory-mgmt -c erpadmin/admin-pub.pem -k erpadmin/admin-priv.pem
composer card import -f erpinventoryadmin@aob-erp-inventory-mgmt.card
composer network ping -c erpinventoryadmin@aob-erp-inventory-mgmt


######## Order management###############
echo "Deploying ERP order management\n"
composer network install -c PeerAdmin@erp-network-org1 -a aob-erp-order-mgmt.bna -o npmrcFile=npmConfig
composer network start -o npmrcFile=npmConfig --networkName aob-erp-order-mgmt --networkVersion 0.0.1 -c PeerAdmin@erp-network-org1 -o endorsementPolicyFile=endorsement-policy.json -A erpadmin -C erpadmin/admin-pub.pem
composer card create -p erp-business-network.json -u erporderadmin -n aob-erp-order-mgmt -c erpadmin/admin-pub.pem -k erpadmin/admin-priv.pem
composer card import -f erporderadmin@aob-erp-order-mgmt.card
composer network ping -c erporderadmin@aob-erp-order-mgmt


######## Sales-invoice management###############
echo "Deploying ERP Sales Invoice management\n"
composer network install -c PeerAdmin@erp-network-org1 -a aob-sales-invoice.bna -o npmrcFile=npmConfig
composer network start -o npmrcFile=npmConfig --networkName aob-sales-invoice --networkVersion 0.0.1 -c PeerAdmin@erp-network-org1 -o endorsementPolicyFile=endorsement-policy.json -A erpadmin -C erpadmin/admin-pub.pem
composer card create -p erp-business-network.json -u erpsalesinvoiceadmin -n aob-sales-invoice -c erpadmin/admin-pub.pem -k erpadmin/admin-priv.pem
composer card import -f erpsalesinvoiceadmin@aob-sales-invoice.card
composer network ping -c erpsalesinvoiceadmin@aob-sales-invoice



######## Lab management###############
echo "Deploying ERP Lab management\n"
composer network install -c PeerAdmin@erp-network-org1 -a aob-labs.bna -o npmrcFile=npmConfig
composer network start -o npmrcFile=npmConfig --networkName aob-labs --networkVersion 0.0.1 -c PeerAdmin@erp-network-org1 -o endorsementPolicyFile=endorsement-policy.json -A erpadmin -C erpadmin/admin-pub.pem
composer card create -p erp-business-network.json -u erplabadmin -n aob-labs -c erpadmin/admin-pub.pem -k erpadmin/admin-priv.pem
composer card import -f erplabadmin@aob-labs.card
composer network ping -c erplabadmin@aob-labs

#composer participant add -c erplabadmin@aob-labs -d '{"$class":"org.hyperledger.composer.system.NetworkAdmin", "participantId":"erplabrest"}'
#composer identity issue -c erplabadmin@aob-labs -f erplabrest.card -u erplabrest -a "resource:org.hyperledger.composer.system.NetworkAdmin#erplabrest"
#composer card import -f erplabrest.card
#composer network ping -c erplabrest@aob-labs
#composer network list -c erplabrest@aob-labs




#### To get network name and version from bna
####composer archive list -a aob-erp-inventory-mgmt.bna 
