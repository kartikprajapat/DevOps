				Kubernetes Cluster  Setup using kubeadm

Configuration – Ubuntu 16.04

Change hostname in ubuntu 16.04 (http://ubuntuhandbook.org/index.php/2016/06/change-hostname-ubuntu-16-04-without-restart/)

1. sudo hostname NEW_NAME_HERE
2. vi /etc/hostname
	NEW_NAME_HERE
3. vi /etc/hosts
	127.0.0.1 NEW_NAME_HERE
4. systemctl restart systemd-logind.service


Add new user in machine

1. adduser user_name
	enter password for new user and remain other details as default
2. vi /etc/sudoers.d/90-*
	create new entry for new user with all permissions


Permit a user to login as a root user

1. sudo visudo
	user_name ALL=(ALL) NOPASSWD: ALL
	eg: sudhir ALL=(ALL) NOPASSWD: ALL
2. vi /etc/ssh/sshd_config
	PermitRootLogin yes
3. service ssh restart


Install latest docker version

1. create a script to install docker
	vi docker-install-script.sh
2. paste and save below line in this file
#!/bin/bash
# My docker script
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
apt-cache policy docker-ce
sudo apt-get install -y docker-ce

3. Run this script
 	./docker-install-script.sh
4. verify docker version
	docker -v




K8S cluster setup

Master

1) sudo su
2) apt-get update && apt-get install -y apt-transport-https
3) curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
4) cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
5) apt-get update

// Optional if docker not installed
6) apt-get install -y docker-engine

7) apt-get install -y kubelet kubeadm kubectl kubernetes-cni
8) kubeadm init

it will generate a token coomand to join nodes paste this command on nodes after install kubernetes

Nodes

1) sudo su
2) apt-get update && apt-get install -y apt-transport-https
3) curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
4) cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
5) apt-get update

// Optional if docker not installed
6) apt-get install -y docker-engine
7) apt-get install -y kubelet kubeadm kubectl kubernetes-cni

// This will be generated from master
8) kubeadm join --token token_master_ip: 6443

// Install weave network addon on master to allow communication between nodes and ready
(https://kubernetes.io/docs/concepts/cluster-administration/addons/)

kubectl apply -f https://git.io/weave-kube-1.6

// Install kubernetes dashboard(https://github.com/kubernetes/dashboard#kubernetes-dashboard)

kubectl create -f https://git.io/kube-dashboard


// Check latest token on master

1. sudo su 
2. kubeadm token list

// How to add insecure registry in ubuntu(16.04)
(https://stackoverflow.com/questions/40924931/trouble-running-docker-registry-in-insecure-mode-on-ubuntu-16-04)



1) Create or modify /etc/docker/daemon.json add below line
    { "insecure-registries":["docker_registry_server_ip:5000"] }
2) Restart docker daemon
    sudo service docker restart

// how to open dashboard with self link

kubectl proxy --address host_ip --port=80 --accept-hosts='^*$ &

kubectl proxy --address host_ip --port=8080 --accept-hosts='^*$ &


Error : sudo: no tty present and no askpass program specified' error?
sol : 
https://stackoverflow.com/questions/21659637/how-to-fix-sudo-no-tty-present-and-no-askpass-program-specified-error

Error : Unable to connect to the server: x509: certificate signed by unknown authority (possibly because of "crypto/rsa: verification error" while trying to verify candidate authority certificate "kubernetes")
sol: admin.conf in $HOME folder must be updated(delete and copy new) and copied from /etc/kubernetes/admin.conf

Error : The connection to the server localhost:8080 was refused - did you specify the right host or port?
Sol : 
cp /etc/kubernetes/admin.conf $HOME/
chown $(id -u):$(id -g) $HOME/admin.conf && chmod 777 $HOME/admin.conf
export KUBECONFIG=$HOME/admin.conf


// ELK Install

