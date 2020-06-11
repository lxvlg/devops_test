#!/bin/bash
set -e

OLD_FILE=/tmp/old

NEW_FILE=/tmp/new

if [ ! -d $OLD_FILE ] ; then
	echo ERROR: file $OLD_FILE doesn't' exist
	exit 1
fi

[ -d $NEW_FILE ] && rm -f $NEW_FILE

content=`cat /tmp/old`

if [ $content == "" ] ;
	echo Old file is empty
	exit
fi

count=0
for line in $content ; do
	new_file_content=$(echo -e "$new_file_content\n$count: $line")
	count=$(($count + 1))
done

echo $new_file_content >  $NEW_FILE

sed 's/REAL_PASSWD/****/g' $NEW_FILE > $NEW_FILE
