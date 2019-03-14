#!/bin/bash
peer channel create -o orderer0.orgorderer1:7050 -c mychannel -f ./channel-artifacts/channel.tx
cp mychannel.block ./channel-artifacts
chmod 777 ./channel-artifacts/mychannel.block
peer channel join -b ./channel-artifacts/mychannel.block
export CHANNEL_NAME=mychannel
CORE_PEER_LOCALMSPID="Org1MSP"
CORE_PEER_ADDRESS=peer1.org1:7051
peer channel join -b ./channel-artifacts/mychannel.block
peer channel update -o orderer0.orgorderer1:7050 -c mychannel -f ./channel-artifacts/Org1MSPanchors.tx
