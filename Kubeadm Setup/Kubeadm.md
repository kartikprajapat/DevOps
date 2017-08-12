apt-get update && apt-get install -y apt-transport-https

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat <<EOF >/etc/apt/sources.list.d/kubernetes.list

deb http://apt.kubernetes.io/ kubernetes-xenial main

EOF

apt-get update

apt-get install -y docker.io kubeadm kubectl kubelet kubernetes-cni

kubeadm init


sudo cp /etc/kubernetes/admin.conf $HOME/

sudo chown $(id -u):$(id -g) $HOME/

export KUBECONFIG=$HOME/admin.conf


kubectl get nodes

kubectl get pods --all-namespaces

kubectl apply --filename https://git.io/weave-kube-1.6

kubectl get nodes

kubectl get pods --all-namespaces

kubectl get nodes

For making master a node:

kubectl taint nodes --all node-role.kubernetes.io/master-

For dashboard:

kubectl create -f https://git.io/kube-dashboard

kubectl proxy --address ip --port=80 --accept-hosts='^*$' &

run ip/ui on browser
