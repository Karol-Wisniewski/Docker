#!/bin/bash

docker volume create nodejs_data

docker volume create nginx_data

docker run -d \
  --name lab04zad2 \
  -v nodejs_data:/app \
  node:latest \
  sh -c "echo 'Hello World'  > /app/index.html"

docker volume create all_volumes

docker container run --rm -it -v nginx_data:/usr/share/nginx/html -v all_volumes:/all_volumes busybox sh -c "cp -a /usr/share/nginx/html/. /all_volumes"

docker container run --rm -it -v nodejs_data:/app -v all_volumes:/all_volumes busybox sh -c "cp -a app/. /all_volumes"