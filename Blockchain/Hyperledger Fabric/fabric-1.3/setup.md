# Steps to setup fabric v1.3:


1. clones the repo and download the required docker images:
      curl -sSL http://bit.ly/2ysbOFE | bash -s 1.3.0 1.3.0 0.4.13
      
2. cd fabric-samples

3. cd first-network

4. Generates the build artifacts:

   ./byfn.sh generate -c mychannel
      
5. Creates the all containers
   ./byfn.sh up -c mychannel -s couchdb -i 1.3.0
   
Note: If the error is like:
   Error: got unexpected status: FORBIDDEN -- Failed to reach implicit threshold of 1 sub-policies, required 1 remaining: permission denied
   
   Then run below command and tearup again
   docker-compose -f docker-compose-cli.yaml down --volumes --remove-orphan
   
   If CA throws error then please replace the name of file in the volume mount with the correct one, the correct name can be found at the mount folder.



# Tear Down Steps

cd fabric-samples/first-network

docker-compose -f docker-compose-cli.yaml down --volumes --remove-orphan

docker rm -f $(docker ps -a | grep fabric | awk '{print $1}')

docker rm -f $(docker ps -a | grep dev-peer | awk '{print $1}')

docker network rm net_byfn





# Setup Composer

mkdir -p /home/ubuntu/fabric1.3/composer
mkdir -p /home/ubuntu/fabric1.3/composer/org1
mkdir -p /home/ubuntu/fabric1.3/composer/org2


cd /home/ubuntu/fabric1.3/composer/

Create byfn-network.json

vi byfn-network.json
(paste the content from file present in repo)



cd /home/ubuntu/fabric1.3/fabric-samples/first-network

awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt > /home/ubuntu/fabric1.3/composer/org1/ca-org1.txt

awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt > /home/ubuntu/fabric1.3/composer/org2/ca-org2.txt

awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt > /home/ubuntu/fabric1.3/composer/ca-orderer.txt
