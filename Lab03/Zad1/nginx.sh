#!/bin/bash

# Required parameters
# -c - path to the folder with content
# -p - port on which the server will be listening

while getopts ":c:p:" opt; do
  case $opt in
    c) content="$OPTARG"
    ;;
    p) port="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done


if [ ! -d "$content" ]; then
  echo "Folder $content does not exist"
  exit 1
fi


docker run -d -p $port:80 \
-v $content:/usr/share/nginx/html \
--name my-nginx nginx


echo "Nginx server is running at http://localhost:$port"


status_code=$(curl --write-out %{http_code} --silent --output /dev/null http://localhost:$port)


if [[ "$status_code" -ne 200 ]] ; then
  echo "Server is not running properly"
else
  echo "Server is running properly"
fi

docker stop my-nginx
docker rm my-nginx