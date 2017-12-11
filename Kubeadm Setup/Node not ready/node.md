# The first case came was "kubelet was stopped"

In this case login to the node and restart the kubelet "service kubelet restart"

# The second case was node name set to default when restarted to apply the updates like increasing memory, increasing ram, etc.

In this case delete the node from master by "kubectl delete node node-name", and then login to the node and fire below commands:

    kubeadm reset
    kubeadm join --token $token --node-name=name of the node $master-ip:6443