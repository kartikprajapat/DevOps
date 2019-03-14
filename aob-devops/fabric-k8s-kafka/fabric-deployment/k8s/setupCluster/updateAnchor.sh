export FABRIC_CFG_PATH=$PWD
../bin/configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID mychannel
../bin/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Peerorg2Panchor.tx -channelID mychannel -asOrg Peerorg2MSP
../bin/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Peerorg1MSPanchor.tx -channelID mychannel -asOrg Peerorg1MSP
cp -r ./channel-artifacts /opt/share/

