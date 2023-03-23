#!/bin/bash

# ask user for password
echo "Enter password to secure volume:"
read -s password

# create encrypted volume
echo "Creating encrypted volume..."
tar -czvf - \\\\wsl$\\docker-desktop-data\\data\\docker\\volumes\\nginx_data | gpg --symmetric --cipher-algo AES256 --batch --passphrase "$password" -o \\\\wsl$\\docker-desktop-data\\data\\docker\\volumes\\nginx_data.tar.gz.gpg

# prompt user to enter password again to decrypt volume
echo "Enter password to decrypt volume:"
read -s password

# decrypt and extract volume
echo "Decrypting volume..."
gpg --decrypt --batch --passphrase "$password" \\\\wsl$\\docker-desktop-data\\data\\docker\\volumes\\nginx_data.tar.gz.gpg | tar -xzvf - -C \\\\wsl$\\docker-desktop-data\\data\\docker\\volumes\\nginx_data



\\wsl.localhost\docker-desktop-data\data\docker\volumes\nginx_data