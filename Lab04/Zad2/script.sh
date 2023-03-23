#!/bin/bash

docker volume create nodejs_data

docker run -d \
  --name lab04zad2 \
  -v nodejs_data:/app \
  node:latest

docker volume create all_volumes

docker volume create nginx_data

mkdir \\\\wsl$\\docker-desktop-data\\data\\docker\\volumes\\nginx_data\\_data\\usr

mkdir \\\\wsl$\\docker-desktop-data\\data\\docker\\volumes\\nginx_data\\_data\\usr\\share

mkdir \\\\wsl$\\docker-desktop-data\\data\\docker\\volumes\\nginx_data\\_data\\usr\\share\\nginx

mkdir \\\\wsl$\\docker-desktop-data\\data\\docker\\volumes\\nginx_data\\_data\\usr\\share\\nginx\\html

touch \\\\wsl$\\docker-desktop-data\\data\\docker\\volumes\\nginx_data\\_data\\usr\\share\\nginx\\html\\index.html

echo "Hello World" > \\\\wsl$\\docker-desktop-data\\data\\docker\\volumes\\nginx_data\\_data\\usr\\share\\nginx\\html\\index.html

cp -r \\\\wsl$\\docker-desktop-data\\data\\docker\\volumes\\nginx_data\\_data\\usr\\share\\nginx\\html\\ \\\\wsl$\\docker-desktop-data\\data\\docker\\volumes\\all_volumes\\_data

docker cp lab04zad2:/app \\\\wsl$\\docker-desktop-data\\data\\docker\\volumes\\all_volumes\\_data\\



