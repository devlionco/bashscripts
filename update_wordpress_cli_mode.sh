#!/usr/bin/env bash


pathtowordpress=/var/www/wp
#install wp-cli extension
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
sudo chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

#update wordpress core and all plugins
cd $pathtowordpress
wp core update --allow-root
wp plugin update --all --allow-root