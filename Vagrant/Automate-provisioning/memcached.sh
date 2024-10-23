#!/bin/bash

sudo yum update -y
sudo yum install epel-release -y
sudo yum install memcached -y

sudo systemctl start memcached
sudo systemctl enable memcached

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/sysconfig/memcached.service

sudo systemctl restart memcached