#!/usr/bin/env bash

# vagrant by default creates its own keypair for all the machines. Password based authentication will be disabled by default and enabling it so password based auth can be done.

sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Supressing the banner message everytime you connect to the vagrant box.

touch /home/vagrant/.hushlogin

# Updating the hosts file for all the 3 nodes with the IP given in vagrantfile

# 192.168.56.50	master01
# 192.168.56.51	master02
# 192.168.56.52	master03
# 192.168.56.53	worker01
# 192.168.56.54	worker02
# 192.168.56.55	worker03
# 192.168.56.49	loadbalancer

echo -e "192.168.56.101	master01\n192.168.56.102 master02\n192.168.56.103 master03\n192.168.56.104 worker01\n192.168.56.105	worker02\n192.168.56.106 worker03\n192.168.56.111 loadbalancer" >> /etc/hosts

# Installing necessary packages 

sudo apt update && sudo apt -y install curl wget net-tools iputils-ping python3-pip sshpass software-properties-common

# Install ansible using pip only in controller node

# curl -fsSL https://get.docker.com | sh

# sudo groupadd docker
# sudo usermod -aG docker $USER
# newgrp docker

# if [[ $(hostname) = "ansible" ]]; then
#   sudo pip3 install ansible
# fi
