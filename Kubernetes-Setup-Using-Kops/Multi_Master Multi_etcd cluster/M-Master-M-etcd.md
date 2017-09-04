kops create cluster dxp-demo.k8s.local --zones us-east-1a,us-east-1b,us-east-1d --vpc vpc-4b946b32 --master-zones us-east-1a,us-east-1b,us-east-1d --node-size t2.medium --master-size t2.medium --networking weave

# Here the main things are:

  # 1) We can not create the even number of masters
  
  # 2) If we want to create the multi-master cluster than we need to specify the same zones to the worker nodes and later in the ig-nodes file we can decrease or increase the number of nodes.
  
# If we do not follow the step 2) then "master-zone "us-east-1d" not included in zones" kind of error will come.


# The reason for creation of 3 masters not 2 is because of the etcd cluster's nature, etcd requires atleast 51% of the master cluster to be up and if one goes down in 2 then the single one will become 50% which i sless than 51%. 

------------------------zones us-east-1a,us-east-1b,us-east-1d         &             --master-zones us-east-1a,us-east-1b,us-east-1d                 must be same------------------------------------------