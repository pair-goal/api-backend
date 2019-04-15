#!/bin/bash

cp /home/ubuntu/.env /home/ubuntu/api-deploy/.env 
cp /home/ubuntu/Gemfile /home/ubuntu/api-deploy/Gemfile
cd /home/ubuntu/api-deploy

if [ "$(docker ps -a | grep "app-api")" != "" ]; then
  docker rm -f $(docker ps -a | grep "app-api")
fi
if [ "$(docker images | grep "app-api")" != "" ]; then
  docker rmi -f $(docker images | grep "app-api")
fi

sudo docker build -t app-api .
sudo docker run -p 3030:3000 -d app-api