Install Java 8 before ELK install(http://tipsonubuntu.com/2016/07/31/install-oracle-java-8-9-ubuntu-16-04-linux-mint-18/)

1. sudo add-apt-repository ppa:webupd8team/java
2. sudo apt update
3. sudo apt install oracle-java8-installer

4. java -version
5. sudo apt install oracle-java8-set-default


Elasticsearch(https://www.elastic.co/guide/en/elasticsearch/reference/5.3/deb.html)

1. wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.3.3.deb
2. sudo dpkg -i elasticsearch-5.3.3.deb
3. vi /etc/elasticsearch/elasticsearch.yml
     network.host: Elasticsearch_server_ip
3. update-rc.d elasticsearch defaults 95 10
4. service elasticsearch start


Logstash

1. vi Dockerfile
	FROM logstash:5.3.2
	COPY logstash.conf /home/administrator/
	CMD ["-f", "/home/administrator/logstash.conf"]
2. vi logstash.conf
input {
  beats {
    port => 5044
    type => "log"   	
  }
  #kafka {
    #bootstrap_servers => "kafka-url"
    #topics => ["kafka-topic"]
  #}
}
filter {

 if "webapp-log" in [tags]  
 {
   json {
     	source => "message"
     }

  mutate {
       remove_field => ["[beat][hostname]","host","hostname","msg","input_type","level","name","pid","[src][file]","[src][func]","[src][line]","time","v","n","t","l","m"]
    }

 }
 else if "tomcat-log" in [tags]
  {
   json {
	source => "message"
     }
    mutate {
       remove_field => ["[beat][hostname]","[beat][name]","[beat][version]","host"]
    }
  }

 else
 {
    json {
	source => "message"
	target => "parsedmain"
     }

    json {
        source => ["[parsedmain][payload][content]"]
        target => "parsedcontent"
        add_tag => [ "mobileapp-log" ]
     }

    mutate {
          remove_field => ["[parsedmain][payload][bySeqno]","[parsedmain][payload][cas]","[parsedmain][payload][content]","[parsedmain][payload][event]","[parsedmain][payload][expiration]","[parsedmain][payload][flags]","[parsedmain][payload][key]","[parsedmain][payload][lockTime]","[parsedmain][payload][partition]","[parsedmain][payload][revSeqno]","[parsedmain][schema][fields]","[parsedmain][schema][name]","[parsedmain][schema][optional]","[parsedmain][schema][type]","[parsedcontent][_sync][history][channels]","[parsedcontent][_sync][history][parents]","[parsedcontent][_sync][history][revs]","[parsedcontent][_sync][recent_sequences]","[parsedcontent][_sync][rev]","[parsedcontent][_sync][sequence]","[parsedcontent][_sync][time_saved]","[parsedcontent][userinfo][token]","[parsedcontent][created_at]","[parsedcontent][_rev]","[parsedcontent][lastSequence]"]
     }

    mutate {
         rename => { "[parsedcontent][componentName]" => "componentName" }
         rename => { "[parsedcontent][componentVersion]" => "componentVersion" }
         rename => { "[parsedcontent][corelationId]" => "corelationId" }
         rename => { "[parsedcontent][hostname]" => "hostName" }
         rename => { "[parsedcontent][message]" => "message" }
         rename => { "[parsedcontent][messageCode]" => "messageCode" }
         rename => { "[parsedcontent][messageDetail]" => "messageDetail" }
         rename => { "[parsedcontent][severity]" => "severity" }
         rename => { "[parsedcontent][stacktrace]" => "stacktrace" }
         rename => { "[parsedcontent][timestamp]" => "timestamp" }
         rename => { "[parsedcontent][type]" => "type" }
         rename => { "[parsedcontent][deviceInfo][id]" => "[deviceInfo][id]" }
         rename => { "[parsedcontent][deviceInfo][name]" => "[deviceInfo][name]" }
         rename => { "[parsedcontent][deviceInfo][operatingSystem]" => "[deviceInfo][operatingSystem]" }
         rename => { "[parsedcontent][deviceInfo][osVersion]" => "[deviceInfo][osVersion]" }
         rename => { "[parsedcontent][deviceInfo][type]" => "[deviceInfo][type]" }
         rename => { "[parsedcontent][traceInfo][loggingPoint]" => "[traceInfo][loggingPoint]" }
         rename => { "[parsedcontent][traceInfo][duration]" => "[traceInfo][duration]" }
         rename => { "[parsedcontent][traceInfo][methodTime]" => "[traceInfo][methodTime]" }
         rename => { "[parsedcontent][traceInfo][callerInfo][class]" => "[traceInfo][callerInfo][class]" }
         rename => { "[parsedcontent][traceInfo][callerInfo][name]" => "[traceInfo][callerInfo][name]" }
         rename => { "[parsedcontent][traceInfo][callerInfo][method]" => "[traceInfo][callerInfo][method]" }
         rename => { "[parsedcontent][traceInfo][sourceInfo][class]" => "[traceInfo][sourceInfo][class]" }
         rename => { "[parsedcontent][traceInfo][sourceInfo][method]" => "[traceInfo][sourceInfo][method]" }
         rename => { "[parsedcontent][traceInfo][methodTime]" => "[traceInfo][methodTime]" }
         rename => { "[parsedcontent][userInfo][id]" => "[userInfo][id]" }
         rename => { "[parsedcontent][userInfo][deviceId]" => "[userInfo][deviceId]" } 
         rename => { "[parsedcontent][userInfo][appId]" => "[userInfo][appId]" }
         rename => { "[parsedcontent][userInfo][type]" => "[userInfo][type]" }
         rename => { "[parsedcontent][offset]" => "dateOffset" }
      }
   }
}

output {
  if "tomcat-log" in [tags]
  {
    elasticsearch {
       hosts => "elasticsearch-url"
       manage_template => false
       index => "webserverlog-%{+YYYY.MM.dd}"
       document_type => "%{[@metadata][type]}"
   }
  }
  else
  {
    elasticsearch {
       hosts => "elasticsearch-url"
       manage_template => false
       index => "applog-%{+YYYY.MM.dd}"
       document_type => "%{[@metadata][type]}"
   }
  }
}


3.  docker build -t logstash .
4. vi logstash.yml
	https://bitbucket.org/decurtis/dxp-docker-component/src/599afb6f790f/monitoring/logstash/?at=master

5. vi log4j2.properties
	https://bitbucket.org/decurtis/dxp-docker-component/src/599afb6f790f/monitoring/logstash/?at=master

6. docker run -d -p 5044:5044 -v /var/log/logstash:/var/log/logstash -v /home/dxp/monitoring/logstash/logstash.conf:/home/administrator/logstash.conf -v /home/dxp/monitoring/logstash/logstash.yml:/etc/logstash/logstash.yml -v /home/dxp/monitoring/logstash/log4j2.properties:/etc/logstash/log4j2.properties --name logstash –restart always logstash

Kibana

1. vi Dockerfile
	FROM kibana:5.3.0
	COPY kibana.yml /etc/kibana/kibana.yml
2. vi kibana.yml
	# Kibana is served by a back end server. This setting specifies the port to use.
#server.port: 5601

# Specifies the address to which the Kibana server will bind. IP addresses and host names are both valid values.
# The default is 'localhost', which usually means remote machines will not be able to connect.
# To allow connections from remote users, set this parameter to a non-loopback address.
server.host: '0.0.0.0'

# Enables you to specify a path to mount Kibana at if you are running behind a proxy. This only affects
# the URLs generated by Kibana, your proxy is expected to remove the basePath value before forwarding requests
# to Kibana. This setting cannot end in a slash.
#server.basePath: ""

# The maximum payload size in bytes for incoming server requests.
#server.maxPayloadBytes: 1048576

# The Kibana server's name.  This is used for display purposes.
#server.name: "your-hostname"

# The URL of the Elasticsearch instance to use for all your queries.
elasticsearch.url: 'http://elasticseach_ip:9200'

# When this setting's value is true Kibana uses the hostname specified in the server.host
# setting. When the value of this setting is false, Kibana uses the hostname of the host
# that connects to this Kibana instance.
#elasticsearch.preserveHost: true

# Kibana uses an index in Elasticsearch to store saved searches, visualizations and
# dashboards. Kibana creates a new index if the index doesn't already exist.
#kibana.index: ".kibana"

# The default application to load.
#kibana.defaultAppId: "discover"

# If your Elasticsearch is protected with basic authentication, these settings provide
# the username and password that the Kibana server uses to perform maintenance on the Kibana
# index at startup. Your Kibana users still need to authenticate with Elasticsearch, which
# is proxied through the Kibana server.
#elasticsearch.username: "user"
#elasticsearch.password: "pass"

# Enables SSL and paths to the PEM-format SSL certificate and SSL key files, respectively.
# These settings enable SSL for outgoing requests from the Kibana server to the browser.
#server.ssl.enabled: false
#server.ssl.certificate: /path/to/your/server.crt
#server.ssl.key: /path/to/your/server.key

# Optional settings that provide the paths to the PEM-format SSL certificate and key files.
# These files validate that your Elasticsearch backend uses the same key files.
#elasticsearch.ssl.certificate: /path/to/your/client.crt
#elasticsearch.ssl.key: /path/to/your/client.key

# Optional setting that enables you to specify a path to the PEM file for the certificate
# authority for your Elasticsearch instance.
#elasticsearch.ssl.certificateAuthorities: [ "/path/to/your/CA.pem" ]

# To disregard the validity of SSL certificates, change this setting's value to 'none'.
#elasticsearch.ssl.verificationMode: full

# Time in milliseconds to wait for Elasticsearch to respond to pings. Defaults to the value of
# the elasticsearch.requestTimeout setting.
#elasticsearch.pingTimeout: 1500

# Time in milliseconds to wait for responses from the back end or Elasticsearch. This value
# must be a positive integer.
#elasticsearch.requestTimeout: 30000

# List of Kibana client-side headers to send to Elasticsearch. To send *no* client-side
# headers, set this value to [] (an empty list).
#elasticsearch.requestHeadersWhitelist: [ authorization ]

# Header names and values that are sent to Elasticsearch. Any custom headers cannot be overwritten
# by client-side headers, regardless of the elasticsearch.requestHeadersWhitelist configuration.
#elasticsearch.customHeaders: {}

# Time in milliseconds for Elasticsearch to wait for responses from shards. Set to 0 to disable.
#elasticsearch.shardTimeout: 0

# Time in milliseconds to wait for Elasticsearch at Kibana startup before retrying.
#elasticsearch.startupTimeout: 5000

# Specifies the path where Kibana creates the process ID file.
#pid.file: /var/run/kibana.pid

# Enables you specify a file where Kibana stores log output.
#logging.dest: stdout

# Set the value of this setting to true to suppress all logging output.
#logging.silent: false

# Set the value of this setting to true to suppress all logging output other than error messages.
#logging.quiet: false

# Set the value of this setting to true to log all events, including system usage information
# and all requests.
#logging.verbose: false

# Set the interval in milliseconds to sample system and process performance
# metrics. Minimum is 100ms. Defaults to 5000.
#ops.interval: 5000

 
3. docker build -t kibana .
4. docker run -d -p 5601:5601 –restart always -v /home/dxp/monitoring/kibana/kibana.yml:/etc/kibana/kibana.yml --name kibana kibana


// Add artifactory to a machines

1. docker login virginvoyages-vxp-images.jfrog.io
2. enter username
3. enter password


// Add vxp-artifactory secret to allow pull filebeat image

kubectl create secret docker-registry vxp-artifactory --docker-server=https://virginvoyages-vxp-images.jfrog.io --docker-username=admin --docker-password=0k4mgt96Jf --docker-email=aatif.maqsood@decurtis.com --namespace=demo

Zookeeper

1. sudo apt-get install zookeeperd
2. vi /etc/zookeeper/conf/zoo.cfg 
    server.1=zookeeper1_server_ip:2888:3888
3. vi /etc/zookeeper/conf/myid
     1

Kafka

1. mkdir /home/kafka
2. wget http://www-eu.apache.org/dist/kafka/0.11.0.1/kafka_2.11-0.11.0.1.tgz
3. tar -xzf kafka_2.11-0.11.0.1.tgz
4. Create kafka.service in /etc/systemd/system
     vi /etc/systemd/system/ kafka.service
5. service kafka start
6. systemctl enable kafka.service


// kafka-running logs

/home/kafka/kafka_2.11-0.11.0.1/logs

// kafka-pid



Redis

1. docker run --name redis -p 6379:6379 -d --restart always redis:latest

Redis Commander

docker run --name redis-commander -d --env REDIS_HOSTS=<redis_host_ip>:6379 -p 8080:8081 --restart always rediscommander/redis-commander:latest

Prometheus(https://github.com/giantswarm/kubernetes-prometheus)

1 mkdir /home/dxp/prometheus
2. cd /home/dxp/prometheus
3. git clone https://github.com/giantswarm/kubernetes-prometheus.git
4. kubectl apply -f /home/dxp/prometheus/kubernetes-prometheus/manifests-all.yaml
5. kubectl --namespace monitoring delete job grafana-import-dashboards
6. kubectl apply -f /home/dxp/prometheus/kubernetes-prometheus/manifests/grafana/import-dashboards/job.yaml


Confluent(Schema-registry/Rest-proxy)

1. cd /home/kafka/
	wget http://packages.confluent.io/archive/3.3/confluent-oss-3.3.0-2.11.tar.gz
2. tar -xvf confluent-oss-3.3.0-2.11.tar.gz
3. cd confluent-3.3.0

// Schema-registry
4. vi etc/schema-registry/schema-registry.properties(Multiple Zookeeper url can be add if required otherwise remain same as)
5. vi /etc/systemd/system/schema-registry.service
[Unit]
Description=Schema-registry
After=network.target
[Service]
#User=kafka
ExecStart=/home/kafka/confluent-3.3.0/bin/schema-registry-start  /home/kafka/confluent-3.3.0/etc/schema-registry/schema-registry.properties
[Install]
WantedBy=multi-user.target

6. systemctl enable schema-registry.service
7. service schema-registry start
8. service schema-registry status

// Rest-proxy
9. vi etc/kafka-rest/kafka-rest.properties

Uncomment these line

	id=kafka-rest-test-server
	schema.registry.url=http://localhost:8081
	zookeeper.connect=localhost:2181
10. vi /etc/systemd/system/kafka-restproxy.service
[Unit]
Description=Kafka-RestProxy
After=network.target
[Service]
#User=kafka
ExecStart=/home/kafka/confluent-3.3.0/bin/kafka-rest-start  /home/kafka/confluent-3.3.0/etc/kafka-rest/kafka-rest.properties
[Install]
WantedBy=multi-user.target

11. systemctl enable kafka-restproxy.service
12. service kafka-restproxy start
13. service kafka-restproxy status




// kafka-topic UI

docker run -d --name  kafka-restproxy --restart=always  -p 8000:8000 -e "KAFKA_REST_PROXY_URL=http://<rest_proxy_server_ip>:8082" -e "PROXY=true" landoop/kafka-topics-ui


Topic-UI-Dashboard-   http://<Topic_UI_Server>:8000



// Kafka-manager

1. Download java-8-oracle [Expected path should be /usr/lib/jvm/java-8-oracle/bin]
	> sudo add-apt-repository ppa:webupd8team/java
	> sudo apt-get update
	> sudo apt-get install oracle-java8-installer
2. Download kafka-manager 
	> git clone  https://github.com/yahoo/kafka-manager.git 
3. configure kafka-manager
	> cd  kafka-manager
	> vi conf/application.conf   [Edit the configuration specify zookeepers url multiple zookeeper allow  ] 

eg : kafka-manager.zkhosts="localhost:2181"
4. BUild jar(Run below command in kafka-manager folder)
$>    PATH=/usr/lib/jvm/java-8-oracle/bin:$PATH JAVA_HOME=/usr/lib/jvm/java-8-oracle ./sbt -java-home /usr/lib/jvm/java-8-oracle clean dist 
5. Unzip jar
	> cd </path/to/kafka-manager>/target/universal
	> unzip kafka-manager-1.3.3.13.zip 
6. Run kafka-manager in command prompt 
	> cd kafka-manager-1.3.3.13
	> bin/kafka-manager

		or
7. Run Kafka-manager as a service
8. vi /etc/systemd/system/kafka-manager.service
[Unit]
Description=Kafka-Manager
After=network.target
[Service]
#User=kafka
ExecStart=/home/kafka/kafka-manager/target/universal/kafka-manager-1.3.3.13/bin/kafka-manager
[Install]
WantedBy=multi-user.target

9. systemctl enable kafka-manager.service
10. service kafka-manager start
11. service kafka-manager status





Install Kubectl Binary
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

chmod +x ./kubectl

// Set path of admin.conf or kubernetes config file to access cluster from anywhere

export KUBECONFIG=<PATH_OF_CONFIG_FILE>
// fire any kubernetes command eg: 
./kubectl get nodes


//  find out all services that have been run at startup

systemctl list-units --type service

list of all services no matter they are active or not:

systemctl list-units --type service --all


// Start a service on system bootstrap

systemctl enable service_name

eg: systemctl enable kafka.service

// Stop a service on system bootstrap

systemctl disable service_name

eg: systemctl disable kafka.service










