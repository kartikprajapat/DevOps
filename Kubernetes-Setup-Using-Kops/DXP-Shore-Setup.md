curl -LO https://github.com/kubernetes/kops/releases/download/1.6.2/kops-linux-amd64                  
chmod +x kops-linux-amd64          
mv kops-linux-amd64 /usr/local/bin/kops       
sudo apt-get install awscli
aws configure
export AWS_ACCESS_KEY_ID=AKIAJO5CLZFJMVT43TQA
export AWS_SECRET_ACCESS_KEY=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
aws s3 mb s3://dxp-shore.k8s
aws s3 ls | grep k8s
export KOPS_STATE_STORE=s3://dxp-shore.k8s
ssh-keygen -t rsa
sudo nano /etc/ssh/sshd_config
    RSAAuthentication yes    
    PasswordAuthentication no
    PubkeyAuthentication yes

kops create cluster dxp-shore.k8s.local --zones=us-east-1a --node-size=r4.xlarge --master-size=t2.xlarge --vpc=vpc-b558bacd --networking weave
kops edit cluster dxp-shore.k8s.local
kops edit ig --name=dxp-shore.k8s.local nodes
    image: 099720109477/ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-20160830
    machineType: r4.xlarge
kops edit ig --name=dxp-shore.k8s.local master-us-east-1a
    image: 099720109477/ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-20160830
    machineType: r4.xlarge
kops update cluster dxp-shore.k8s.local
kops update cluster dxp-shore.k8s.local --yes
watch kops validate cluster
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl get nodes
kubectl run kubernetes-dashboard --port 80 --image gcr.io/google_containers/kubernetes-dashboard-amd64:v1.6.3 --namespace=kube-system
kubectl expose deployment kubernetes-dashboard --port 9090 --namespace=kube-system
kubectl cluster-info
kubectl config view







# ubuntu base image on master and nodes to install os
image: 099720109477/ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-20160830



