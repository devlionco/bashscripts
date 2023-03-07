#!/usr/bin/env bash
sudo apt-get install git -y
sudo apt-get install upgrade
sudo apt-get install update
sudo apt-get install zip -y

#local redis
sudo apt-get install redis

#utils for EFS
sudo apt-get -y install nfs-common

#set Timezone
sudo dpkg-reconfigure tzdata

#INSTALL APACHE
sudo apt-get install apache2 -y
sudo a2enmod rewrite
sudo service apache2 restart

#INSTALL PHP
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update
sudo apt-get install php8.1 -y
sudo apt-get install php8.1-curl -y
sudo apt-get install php8.1-zip -y
sudo apt-get install php8.1-cli -y
sudo apt-get install php8.1-mysql -y
sudo apt-get install libapache2-mod-php8.1-y
sudo apt-get install php8.1-zip -y
sudo apt-get install php8.1-mbstring -y
sudo apt-get install php8.1-opcache -y
sudo apt-get install php8.1-intl -y
sudo apt-get install php8.1-json -y
sudo apt-get install php8.1-xs -y
sudo apt-get install php8.1-gd -y
sudo apt-get install php8.1-soap -y
sudo apt-get install php8.1-xml -y
sudo apt-get install php8.1-simplexml -y
sudo apt-get install php8.1-spl -y
sudo apt-get install php8.1-ldap -y
sudo apt-get install php8.1-dev -y
sudo apt-get install php8.1-xmlrpc -y
sudo apt-get install php8.1-mcrypt -y
sudo apt-get install php8.1-bcmath -y
sudo apt-get install php8.1-sodium -y
sudo apt-get install php8.1-yaml -y
sudo apt-get install php8.1-redis -y
sudo apt-get install php8.1-excimer -y

sudo /etc/init.d/apache2 restart
