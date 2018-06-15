# Create a new user named 'cephuser' on all nodes.

useradd -d /home/cephuser -m cephuser
passwd cephuser

# Run the command below on all the nodes to create a sudoers file for the user and edit the /etc/sudoers file with sed.

echo "cephuser ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/cephuser
chmod 0440 /etc/sudoers.d/cephuser
sed -i s'/Defaults requiretty/#Defaults requiretty'/g /etc/sudoers

# Install and Configure NTP

Install NTP to synchronize date and time on all nodes

yum install -y ntp ntpdate ntp-doc
ntpdate 0.us.pool.ntp.org
hwclock --systohc
systemctl enable ntpd.service
systemctl start ntpd.service


# Disable SELinux

sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

# Configure Hosts File on all the nodes

vim /etc/hosts
10.0.15.10        ceph-admin
10.0.15.11        mon1
10.0.15.21        osd1
10.0.15.22        osd2
10.0.15.23        osd3
10.0.15.15        client

Note: REPLACE IPs WITH YOUR NODE IPs


telnet mon1 22

# Change the hostname of mon1 machine

ssh mon1

hostname mon1

logout
ssh mon1

check the hostname
# Configure the SSH Server

su - cephuser

# Generate the ssh keys for 'cephuser'.

ssh-keygen

# Next, create the configuration file for the ssh configuration.

vim ~/.ssh/config

Host ceph-admin
        Hostname ceph-admin
        User cephuser
 
Host mon1
        Hostname mon1
        User cephuser
 
Host osd1
        Hostname osd1
        User cephuser
 
Host osd2
        Hostname osd2
        User cephuser
 
Host osd3
        Hostname osd3
        User cephuser
 
Host client
        Hostname client
        User cephuser
        
        
# Change the permission of the config file.

chmod 644 ~/.ssh/config


# Change PasswordAuthentication to yes on all the nodes
vi /etc/ssh/sshd_config

Change
PasswordAuthentication yes

# Now add the SSH key to all nodes with the ssh-copy-id command.

ssh-keyscan osd1 osd2 osd3 mon1 client >> ~/.ssh/known_hosts
ssh-copy-id osd1
ssh-copy-id osd2
ssh-copy-id osd3
ssh-copy-id mon1
ssh-copy-id client


# Configure the Ceph OSD Nodes

Create EBS and attach them to all the OSD nodes

ssh osd1
sudo fdisk -l /dev/xvdf   (or any other name with which EBS is attached)

sudo parted -s /dev/xvdf mklabel gpt mkpart primary xfs 0% 100%
sudo mkfs.xfs /dev/xvdf -f

sudo blkid -o value -s TYPE /dev/xvdf



# Build the Ceph Cluster
Goto the ceph-admin

su - cephuser

# Install ceph-deploy on the ceph-admin node

sudo rpm -Uhv http://download.ceph.com/rpm-jewel/el7/noarch/ceph-release-1-1.el7.noarch.rpm
sudo yum update -y && sudo yum install ceph-deploy -y

# Create New Cluster Config

mkdir cluster
cd cluster/

ceph-deploy new mon1


vim ceph.conf

# Your network address
public network = 10.0.15.0/24
osd pool default size = 2


# Install Ceph on All Nodes

ceph-deploy install ceph-admin mon1 osd1 osd2 osd3

ceph-deploy mon create-initial
Note: if it doesnt work then run,
ceph-deploy --overwrite-conf  mon create-initial

ceph-deploy gatherkeys mon1

ceph-deploy disk list osd1 osd2 osd3

ceph-deploy disk zap osd1:/dev/xvdf osd2:/dev/xvdf osd3:/dev/xvdf

ceph-deploy osd prepare osd1:/dev/xvdf osd2:/dev/xvdf osd3:/dev/xvdf

ceph-deploy osd activate osd1:/dev/xvdf1 osd2:/dev/xvdf1 osd3:/dev/xvdf1

ceph-deploy disk list osd1 osd2 osd3

ssh osd1

sudo fdisk -l /dev/sdb

ceph-deploy admin ceph-admin mon1 osd1 osd2 osd3

Run Below on all the nodes
sudo chmod 644 /etc/ceph/ceph.client.admin.keyring


# Testing the Ceph setup

ssh mon1

sudo ceph health

sudo ceph -s



