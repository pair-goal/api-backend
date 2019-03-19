#!/bin/bash

cd /home/ubuntu/deploy

if [[ "$(docker ps -a -q)" != "" ]]; then
  docker rm -f $(docker ps -a -q)
fi
if [[ "$(docker images -q)" != "" ]]; then
  docker rmi -f $(docker images -q)
fi

docker build -t app .
docker run -p 3000:3000 -d app

docker rmi $(docker images -f "dangling=true" -q)