# where the cluster is called "foo.example.com"
export KUBECONFIG=~/.kube/foo.example.com
kops export kubecfg --name foo.example.com --config=~$KUBECONFIG
