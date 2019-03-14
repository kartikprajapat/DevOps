rm -rf channel-artifacts/ crypto-config/ 
cd  /opt/share/
find . ! -name 'efs*' -type d -exec rm -rf {} +
find . ! -name 'efs*' -type f -exec rm -rf {} +
