FROM mysql:8.0.33
LABEL Author="uday"
LABEL project="vprofile"

ENV MYSQL_DATABASE="accounts"
ENV MYSQL_USER="admin"
ENV MYSQL_PASSWORD="admin123"

ADD db_backup.sql /docker-entrypoint-initdb.d/db_backup.sql

