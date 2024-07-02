#! /bin/bash

ARCHIVE_FILE="$(date +%d_%m_%y).tar.gz"
TEMP_DIR="/tmp/algov_backup"
ARCHIVE_DIR="/var/algov_backups"

if [ -z "$TEMP_DIR" ]; then
	echo "The TEMP_DIR variable is empty and the script cannot continue."
	exit -1
fi

if [ ! -d $ARCHIVE_DIR ]; then
	mkdir $ARCHIVE_DIR
fi

if [ ! -d "$TEMP_DIR" ]; then
	mkdir $TEMP_DIR
else
	if [ ! -z $(ls $TEMP_DIR) ]; then # verify the TEMP_DIR isn't empty before clearing it
		rm -r ${TEMP_DIR}/*
	fi
fi

cd $TEMP_DIR

echo "-- Backing up databases"
mysqldump --all-databases > databases_dump.sql
# mysqldump  database_X > database_X.sql to dump a single database

echo "-- Backing up configurations"
cp -r /etc/ ./configs

echo "-- Creating an archive"
tar -czf $ARCHIVE_FILE ./*

mv $ARCHIVE_FILE ${ARCHIVE_DIR}/

rm -r ${TEMP_DIR}/*

echo "-- Task done ($(du -h "${ARCHIVE_DIR}/$ARCHIVE_FILE" | cut -f 1))"
