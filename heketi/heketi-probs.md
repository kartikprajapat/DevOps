# Heketi probs

    1. Root login : vi  /etc/ssh/sshd_config change:      PermitRootLogin yes      PasswordAuthentication yes      
    2. service sshd restart passwd root (change the root password)  logout and again login using root@ip
    3. Create a volume in aws and attach it with the machine(do not mount)
    4. If this error occur “Failed to activate thin pool“ then, apt-get install thin-provisioning-tools
    


