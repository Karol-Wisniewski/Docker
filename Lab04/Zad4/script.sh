#!/bin/bash

read -p "Enter volume name: " volume_name
read -s -p "Enter password: " password

docker run -v $volume_name:/data -v C:/Users/Karol/Desktop/Docker/Lab04/Zad4:/output \
ubuntu bash -c "apt-get update && apt-get install -y gnupg && tar -czvf /output/$volume_name.tar -C /data . && gpg --batch --symmetric --cipher-algo AES256 --passphrase $password /output/$volume_name.tar && gpg --batch --decrypt --passphrase $password /output/$volume_name.tar.gpg && tar -xvf /output/$volume_name.tar -C /output && rm /output/$volume_name.tar.gpg"
