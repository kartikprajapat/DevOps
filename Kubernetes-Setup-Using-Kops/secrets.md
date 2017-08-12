# To change the SSH public key on an existing cluster:

kops delete secret --name <clustername> sshpublickey admin

kops create secret --name <clustername> sshpublickey admin -i ~/.ssh/newkey.pub

kops update cluster --yes to reconfigure the auto-scaling groups

kops rolling-update cluster --name <clustername> --yes to immediately roll all the machines so they have the new key (optional)
