# Get the Binaties of Helm

curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh

# Give permissions to the sh file

chmod 700 get_helm.sh

# Run the sh file, after running below the Helm will we downloaded 

./get_helm.sh

# Initialize the helm

helm init

helm version

helm init --canary-image

# Install the chaos-Kube Image using Helm

helm install stable/chaoskube

helm install --name my-release stable/chaoskube

helm install stable/chaoskube --set dryRun=false


# See the chaos kube pods are in runnig state or not

kubectl get pods --namespace kube-system

