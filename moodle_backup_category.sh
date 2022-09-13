#!/bin/sh
DB=moodel
USERNAME=dbusername
PASSWORD=dbpassword
HOST=dbhost
CATEGORY=category
MOODLEBACKUPCLI=/var/www/html/moodle/admin/cli/backup.php #path to backup script
PATHTOBACKUP=/backup #pathto backup
PATHPHP=/usr/bin/php  #path to php
myvariable=$(mysql $DB -h $HOST -u $USERNAME -p$PASSWORD  -se  "SELECT id FROM mdl_course where category in (SELECT id FROM mdl_course_categories WHERE path LIKE '%$CATEGORY%')")

for course in $myvariable
do
  echo "course id: $course"
  $PATHPHP $MOODLEBACKUPCLI  --courseid=$course --destination=$PATHTOBACKUP
done



