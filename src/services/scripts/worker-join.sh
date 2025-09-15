#!/bin/bash

while [ ! -f /home/vagrant/swarm_token ]; do
    echo "Waiting for swarm token..."
    sleep 5
done

# Присоединяемся к Swarm, если еще не присоединены
if [ ! "$(docker info | grep Swarm | sed 's/Swarm: //g')" = "active" ]; then
    SWARM_TOKEN=$(cat /home/vagrant/swarm_token)
    docker swarm join --token $SWARM_TOKEN 192.168.56.10:2377
fi