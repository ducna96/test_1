#!/bin/bash

MONGO_DATABASE="name_database" 
APP_NAME="database_backup_mongo"

MONGO_HOST="127.0.0.1"
MONGO_PORT="27017"
TIMESTAMP=`date +%F-%H%M`
MONGODUMP_PATH="/usr/bin/mongodump"
BACKUPS_DIR="/home/vagrant/mongobk/$APP_NAME"
BACKUP_NAME="$APP_NAME-$TIMESTAMP"

# mongo admin --eval "printjson(db.fsyncLock())"
# $MONGODUMP_PATH -h $MONGO_HOST:$MONGO_PORT -d $MONGO_DATABASE
$MONGODUMP_PATH -d $MONGO_DATABASE
# mongo admin --eval "printjson(db.fsyncUnlock())"

mkdir -p $BACKUPS_DIR
mv dump $BACKUP_NAME
tar -zcvf $BACKUPS_DIR/$BACKUP_NAME.tgz $BACKUP_NAME
rm -rf $BACKUP_NAME

#export db to .jon
#mongoexport -d namedb -c  collection -o address folder
mongoexport -d myfirstdb -c Department -o /backup_dir
