#!/bin/bash

cp /home/ubuntu/.env /home/ubuntu/deploy/.env 
cp /home/ubuntu/Gemfile /home/ubuntu/deploy/Gemfile
cd /home/ubuntu/deploy

if [ "$(docker ps -a -q)" != "" ]; then
  docker rm -f $(docker ps -a -q)
fi
if [ "$(docker images -q)" != "" ]; then
  docker rmi -f $(docker images -q)
fi

docker build -t app .
docker run -p 3030:3000 -d app