../bin/configtxgen -profile OneOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID mychannel
../bin/configtxgen -profile OneOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID mychannel -asOrg Org1MSP
sudo cp -r ./channel-artifacts /opt/share/
sudo chmod -R 777 /opt/share/
