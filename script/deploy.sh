#!/bin/bash

cp /home/ubuntu/.env /home/ubuntu/api-deploy/.env 
cp /home/ubuntu/Gemfile /home/ubuntu/api-deploy/Gemfile
cd /home/ubuntu/api-deploy

if [ "$(docker ps | grep "app-api")" != "" ]; then
  docker rm -f $(docker ps | grep "app-api")
fi
if [ "$(docker images | grep "app-api")" != "" ]; then
  docker rmi -f $(docker images | grep "app-api")
fi

docker build -t app-api .
docker run -p 3030:3000 -d app-api