#!/bin/bash

#kubectl get nodes
#kubectl get nodes | awk '$2=="NotReady" {print ""$2}'
kubectl get nodes | awk '$2=="NotReady" {print ""$1}'
touch hello
kubectl get nodes | awk '$2=="NotReady" {print ""$1}' > hello
sed -i 's/ip-//g' hello
sed -i 's/-/./g' hello