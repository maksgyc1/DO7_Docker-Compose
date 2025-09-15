#!/bin/bash
set -e

# Простая установка Docker CE и docker-compose plugin (ubuntu 20.04)
apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install -y \
  apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install -y docker-ce docker-ce-cli containerd.io

# Устанавливаем docker-compose plugin (compose v2)
apt-get install -y docker-compose-plugin

# Добавляем vagrant в группу docker
usermod -aG docker vagrant

# Убедимся, что systemd может запустить docker
systemctl enable --now docker
