# Heketi probs

    1. Root login : vi  /etc/ssh/sshd_config change:      PermitRootLogin yes      PasswordAuthentication yes      
    2. service sshd restart passwd root (change the root password)  logout and again login using root@ip
    3. Create a volume in aws and attach it with the machine(do not mount)
    4. If this error occur “Failed to activate thin pool“ then, apt-get install thin-provisioning-tools
    5. Sometimes volume is unable to get connected with the pod even though everything is fine, in this scenario change the name of the pvc, there might be the problem that heketi has cached the perticular pvc for some another pod that exixted before.
       After changing the name of the pvc everything worked fine.
