#!/usr/bin/env bash
sudo apt-get install upgrade
sudo apt-get install update
sudo wget http://vpl.dis.ulpgc.es/releases/vpl-jail-system-2.3.0.3.tar.gz
sudo tar -xvf /home/vpl-jail-system-2.3.0.3.tar.gz
cd /home/vpl-jail-system-2.3.0.3
sudo sudo ./install-vpl-sh


#sudo service vpl-jail-system start
#sudo service vpl-jail-system stop