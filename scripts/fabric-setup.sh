curl -O https://hyperledger.github.io/composer/v0.19/prereqs-ubuntu.sh
chmod u+x prereqs-ubuntu.sh
./prereqs-ubuntu.sh
<logout/login>
npm install -g composer-cli@0.19
npm install -g composer-rest-server@0.19
mkdir ~/fabric-dev-servers && cd ~/fabric-dev-servers

curl -O https://raw.githubusercontent.com/hyperledger/composer-tools/master/packages/fabric-dev-servers/fabric-dev-servers.tar.gz
tar -xvf fabric-dev-servers.tar.gz

cd ~/fabric-dev-servers
export FABRIC_VERSION=hlfv11
./downloadFabric.sh

cd ~/fabric-dev-servers/fabric-scripts/hlfv11/composer
vi docker-compose.yml
add: restart policy and -v /var/hyperledger/production:/var/hyperledger/production in peer

sudo mkdir -p /var/hyperledger/production
sudo chmod -R 777 /var/hyperledger/production

cd ~/fabric-dev-servers
export FABRIC_VERSION=hlfv11
cd /home/ubuntu/fabric-dev-servers
./startFabric.sh
./createPeerAdminCard.sh

