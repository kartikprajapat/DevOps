# Here is the demo command through which we can create the secret so that kops cluster can be connected to the docker jfrog artifactory:
 
 kubectl create secret docker-registry myregistrykey --docker-server=https://dxp-docker.jfrog.io/dxp --docker-username=admin --docker-password=0k4mgt96Jf --docker-email=aatif.maqsood@decurtis.com
 
 
 
 # Detailed description: 
  
 https://kubernetes.io/docs/concepts/containers/images/#configuring-nodes-to-authenticate-to-a-private-repository