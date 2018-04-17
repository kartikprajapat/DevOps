# Make a directory
mkdir -p /some/dir/nexus3/data

# Change the owner
chown -R 200 /some/dir/nexus3/data

# move to the direcory
cd /some/dir/nexus3/

# Make a docker-compose file
vi docker-compose.yml
(This file is availible in bitbucket)

# Install docker compose
apt install docker-compose

# Start the docker compose
docker-compose up -d

# See if nexus container is up or not
docker ps | grep nexus

# Open dashboard

Open the URL [Docker host IP address]:8081 in a web browser

Sign in to Nexus 3

Click the Sign In button in the upper right corner and use the username “admin” and the password “admin123”. If these credentials have changed, please check the Nexus 3 Docker image page in DockerHub.

Click the cogwheel to go to the server administration and configuration section

Click Repositories

Click the Create repository button

In the list of repository types, select “docker (hosted)” as the type of the new registry

Configure the Docker repository

Give the repository a name – in my case it is “IvansDockerRepo”

Make sure that the Online checkbox is checked

Check the HTTP checkbox under Repository Connectors and enter the port number 8123.

Check the Enable Docker V1 API checkbox.

Select default under Blob store.

Click the button Create repository.



# The private Docker registry is now ready to be used.



