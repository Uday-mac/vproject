#!/bin/bash

sudo dnf update -y
sudo dnf install epel-release -y 
sudo dnf install memcached -y

sudo systemctl start memcached 
sudo systemctl enable memcached

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/sysconfig/memcached
sudo systemctl restart memcached

sudo memcached -p 11211 -U 11111 -u memcached -d