# Enable ssh-add command
eval `ssh-agent -s`

# Now run
ssh-add

# Add the key
ssh-add ~/.ssh/key
#Here key can be id_rsa or something else depends upon the name we had given previously.

# To varify that whether the ssh is enabled or not
ssh-add -l

# ssh to the master
ssh admin@<ip of master>

or 

ssh -i /root/.ssh/id_rsa ubuntu@<ip of master or node>

# Imp link
https://stackoverflow.com/questions/17846529/could-not-open-a-connection-to-your-authentication-agent