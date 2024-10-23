#!/bin/bash
DATABASE_PASS='admin123'

sudo yum update -y
sudo yum install epel-release -y
sudo yum install git zip unzip -y
sudo yum install maven mariadb-server -y

sudo systemctl start mariadb
sudo systemctl enable mariadb

cd /tmp/

git clone -b vagrant https://github.com/Uday-mac/vproject.git 

sudo mysqladmin -u root password "$DATABASE_PASS"

sudo mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')"
sudo mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.user WHERE User=''"
sudo mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%'"
sudo mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"

sudo mysql -u root -p"$DATABASE_PASS" -e "CREATE DATABASE accounts"
sudo mysql -u root -p"$DATABASE_PASS" -e "GRANT ALL PRIVILEGES ON accounts.* TO 'admin'@'localhost' IDENTIFIED BY 'admin123'"
sudo mysql -u root -p"$DATABASE_PASS" -e "GRANT ALL PRIVILEGES ON accounts.* TO 'admin'@'%' IDENTIFIED BY 'admin123'"

sudo mysql -u root -p"$DATABASE_PASS" accounts < /tmp/vproject/src/main/resources/db_backup.sql

sudo mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"


sudo systemctl restart mariadb


