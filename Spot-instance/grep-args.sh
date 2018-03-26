#!/bin/bash
while IFS='' read -r line || [[ -n "$line" ]]; do
   # echo "Text read from file: $line"
    aws ec2 describe-instances --filters "Name=network-interface.addresses.private-ip-address,Values=$line" > $line
    diff $line compare > compare-result-$line
    export VAR=compare-result-$line
    echo $line > hello-again
   # cat hello-again
    sed -i 's/^/ip-/g' hello-again
    sed -i "s/\./-/g" hello-again
   # cat hello-again
    my_var=$(cat hello-again)
    echo $my_var
    if [[ -s $VAR ]]; then echo "Node is not in TERMINATED state"; else kubectl delete node $my_var; fi
    rm $line compare-result-$line
done < "$1"