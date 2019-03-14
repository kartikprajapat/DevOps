export REGISTRY_PATH=13.127.243.52:5000
sudo docker rm -f aob-notification-service
sudo docker pull $REGISTRY_PATH/aob-notification-service:0.0.52
sudo docker run -d -p 3006:3006 -v /home/ubuntu/app/configs/aob-services-configurations/stemcell-prod/application.yaml:/etc/properties/app/application.yaml -v /home/ubuntu/app/configs/aob-services-configurations/stemcell-prod/core-services/notification-service.yaml:/etc/properties/service/notification-service.yaml -v /var/logs/application/notification:/var/log/applogs -e GLOBAL_APP_SETTING_PATH=/etc/properties/app/application.yaml -e SERVICE_APP_SETTING_PATH=/etc/properties/service/notification-service.yaml -e LOG_FILE_SETTING_PATH=/var/log/applogs/notification-service.logs --restart always --name aob-notification-service $REGISTRY_PATH/aob-notification-service:0.0.52

sudo docker rm -f countryservice
sudo docker pull $REGISTRY_PATH/countryservice:0.1.0.11
sudo docker run -d -e  env=aprod  -p 5030:8080 -v /var/logs/application/countryservice:/tmp/countryservice --restart always --name countryservice $REGISTRY_PATH/countryservice:0.1.0.11

sudo docker rm -f id-generator
sudo docker pull $REGISTRY_PATH/id-generator:0.1.0.8
sudo docker run -d -e  env=aprod  -p 5020:8080 -v /var/logs/application/id-generator:/tmp/id-generator --restart always --name id-generator $REGISTRY_PATH/id-generator:0.1.0.8


sudo docker rm -f order-management-events-persister
sudo docker pull $REGISTRY_PATH/order-management-events-persister:0.1.0.108
sudo docker run -d -e  env=aprod  -p 5017:8080 -v /var/logs/application/order-management-events-persister:/tmp/order-management-events-persister --restart always --name order-management-events-persister $REGISTRY_PATH/order-management-events-persister:0.1.0.108

sudo docker rm -f aob-media-service
sudo docker pull $REGISTRY_PATH/aob-media-service:0.0.54
sudo docker run -d -p 3005:3005 -v /home/ubuntu/app/configs/aob-services-configurations/stemcell-prod/application.yaml:/etc/properties/app/application.yaml -v /home/ubuntu/app/configs/aob-services-configurations/stemcell-prod/core-services/media-service.yaml:/etc/properties/service/media-service.yaml -v /var/logs/application/media:/var/log/applogs -e GLOBAL_APP_SETTING_PATH=/etc/properties/app/application.yaml -e SERVICE_APP_SETTING_PATH=/etc/properties/service/media-service.yaml -e LOG_FILE_SETTING_PATH=/var/log/applogs/media.logs --restart always --name aob-media-service $REGISTRY_PATH/aob-media-service:0.0.54

sudo docker rm -f aob-payments-service
sudo docker pull $REGISTRY_PATH/aob-payments-service:0.0.12
sudo docker run -d -p 3025:3025 -v /home/ubuntu/app/configs/aob-services-configurations/stemcell-prod/application.yaml:/etc/properties/app/application.yaml -v /home/ubuntu/app/configs/aob-services-configurations/stemcell-prod/core-services/payment-service.yaml:/etc/properties/service/payment-service.yaml -v /var/logs/application/payment:/var/log/applogs -e GLOBAL_APP_SETTING_PATH=/etc/properties/app/application.yaml -e SERVICE_APP_SETTING_PATH=/etc/properties/service/payment-service.yaml -e LOG_FILE_SETTING_PATH=/var/log/applogs/payment.logs --restart always --name aob-payments-service $REGISTRY_PATH/aob-payments-service:0.0.12

sudo docker rm -f stem-cell-resolver
sudo docker pull $REGISTRY_PATH/stem-cell-resolver:0.1.0.42
sudo docker run -d -e  env=aprod  -p 5010:8080 -v /var/logs/application/stem-cell-resolver:/tmp/stem-cell-resolver --restart always --name stem-cell-resolver $REGISTRY_PATH/stem-cell-resolver:0.1.0.42


sudo docker rm -f aob-stem-cell-service
sudo docker pull $REGISTRY_PATH/aob-stem-cell-service:0.0.261
sudo docker run -d -p 4005:8080 -e ENV=aprod -v /var/logs/application/stem-cell-service:/tmp/aob-stem-cell-service --restart always --name aob-stem-cell-service $REGISTRY_PATH/aob-stem-cell-service:0.0.261

sudo docker rm -f aob-stem-cell-web-app
sudo docker pull $REGISTRY_PATH/aob-stem-cell-web-app:0.0.508
sudo docker run -d -p 7171:7171 --restart always --name aob-stem-cell-web-app $REGISTRY_PATH/aob-stem-cell-web-app:0.0.508

sudo docker rm -f zipcodego
sudo docker pull $REGISTRY_PATH/zipcodes:0.1.0.27
sudo docker run -d -e  env=aprod -p 5003:8001 -v /var/logs/application/zipcodes:/tmp/zipCodeService/ --restart always --name zipcodego $REGISTRY_PATH/zipcodes:0.1.0.27

