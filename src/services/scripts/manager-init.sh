#!/bin/bash
# Запуск инициализации Swarm, если ещё не инициализирован
if ! docker info | grep -q "Swarm: active"; then
  # выбираем IP-адрес, который будет advertize (получаем IP интерфейса)
  docker swarm init --advertise-addr 192.168.56.10
  docker swarm join-token -q worker > /home/vagrant/swarm_token
fi
