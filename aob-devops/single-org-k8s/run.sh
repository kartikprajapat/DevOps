sudo chmod -R 777 /home/ubuntu/.composer
cd /home/ubuntu/single-org-k8s
sudo rm -rf /home/ubuntu/.composer/* PeerAdmin@stemcell-network-org1.card stemcelladmin stemcelladmin@stem-cells.card stemcellrest.card composer 
sudo mkdir org1 composer
sudo mv org1 composer
export ORG1=/opt/share/crypto-config/peerOrganizations/org1/users/Admin@org1/msp
sudo cp -p $ORG1/signcerts/A*.pem composer/org1
sudo cp -p $ORG1/keystore/*_sk composer/org1
sudo chmod -R 777 /home/ubuntu/single-org-k8s
curl -O https://hyperledger.github.io/composer/v0.19/prereqs-ubuntu.sh
chmod u+x prereqs-ubuntu.sh
./prereqs-ubuntu.sh
	login/logout
npm install -g composer-cli@0.20
npm install -g composer-rest-server@0.20
composer card create -p stemcell-business-network.json -u PeerAdmin -c composer/org1/Admin@org1-cert.pem -k composer/org1/*_sk -r PeerAdmin -r ChannelAdmin -f PeerAdmin@stemcell-network-org1.card
composer card import -f  PeerAdmin@stemcell-network-org1.card --card PeerAdmin@stemcell-network-org1

If below error occurs:
✖ Installing business network. This may take a minute...
Error: Error trying install business network. Error: No valid responses from any peers.
Response from attempted peer comms was an error: Error: 14 UNAVAILABLE: Trying to connect an http1.x server
Response from attempted peer comms was an error: Error: 14 UNAVAILABLE: Trying to connect an http1.x server

then create a private dns and add k8s master entry in it

composer network install -c PeerAdmin@stemcell-network-org1 -a stem-cells@0.0.7.bna -o npmrcFile=npmConfig
composer identity request -c PeerAdmin@stemcell-network-org1 -u admin -s adminpw -d stemcelladmin
composer network start -o npmrcFile=npmConfig --networkName stem-cells --networkVersion 0.0.7 -c PeerAdmin@stemcell-network-org1 -o endorsementPolicyFile=endorsement-policy.json -A stemcelladmin -C stemcelladmin/admin-pub.pem
composer card create -p stemcell-business-network.json -u stemcelladmin -n stem-cells -c stemcelladmin/admin-pub.pem -k stemcelladmin/admin-priv.pem
composer card import -f stemcelladmin@stem-cells.card
composer network ping -c stemcelladmin@stem-cells
composer participant add -c stemcelladmin@stem-cells -d '{"$class":"org.hyperledger.composer.system.NetworkAdmin", "participantId":"stemcellrest"}'
composer identity issue -c stemcelladmin@stem-cells -f stemcellrest.card -u stemcellrest -a "resource:org.hyperledger.composer.system.NetworkAdmin#stemcellrest"
composer card import -f stemcellrest.card
composer network ping -c stemcellrest@stem-cells
composer network list -c stemcellrest@stem-cells
