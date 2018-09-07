#SQL Credentials. Update with your current credentials.
MySQLUser=    #user mysql 
MySQLPass=		#password mysql
#MySQLHost=“localhost”    
# Linux bin paths, change this if it can not be autodetected via which command
# Backup Dest directory, 
# Main directory where backup will be stored
MBD=“/home/vagrant/mysqlbk”
# Get hostname
HOST=“$(hostname)”
# Get data in dd-mm-yyyy format
NOW=$(date +%d-%m-%Y)
# File to store current backup file
BackupFile=“”
# Store list of databases
DatabaseList=""
[ ! -d $MBD ] && mkdir -p $MBD || :
#Get all database list first
DatabaseList="$(mysql -u $MySQLUser -p$MySQLPass -Bse 'show databases;')"   
for db in $DatabaseList
do
BackupFile=“$MBD/$db.$NOW.gz”
# do all inone job in pipe,
# connect to mysql using mysqldump for select mysql database
# and pipe it out to gz file in backup dir
mysqldump -u $MySQLUser  -p$MySQLPass $db  > /home/vagrant/mysqlbk/$NOW.$db.sql 
done
#Delete Backup
#find /home/vagrant/mysqlbk* -mtime +1 -exec rm {} \;
find /home/vagrant/mysqlbk* -mmin +59 -type f -exec rm -fv {} \;
