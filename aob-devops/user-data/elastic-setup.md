# Check java version:

    java --version
    
# Install commnon props:
    
    sudo apt-get install -y software-properties-common
    
    sudo add-apt-repository -y ppa:webupd8team/java
    
    sudo apt-get update
    
    sudo apt-get install -y oracle-java8-installer
    
# Install Elasticsearch

    java -version
    
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
    
    sudo apt-get install -y apt-transport-https
    
    echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
    
    sudo apt-get update && sudo apt-get install -y elasticsearch
    
    sudo /bin/systemctl daemon-reload
    
    sudo /bin/systemctl enable elasticsearch.service
    
    sudo systemctl start elasticsearch.service
    
    sudo systemctl status elasticsearch.service
    
# Change the configuration of elasticsearch.yml
    
    vi /etc/elasticsearch/elasticsearch.yml 
    
    sudo systemctl restart elasticsearch.service
    
    vi /etc/elasticsearch/elasticsearch.yml
    
    sudo systemctl restart elasticsearch.service
    
    telnet localhost 9200
    
