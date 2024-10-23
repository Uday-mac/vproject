#!/bin/bash
sudo yum update -y
sudo yum install java-11-openjdk java-11-openjdk-devel -y
sudo yum install git maven wget -y

#downloading the tomcat version

cd /tmp/

wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.96/bin/apache-tomcat-9.0.96.tar.gz

tar xzvf apache-tomcat-9.0.96.tar.gz

sudo useradd --home-dir /usr/local/tomcat --shell /sbin/nologin tomcat

cp -r apache-tomcat-9.0.96/* /usr/local/tomcat/

sudo chown -R tomcat.tomcat /usr/local/tomcat

cat <<EOF > /etc/systemd/system/tomcat.service
[Unit]
Description = Tomcat
After = network.target

[Service]
User = tomcat
WorkingDirectory = /usr/local/tomcat
Environment = JRE_HOME = /usr/lib/jvm/jre
Environment = JAVA_HOME = /usr/lib/jvm/jre
Environment = CATALINA_HOME = /usr/local/tomcat
Environment = CATALINA_BASE = /usr/local/tomcat
ExecStart = /usr/local/tomcat/bin/catalina.sh run
ExecStop = /usr/local/tomcat/bin/shutdown.sh

[Install]
WantedBy = multiuser.target
EOF

sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat

sudo git clone -b vagrant https://github.com/Uday-mac/vproject.git
cd vproject
sudo mvn install 

sudo systemctl stop tomcat

sleep 20

sudo rm -rf /usr/local/tomcat/webapps/*

sudo cp target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

sudo systemctl restart tomcat