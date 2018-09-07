#!/bin/bash
PG_USER=postgres
DATABASE=mydb
#SERVER=216.58.219.174
DIR="/home/vagrant/pgsqlbk"
DATE=$(date +"%m_%d_%y")
FILE="$DATABASE_$DATE"
# pass @ .pgpass

PG_BAK_NOW () {
  pg_dump  -U $PG_USER -h localhost $DATABASE -f $FILE.sql
}

#echo "Ready to dump to $FILE" >> "$HOME/pg_status"

cd $DIR
if [ -f "$FILE" ];
then
  rm $FILE
  PG_BAK_NOW
else
  PG_BAK_NOW
fi
#delete
#find /home/vagrant/pgsqlbk* -mtime +1 -exec rm {} \;
find /home/vagrant/pgsqlbk* -mmin +59 -type f -exec rm -fv {} \;
