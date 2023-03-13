#!/bin/bash


# Required parameters
# -c - path to the folder with configuration file
# -p - port on which the server will be listening


# Default values
CONFIG_FILE=/etc/nginx/conf.d/default.conf
PORT=80


while getopts ":c:p:" opt; do
  case $opt in
    c) CONFIG_FILE="$OPTARG"
    ;;
    p) PORT="$OPTARG"
    ;;
    \?) echo "Nieprawidłowa opcja -$OPTARG" >&2
    ;;
  esac
done

if [ ! -d "$CONFIG_FILE" ]; then
  echo "Folder $CONFIG_FILE does not exist"
  exit 1
fi


docker run --name my-nginx -p $PORT:$PORT -v "$CONFIG_FILE:/etc/nginx/conf.d" -d nginx


status_code=$(curl --write-out %{http_code} --silent --output /dev/null http://localhost:$PORT)

if [[ "$status_code" -ne 200 ]] ; then
  echo "Server is not running properly"
else
  echo "Server is running properly"
fi


docker stop my-nginx

docker rm my-nginx
