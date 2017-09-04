# Install kops and kubectl latest version

apt-get upgrade kops

kops version

# Create a s3 bucket



# Set the environment variables for aws and s3 bucket



# Demo cluster

kops create cluster cluster.k8s.local --zones us-east-1a --yes

# Here the cluster name must end with .k8s.local otherwise the cluster will not follow the above approach.