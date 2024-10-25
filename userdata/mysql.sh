#!/bin/bash

DATABASE_PASS='admin123'

sudo dnf update -y
sudo dnf install epel-release -y
sudo dnf install git zip unzip -y
sudo dnf install mariadb105-server -y

systemctl start mariadb
systemctl enable mariadb

cd /tmp/

git clone -b awsliftandshift https://github.com/Uday-mac/vproject.git

mysqladmin -u root password "$DATABASE_PASS"

sudo mysql -u root -p"$DATABASE_PASS" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DATABASE_PASS'"
sudo mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')"
sudo mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.user WHERE User=''"
sudo mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'"
sudo mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"

sudo mysql -u root -p"$DATABASE_PASS" -e "create database accounts"
sudo mysql -u root -p"$DATABASE_PASS" -e "grant all privileges on account.* TO 'admin'@'localhots' IDENTIFIED BY'admin123'"
sudo mysql -u root -p"$DATABASE_PASS" -e "grant all privileges on account.* TO 'admin'@'%' IDENTIFIED BY'admin123'"
sudo mysql -u root -p"$DATABASE_PASS" accounts < vproject/src/main/resources/db_backup.sql
sudo mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"

systemctl restart mariadb
