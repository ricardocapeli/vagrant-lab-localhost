#!/usr/bin/env bash

# THIS SCRIPT WILL CREATE SSH KEYPAIR AND DISTRIBUTE ACROSS ALL NODES

ssh-keygen -b 2048 -t rsa -f /home/vagrant/.ssh/id_rsa -q -N ""

# LOOPING THROUGH AND DISTRIBUTING THE KEY


# list
# 192.168.56.50
# 192.168.56.51
# 192.168.56.52
# 192.168.56.53
# 192.168.56.54
# 192.168.56.55

for val in `cat list`; do 
        echo "-------------------- COPYING KEY TO ${val^^} NODE ------------------------------"
        sshpass -p 'vagrant' ssh-copy-id -o "StrictHostKeyChecking=no" vagrant@$val 
done

# CREATE THE INVENTORY FILE

PROJECT_DIRECTORY="/home/vagrant/ansible_project/"

mkdir -p $PROJECT_DIRECTORY
cd $PROJECT_DIRECTORY

# Creating the inventory file for all 3 nodes to run some adhoc command.

echo -e "ansible\n\n[ubuntu1]\master01\n\n[ubuntu2]\master02\n\n[ubuntu3]\master03\n\n[ubuntu4]\worker01\n\n[ubuntu5]\worker02\n\n[ubuntu6]\worker03" > inventory
echo -e "[defaults]\ninventory = inventory" > ansible.cfg
echo -e "-------------------- RUNNING ANSBILE ADHOC COMMAND - UPTIME ------------------------------"
echo

# running adhoc command to see if everything is fine

ansible all -i inventory -m "shell" -a "uptime"
echo