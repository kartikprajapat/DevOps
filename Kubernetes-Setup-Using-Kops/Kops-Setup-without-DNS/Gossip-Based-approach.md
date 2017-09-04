# Install kops and kubectl latest version

apt-get upgrade kops

kops version

# Create a s3 bucket



# Set the environment variables for aws and s3 bucket











# Demo cluster
kops create cluster depositinternal.com --node-count 2 --zones us-east-1a,us-east-1b --master-zones us-east-1a --dns-zone depositinternal.com --dns private --topology private --networking weave --vpc=vpc-60740319

kops edit cluster depositinternal.com

kops edit ig --name=depositinternal.com nodes

kops update cluster depositinternal.com

kops update cluster depositinternal.com --yes

kubectl get nodes