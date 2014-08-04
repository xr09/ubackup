#!/usr/bin/bash

backup_number=6
base_name="backup.gz"
backup_path="/opt/backup_folder/"

cd $backup_path

# clean any old temp backup
rm -f *.tmp


# change this line with your specific backup: pgdump, tar, rsync, etc..
echo "$(date +%T)" > "$base_name".tmp


# make sure the backups are getting done before discarding old ones
if [ ! -f  "$base_name".tmp ]
then
    echo "ERROR: Backup file \"$base_name.tmp\" not found"
    exit -1
fi

# delete the oldest
rm -f $base_name.$backup_number

# rotate backups
for i in $(seq $backup_number -1 2)
do
    mv "$base_name".$(($i-1)) "$base_name".$i
done

# tmp is now the newest backup
mv "$base_name".tmp "$base_name".1
