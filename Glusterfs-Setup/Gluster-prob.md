# If peers not able to get removed

rm -f /var/lib/glusterd/peers/*

systemctl restart glusterd
OR
sudo service glusterfs-server restart

gluster peer  status
Number of Peers: 0