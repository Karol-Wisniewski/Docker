#!/bin/bash

volumes=$(docker volume ls --format '{{ .Mountpoint }}')

for volume in $volumes
do
  disk_usage=$(df -h $volume | awk 'NR==2 {print $5}')

  percentage=$(echo $disk_usage | tr -d '%')

  echo "Volume $volume is $percentage% full"
done