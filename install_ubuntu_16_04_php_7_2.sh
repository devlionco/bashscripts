#!/usr/bin/env bash
sudo apt-get install git -y
sudo apt-get install upgrade
sudo apt-get install update
#set Timezone
sudo dpkg-reconfigure tzdata
#INSTALL APACHE
sudo apt-get install apache2 -y
sudo a2enmod rewrite
sudo service apache2 restart
#INSTALL MYSQL
sudo apt-get install mysql-server mysql-client -y
#INSTALL PHP
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update
sudo apt-get install php7.2 -y
sudo apt-get install php7.2-cli -y
sudo apt-get install php7.2-mysql -y
sudo apt-get install php7.2-curl -y
sudo apt-get install libapache2-mod-php7.2 -y
sudo apt-get install php7.2-zip -y
sudo apt-get install php7.2-mbstring -y
sudo apt-get install php7.2-opcache -y
sudo apt-get install php7.2-intl -y
sudo apt-get install php7.2-json -y
sudo apt-get install php7.2-xs -y
sudo apt-get install php7.2-gd -y
sudo apt-get install php7.2-soap -y
sudo apt-get install php7.2-xml -y
sudo apt-get install php7.2-simplexml -y
sudo apt-get install php7.2-spl -y
sudo apt-get install php7.2-ldap -y
sudo apt-get install php7.2-dev -y
sudo apt-get install php7.2-xmlrpc -y

#INSTALL COMPOSER
sudo apt-get install composer