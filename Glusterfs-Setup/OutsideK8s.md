# We have to make servers and clients

# Servers---- Run below commands on the server machines

sudo apt-get install -y software-properties-common

sudo add-apt-repository ppa:gluster/glusterfs-3.8

sudo apt-get update

sudo apt-get install -y glusterfs-server

sudo service glusterfs-server start

sudo service glusterfs-server status

sudo gluster peer probe 10.4.100.23

sudo gluster peer status

sudo gluster pool list

mkdir -p /data/gluster/gvol0

gluster volume create gvol0 replica 2 10.4.100.45:/data/gluster/gvol0 10.4.100.23:/data/gluster/gvol0 force

sudo gluster volume start gvol0

sudo gluster volume info gvol0

cd /data/gluster/gvol0

# Client

apt-get install -y glusterfs-client

mkdir -p /mnt/glusterfs

mount -t glusterfs 10.4.100.23:/gvol0 /mnt/glusterfs

df -hP /mnt/glusterfs

cat /proc/mounts

touch /mnt/glusterfs/file1

touch /mnt/glusterfs/file2

ll /mnt/glusterfs/

vi /mnt/glusterfs/file1

vi /mnt/glusterfs/file2


<https://www.itzgeek.com/how-tos/linux/ubuntu-how-tos/install-and-configure-glusterfs-on-ubuntu-16-04-debian-8.html>