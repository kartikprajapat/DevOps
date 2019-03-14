sudo rm -rf /home/ubuntu/.composer/* erpadmin PeerAdmin@erp-network-org1.card composer
sudo mkdir org1 composer
sudo mv org1 composer
export ORG1=/opt/share/crypto-config/peerOrganizations/org1/users/Admin@org1/msp/
sudo cp -p $ORG1/signcerts/A*.pem composer/org1
sudo cp -p $ORG1/keystore/*_sk composer/org1
sudo chmod -R 777 /home/ubuntu/single-org-k8s
composer card create -p erp-business-network.json -u PeerAdmin -c composer/org1/Admin@org1-cert.pem -k composer/org1/*_sk -r PeerAdmin -r ChannelAdmin -f PeerAdmin@erp-network-org1.card
sudo chmod -R 777 /home/ubuntu/.composer/
composer card import -f  PeerAdmin@erp-network-org1.card --card PeerAdmin@erp-network-org1
composer network install -c PeerAdmin@erp-network-org1 -a aob-erp-inventory-mgmt.bna -o npmrcFile=npmConfig
composer identity request -c PeerAdmin@erp-network-org1 -u admin -s adminpw -d erpadmin

composer network start -o npmrcFile=npmConfig --networkName aob-erp-inventory-mgmt --networkVersion 0.0.1 -c PeerAdmin@erp-network-org1 -o endorsementPolicyFile=endorsement-policy.json -A erpadmin -C erpadmin/admin-pub.pem
composer card create -p erp-business-network.json -u erpinventoryadmin -n aob-erp-inventory-mgmt -c erpadmin/admin-pub.pem -k erpadmin/admin-priv.pem
composer card import -f erpinventoryadmin@aob-erp-inventory-mgmt.card
composer network ping -c erpinventoryadmin@aob-erp-inventory-mgmt
composer participant add -c erpinventoryadmin@aob-erp-inventory-mgmt -d '{"$class":"org.hyperledger.composer.system.NetworkAdmin", "participantId":"erpinventoryrest"}'
composer identity issue -c erpinventoryadmin@aob-erp-inventory-mgmt -f erpinventoryrest.card -u erpinventoryrest -a "resource:org.hyperledger.composer.system.NetworkAdmin#erpinventoryrest"
composer card import -f erpinventoryrest.card
composer network ping -c erpinventoryrest.card
composer network list -c erpinventoryrest.card




composer network install -c PeerAdmin@erp-network-org1 -a aob-erp-order-mgmt.bna -o npmrcFile=npmConfig
composer network start -o npmrcFile=npmConfig --networkName aob-erp-order-mgmt --networkVersion 0.0.1 -c PeerAdmin@erp-network-org1 -o endorsementPolicyFile=endorsement-policy.json -A erpadmin -C erpadmin/admin-pub.pem

composer network install -c PeerAdmin@erp-network-org1 -a aob-sales-invoice.bna -o npmrcFile=npmConfig
composer network start -o npmrcFile=npmConfig --networkName aob-sales-invoice --networkVersion 0.0.1 -c PeerAdmin@erp-network-org1 -o endorsementPolicyFile=endorsement-policy.json -A erpadmin -C erpadmin/admin-pub.pem

composer network install -c PeerAdmin@erp-network-org1 -a aob-labs.bna -o npmrcFile=npmConfig
composer network start -o npmrcFile=npmConfig --networkName aob-labs --networkVersion 0.0.1 -c PeerAdmin@erp-network-org1 -o endorsementPolicyFile=endorsement-policy.json -A erpadmin -C erpadmin/admin-pub.pem



composer archive list -a aob-erp-inventory-mgmt.bna 
composer archive list -a aob-erp-order-mgmt.bna 
composer archive list -a aob-labs.bna 
composer archive list -a aob-sales-invoice.bna 
composer network install -c PeerAdmin@erp-network-org1 -a aob-erp-order-mgmt.bna -o npmrcFile=npmConfig
composer network install -c PeerAdmin@erp-network-org1 -a aob-labs.bna -o npmrcFile=npmConfig
composer network install -c PeerAdmin@erp-network-org1 -a aob-sales-invoice.bna -o npmrcFile=npmConfig

