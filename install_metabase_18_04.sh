#!/usr/bin/env bash
sudo apt-get install update

#set Timezone
sudo dpkg-reconfigure tzdata

#install JDK
sudo apt install openjdk-8-jdk openjdk-8-jre

#install MYSQL
sudo apt-get install mysql-server mysql-client -y


#run query in mysql
#CREATE DATABASE metabase CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
#GRANT ALL PRIVILEGES ON metabase.* TO 'metabase'@'localhost' IDENTIFIED BY "Metabase2019"; FLUSH PRIVILEGES;


export VER=0.31.2
wget http://downloads.metabase.com/v${VER}/metabase.jar
sudo mkdir -p /apps/java
sudo mv metabase.jar /apps/java

sudo groupadd -r appmgr
sudo useradd -r -s /bin/false -g appmgr appmgr
sudo chown -R appmgr:appmgr /apps/java


sudo vim /etc/systemd/system/metabase.service

#add this
#[Unit]
#Description=Metabase applicaion service
#Documentation=https://www.metabase.com/docs/latest

#[Service]
#WorkingDirectory=/apps/java
#ExecStart=/usr/bin/java -Xms128m -Xmx256m -jar metabase.jar
#User=appmgr
#Type=simple
#Restart=on-failure
#RestartSec=10

#[Install]
#WantedBy=multi-user.target

sudo systemctl daemon-reload

sudo systemctl start metabase.service

sudo systemctl enable metabase.service