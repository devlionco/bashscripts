#!/usr/bin/env bash

PHPINIPATH=/etc/php/7.4/apache2/php.ini

sudo apt install iptables -y
echo "ServerName localhost" >> /etc/apache2/apache2.conf
echo "TraceEnable off" >> /etc/apache2/apache2.conf
echo "ServerSignature Off" >> /etc/apache2/apache2.conf
echo "ServerTokens Prod" >> /etc/apache2/apache2.conf

sudo apt-get install libapache2-mod-security2
apachectl -M | grep security


upload_max_filesize=240M
post_max_size=50M
max_execution_time=100
max_input_time=223
memory_limit=512M
cookie_lifetime=0
use_cookies=On
use_only_cookies=On
use_strict_mode=On
cookie_httponly=On
cookie_secure=On


gc_maxlifetime=1200
use_trans_sid=Off
cache_limiter=nocache
sid_length=48
sid_bits_per_character=6
hash_function=sha256

for key in upload_max_filesize post_max_size max_execution_time max_input_time memory_limit cookie_lifetime use_cookies use_only_cookies use_strict_mode cookie_httponly cookie_secure
do
 sed -i "s/^\($key\).*/\1 $(eval echo = \${$key})/" $PHPINIPATH
done

for key in gc_maxlifetime use_trans_sid cache_limiter sid_length sid_bits_per_character hash_function
do
 sed -i "s/^\($key\).*/\1 $(eval echo = \${$key})/" $PHPINIPATH
done

sudo echo "Protocol 2" >> /etc/ssh/sshd_config
sudo echo "PermitEmptyPasswords no" >> /etc/ssh/sshd_config
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config

sudo service apache2 restart
sudo chown root:root /etc/ssh/sshd_config
sudo chmod og-rwx /etc/ssh/sshd_config
sudo apt purge xinetd -y
sudo apt remove openbsd-inetd -y
sudo apt purge xserver-xorg* -y
sudo systemctl --now disable avahi-daemon
sudo systemctl is-enabled avahi-daemon
sudo systemctl --now disable cups
sudo systemctl --now disable isc-dhcp-server
sudo systemctl --now disable isc-dhcp-server6
sudo systemctl --now disable slapd
sudo apt purge autofs -y
sudo rmmod usb-storage
sudo systemctl --now disable nfs-server
sudo systemctl --now disable rpcbind
sudo systemctl --now disable smbd
sudo systemctl --now disable squid
sudo rmmod freevxfs
sudo apt purge xinetd -y
sudo systemctl unmask tmp.mount
sudo systemctl enable tmp.mount

sed -i 'umask 027' /etc/bash.bashrc
sed -i 'umask 027' /etc/profile

sudo apt install auditd audispd-plugins -y

sudo systemctl --now enable auditd

sudo sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="audit=1"/g' /etc/default/grub
sudo update-grub
sudo sed -i 's/GRUB_CMDLINE_LINUX="audit-1"/GRUB_CMDLINE_LINUX="audit_backlog_limit=8192"/g' /etc/default/grub
sudo update-grub

grep "^\s*linux" /boot/grub/grub.cfg | grep -v "audit_backlog_limit="
grep "audit_backlog_limit=" /boot/grub/grub.cfg

sudo echo "-w /etc/group -p wa -k identity" > /etc/audit/rules.d/identity.rules
sudo echo "-w /etc/passwd -p wa -k identity" >> /etc/audit/rules.d/identity.rules
sudo echo "-w /etc/gshadow -p wa -k identity" >> /etc/audit/rules.d/identity.rules
sudo echo "-w /etc/shadow -p wa -k identity" >> /etc/audit/rules.d/identity.rules
sudo echo "-w /etc/security/opasswd -p wa -k identity" >> /etc/audit/rules.d/identity.rules

sudo echo "-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale" > /etc/audit/rules.d/system-locale.rules
sudo echo "-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale" >> /etc/audit/rules.d/system-locale.rules
sudo echo "-w /etc/issue -p wa -k system-locale" >> /etc/audit/rules.d/system-locale.rules
sudo echo "-w /etc/issue.net -p wa -k system-locale" >> /etc/audit/rules.d/system-locale.rules
sudo echo "-w /etc/hosts -p wa -k system-locale" >> /etc/audit/rules.d/system-locale.rules
sudo echo "-w /etc/network -p wa -k system-locale" >> /etc/audit/rules.d/system-locale.rules

sudo echo "-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access" > /etc/audit/rules.d/access.rules
sudo echo "-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access" >> /etc/audit/rules.d/access.rules
sudo echo "-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access" >> /etc/audit/rules.d/access.rules
sudo echo "-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access" >> /etc/audit/rules.d/access.rules

sudo echo "LogLevel VERBOSE" >> /etc/ssh/sshd_config


