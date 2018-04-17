# Open the machine from where you want to pull or push the image

vi /etc/docker/daemon.json

    {
      "insecure-registries" : ["<host-ip>:8123"]
    }


docker login -u admin -p admin123 <host-ip>:8123