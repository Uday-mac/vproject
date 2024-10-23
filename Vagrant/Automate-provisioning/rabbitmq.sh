#!/bin/bash

sudo yum update -y
sudo yum install epel-release -y
sudo yum install wget -y

sudo dnf install centos-release-rabbitmq-38 -y

sudo dnf --enablerepo=centos-rabbitmq-38 -y install rabbitmq-server

sudo systemctl start rabbitmq-server

sudo systemctl enable --now rabbitmq-server

sudo sh -c 'echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config'

sudo rabbitmqctl add_user test test

sudo rabbitmqctl set_user_tags test administrator 

sudo systemctl restart rabbitmq-server