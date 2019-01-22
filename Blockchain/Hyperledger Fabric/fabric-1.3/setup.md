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



# Tear Down Steps

cd fabric-samples/first-network

docker-compose -f docker-compose-cli.yaml down --volumes --remove-orphan

docker rm -f $(docker ps -a | grep fabric | awk '{print $1}')

docker rm -f $(docker ps -a | grep dev-peer | awk '{print $1}')

docker network rm net_byfn
