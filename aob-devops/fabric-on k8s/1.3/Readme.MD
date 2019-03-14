#### Describe how to setup hyperledger fabric 1.3 on kubernetes and backup of mongo & couch & production data & Cards in EFS.


### Tear Down network
Note :- run below commands with root user

1. Go to setup cluster dir

2. run below command

python3.5 transform/delete.py

3. check namespaces org1/orgorderer1 deleted

4. Remove all certificates & production data

sh removeCerts.sh

5. Remove databases from couch

sh clearCouchdata.sh


### Tear Up network

1. Go to setup cluster dir & Generete certificates
./generateALL.sh

2. Generate Fabric components
python3.5 transform/run.py

3. Copy channel artifiactes to cli 

sh updateAnchor.sh

4. Create channel(Go to cli pod and run below commands)

mv channel-artifacts/create-mychannel.sh .

sh create-mychannel.sh

Note:- Run below command with non root user

5. Go to single-org-k8s dir & run below command with non root user

sh deployAllBNA.sh

6. Test all bna deployed and ping successfully

sh ping-network.sh


