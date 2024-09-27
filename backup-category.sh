#!/bin/sh
DB=petel
USERNAME=kiril
PASSWORD=dddd
HOST=localhost
CATEGORY=5
MOODLEBACKUPCLI=/var/www/html/petel/admin/cli/backup.php
PATHTOBACKUP=/var/www/
PATHPHP=/usr/bin/php
myvariable=$(mysql $DB -h $HOST -u $USERNAME -p$PASSWORD  -se  "SELECT id FROM mdl_course where category in (SELECT id FROM mdl_course_categories WHERE path LIKE '%$CATEGORY%')")
for course in $myvariable
do
  echo "course id: $course"
  $PATHPHP $MOODLEBACKUPCLI  --courseid=$course --destination=$PATHTOBACKUP
done
