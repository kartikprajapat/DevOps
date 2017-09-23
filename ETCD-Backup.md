

# Exclude the namespaces like we have excluded kube-system, kube-public and default namespaces

kubectl get --export -o=json ns | jq '.items[] |
select(.metadata.name!="kube-system") |
select(.metadata.name!="default") | select(.metadata.name!="kube-public") |
del(.status,
        .metadata.uid,
        .metadata.selfLink,
        .metadata.resourceVersion,
        .metadata.creationTimestamp,
        .metadata.generation
)' > /home/dxp/ns.json


# Run this command to move the contents


 for ns in $(jq -r '.metadata.name' < /home/dxp/ns.json);do     echo "Namespace: $ns";     kubectl --namespace="${ns}" get --export -o=json svc,rc,secrets,ds,deployments,rs |     jq '.items[] |
        select(.type!="kubernetes.io/service-account-token") |
        del(
            .spec.clusterIP,
            .metadata.uid,
            .metadata.selfLink,
            .metadata.resourceVersion,
            .metadata.creationTimestamp,
            .metadata.generation,
            .status,
            .spec.template.spec.securityContext,
            .spec.template.spec.dnsPolicy,
            .spec.template.spec.terminationGracePeriodSeconds,
            .spec.template.spec.restartPolicy
        )' >> "/home/dxp/cluster-dump.json"; done
        
        
# Now copy both the above jsons to the target machine


scp cluster-dump.json ns.json dxp@<remote ip>:/home/ubuntu/


# Now login to the remote machine


# Run below command on the remote machine


kubectl create -f cluster-dump.json -f ns.json



# Maze karo