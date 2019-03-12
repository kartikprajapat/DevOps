# Install Helm

cd /tmp
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > install-helm.sh
chmod u+x install-helm.sh
./install-helm.sh

# Install Tiller

kubectl -n kube-system create serviceaccount tiller
kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller

# Clone Bitbucket repo of fabric-kafka

git clone https://github.com/aidtechnology/hgf-k8s-workshop.git

helm install stable/nginx-ingress -n nginx-ingress --namespace ingress-controller

kubectl apply \
    -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.6/deploy/manifests/00-crds.yaml
    
helm install stable/cert-manager -n cert-manager --namespace cert-manager


kubectl create -f ./extra/certManagerCI_staging.yaml

kubectl create -f ./extra/certManagerCI_production.yaml

DOMAIN NAME CHANGE

kubectl create ns cas 
kubectl create ns peers
kubectl create ns orderers

helm install stable/hlf-ca -n ca --namespace cas -f ./helm_values/ca.yaml

CA_POD=$(kubectl get pods -n cas -l "app=hlf-ca,release=ca" -o jsonpath="{.items[0].metadata.name}")

kubectl logs -n cas $CA_POD | grep "Listening on"


kubectl exec -n cas $CA_POD -- cat /var/hyperledger/fabric-ca/msp/signcerts/cert.pem


kubectl exec -n cas $CA_POD -- bash -c 'fabric-ca-client enroll -d -u http://$CA_ADMIN:$CA_PASSWORD@$SERVICE_DNS:7054'


