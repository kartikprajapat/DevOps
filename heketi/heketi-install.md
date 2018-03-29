# Install heketi binaries
wget https://github.com/heketi/heketi/releases/download/v4.0.0/heketi-v4.0.0.linux.amd64.tar.gz
tar xzvf heketi-v4.0.0.linux.amd64.tar.gz
cd heketi
cp heketi heketi-cli /usr/local/bin/
heketi -v

groupadd -r -g 515 heketi
useradd -r -c "Heketi user" -d /var/lib/heketi -s /bin/false -m -u 515 -g heketi heketi
mkdir -p /var/lib/heketi && chown -R heketi:heketi /var/lib/heketi
mkdir -p /var/log/heketi && chown -R heketi:heketi /var/log/heketi
mkdir -p /etc/heketi

# Generate a key for heketi
ssh-keygen -f /etc/heketi/heketi_key -t rsa -N ''
chown heketi:heketi /etc/heketi/heketi_key*

# On every machine do some configuration changes
vi /etc/ssh/sshd_config
    PermitRootLogin yes
    PasswordAuthentication yes
passwd root
    change the root password
service sshd restart
    logot and login again

# Create a raw disk and attach to the machines because heketi only works with raw disk (In AWS we can attach an EBS to the machine)
1. Open AWS console
2. Click on volumes
3. Create an new vol
4. Add the macihne's id and size of raw disk
5. Run lsblk to check the raw disk

Output would be like

    NAME                                                                              MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
    xvda                                                                              202:0    0  20G  0 disk 
    `-xvda1                                                                           202:1    0  20G  0 part /
    xvdf                                                                              202:80   0  20G  0 disk 


# Copy that key to other machines
ssh-copy-id -i /etc/heketi/heketi_key.pub root@<machine-ip>

# Verify the ssh is working with root or not
ssh -i /etc/heketi/heketi_key root@<IP-1>
ssh -i /etc/heketi/heketi_key root@<IP-2>
ssh -i /etc/heketi/heketi_key root@<IP-3>


# Now make some files on the machine on which we are installing heketi

vi /etc/heketi/heketi.json
    (file is in bitbucket with the same name)

vi /etc/systemd/system/heketi.service
    (file is in bitbucket with the same name)

# Start heketi

systemctl daemon-reload
systemctl start heketi.service
journalctl -xe -u heketi

# Enable heketi accross restarts

systemctl enable heketi

# Run below command on heketi mahchine

curl http://localhost:8080/hello
    OR
curl http://<heketi-machine-hostname>:8080/hello
    Desired output: Hello from Heketi
    
# Run below command on other nodes

curl http://<heketi-machine-hostname>:8080/hello

# List the clusters

heketi-cli --server http://glustera:8080 --user admin --secret "PASSWORD" cluster list

# Tell the machines about the hosts

host <hostname-1>
glustera.tftest.encompasshost.internal has address <ip>

host <hostname-2>
glusterb.tftest.encompasshost.internal has address <ip>

host <hostname-3>
glusterc.tftest.encompasshost.internal has address <ip>

# Create topology file for heketi

vi /etc/heketi/topology.json
    (file is in bitbucket with the same name)

# Set environment variables on heketi machine

export HEKETI_CLI_SERVER=http://<HeketiMachineHostname>:8080
export HEKETI_CLI_USER=admin
export HEKETI_CLI_KEY=PASSWORD

# Load json to heketi

heketi-cli topology load --json=/etc/heketi/topology.json

    Desired output: Found node glustera.tftest.encompasshost.internal on cluster 37cc609c4ff862bfa69017747ea4aba4
        Adding device /dev/xvdf ... OK
    Found node glusterb.tftest.encompasshost.internal on cluster 37cc609c4ff862bfa69017747ea4aba4
        Adding device /dev/xvdf ... OK
    Found node glusterc.tftest.encompasshost.internal on cluster 37cc609c4ff862bfa69017747ea4aba4
        Adding device /dev/xvdf ... OK
        
# List the cluster

heketi-cli cluster list

heketi-cli node list

# Create a volume using heketi

heketi-cli volume create --size=1

heketi-cli volume list

