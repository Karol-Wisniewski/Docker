#!/bin/bash

docker volume ls -q | while read volume; do
    echo -n "$volume: "
    mountpoint=$(docker volume inspect $volume | awk -F'[ ,]+' -v vol="$volume" '$0~vol{p=1}p&&/Mountpoint/{gsub(/\\/, "/", $2); print $2; exit}' FS=": " OFS=" ")
    echo -n "$mountpoint: "
    if [ -n "$mountpoint" ]; then
        usage=$(fsutil volume diskfree "$mountpoint" | awk 'NR==2{print $3}')
        echo "$usage"
    else
        echo "Not mounted"
    fi
done
