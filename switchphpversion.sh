#!/usr/bin/env bash
#switch php version on UPBUNTU
a2dismod php7.4
a2enmod php8.1


update-alternatives --set php /usr/bin/php8.1
update-alternatives --set phar /usr/bin/phar8.1
update-alternatives --set phar.phar /usr/bin/phar.phar8.1