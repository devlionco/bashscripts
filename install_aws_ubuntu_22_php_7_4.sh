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
sudo apt-get install php7.4 -y
sudo apt-get install php7.4-curl -y
sudo apt-get install php7.4-zip -y
sudo apt-get install php7.4-cli -y
sudo apt-get install php7.4-mysql -y
sudo apt-get install libapache2-mod-php7.4 -y
sudo apt-get install php7.4-zip -y
sudo apt-get install php7.4-mbstring -y
sudo apt-get install php7.4-opcache -y
sudo apt-get install php7.4-intl -y
sudo apt-get install php7.4-json -y
sudo apt-get install php7.4-xs -y
sudo apt-get install php7.4-gd -y
sudo apt-get install php7.4-soap -y
sudo apt-get install php7.4-xml -y
sudo apt-get install php7.4-simplexml -y
sudo apt-get install php7.4-spl -y
sudo apt-get install php7.4-ldap -y
sudo apt-get install php7.4-dev -y
sudo apt-get install php7.4-xmlrpc -y
sudo apt-get install php7.4-mcrypt -y
sudo apt-get install php7.4-bcmath -y
sudo apt-get install php7.4-sodium -y
sudo apt-get install php7.4-yaml -y
sudo apt-get install php7.4-redis -y
sudo apt-get install php7.4-excimer -y

sudo /etc/init.d/apache2 restart
