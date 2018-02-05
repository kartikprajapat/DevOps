# Run the below command 

apt-cache policy kubeadm

This will show the specific versions and we can select the version and then download the kubeadm, for e.x.

    apt-get install kubeadm=1.7.0-00
    
    eg : apt-get install -y kubelet=1.7.5-00 kubeadm=1.7.5-00 kubectl=1.7.5-00 kubernetes-cni
    
This will download the 1.7.0 version of kubeadm.


If we want to download the specific version of the other components then we just need to change the name in the first command from kubeadm to other component.