#!/usr/bin/env bash
PROJECTNAME=projectname
PROJECTNAMEPASSWORD=Qe2vgdu3$PROJECTNAME
DBUSERROOTNAME=root
DBUSERPASSWORD=yourerootpassword
PATHTOROOT=/var/www/common/
PATHTOMOODLE=$PATHTOROOT$PROJECTNAME
PTAHTOMOODLEDATA=/var/www/moodledata$PROJECTNAME
MOODLEVERSION=MOODLE_36_STABLE
USERADMIN=admin
USERADMINPASSWORD=Admin111!
USERADMINEMAIL=admin@example.com
WWWROOT=http://youresite/$PROJECTNAME

mysql -u $DBUSERROOTNAME -p$DBUSERPASSWORD -e "CREATE DATABASE $PROJECTNAME DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
mysql -u $DBUSERROOTNAME -p$DBUSERPASSWORD -e "GRANT ALL PRIVILEGES ON $PROJECTNAME.* to '$PROJECTNAME'@'localhost' identified by '$PROJECTNAMEPASSWORD';"

cd $PATHTOROOT
git clone -b $MOODLEVERSION https://github.com/moodle/moodle.git $PROJECTNAME

mkdir $PTAHTOMOODLEDATA
chown www-data:www-data $PATHTOMOODLE -R
chown www-data:www-data $PTAHTOMOODLEDATA -R
chmod 777 $PATHTOMOODLE -R
chmod 777 $PTAHTOMOODLEDATA -R

cd $PATHTOMOODLE/admin/cli
php install.php --lang=en --dbname=$PROJECTNAME --dbuser=$PROJECTNAME --dbpass=$PROJECTNAMEPASSWORD --fullname=$PROJECTNAME --shortname=$PROJECTNAME --adminuser=$USERADMIN --adminemail=$USERADMINEMAIL --wwwroot=$WWWROOT --dataroot=$PTAHTOMOODLEDATA --agree-license=1







