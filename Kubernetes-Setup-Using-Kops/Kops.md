# Kubernetes setup using Kops


# Install "kops" on Linux
curl -LO https://github.com/kubernetes/kops/releases/download/1.5.3/kops-linux-amd64

chmod +x kops-linux-amd64

mv kops-linux-amd64 /usr/local/bin/kops


# Install and configure the AWS CLI on Linux     
sudo apt-get install awscli

aws configure

(Now we need to have the AccessKeyId and SecretKeyAccess of the AWS Iam Account)

# Create the env vars to save the AWS credentials on the machine
export AWS_ACCESS_KEY_ID=<ID>

export AWS_SECRET_ACCESS_KEY=<AccessKey>

# Create and then list a new S3 bucket
aws s3 mb s3://<s3-bucket-name>

aws s3 ls | grep k8s

export KOPS_STATE_STORE=s3://<s3-bucket-name>


# Generate the public key of the machine through which we need to access the cluster
ssh-keygen -t rsa

(save the key as the name "key" or we can choose our own name(I recommend to leave the default location to save the key which is /root/.ssh/key.pub))

sudo nano /etc/ssh/sshd_config

	RSAAuthentication yes
    
	PubkeyAuthentication yes 
    
	PasswordAuthentication no


# Now create the secret for kops to tell it that "key.pub" is the public key which it needs to have
kops create secret --name <name of the cluster or the DNS name> sshpublickey admin -i ~/.ssh/key.pub



# Now create the cluster
kops create cluster --zones=<zone-name> <cluster name or DNS name>


# Check the cluster info before the final step
kops edit cluster <name-of-the-cluster>


# Final step
kops update cluster <cluster-name> --yes


# Check the cluster info
kubectl cluster-info


# Create the dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/kops/master/addons/kubernetes-dashboard/v1.6.1.yaml

# Setup Heapster
kubectl create -f https://raw.githubusercontent.com/kubernetes/kops/master/addons/monitoring-standalone/v1.6.0.yaml
vi heapster-rbac.yaml

	# PASTE THE FOLLOWING CONTENT:
    
    apiVersion: rbac.authorization.k8s.io/v1beta1
    kind: ClusterRoleBinding
    metadata:
    name: kubernetes-dashboard
    labels:
    k8s-app: kubernetes-dashboard
    roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: cluster-admin
    subjects:
    - kind: ServiceAccount
    name: kubernetes-dashboard
    namespace: kube-system

kubectl apply -f heapster-rbac.yaml




# The most important thing in this setup is to create the DNS name so do it carefully

These are the few steps that I followed during creation of the DNS name:

1.Take a DNS name from the third party like Godaddy

2.Make the entries of the AWS nameservers(NS) with that DNS name

3.enable route53 access for that DNS

4.In that route53 setup we have to specify the public ip of the machine which provides us the proxy to access the internet on the master and slaves of kubernetes that are under private subdomain.


# I found the below links very useful to setup the kops

http://kubecloud.io/setup-ha-k8s-kops/

https://kubernetes.io/docs/getting-started-guides/kops/

# If we have made some changes in the cluster then we need to update it
kops rolling-update cluster <cluster-name>

  After varifying:
  kops rolling-update cluster <cluster-name> --yes