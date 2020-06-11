#!/bin/bash
set -e
set -u

OLD_FILE=/tmp/old

NEW_FILE=/tmp/new

if [ -f $OLD_FILE ] ; then
	echo OK: file $OLD_FILE exists
else
	echo ERROR: file $OLD_FILE doesn't' exist
	exit 1
fi

if [ -f $NEW_FILE ] && rm -f $NEW_FILE; then
	echo OK: $NEW_FILE is file and deleted
fi

content=`cat /tmp/old`

if [ "$content" == "" ] ; then
	echo ERROR: $OLD_FILE is empty
	exit 1
else
	echo OK: $OLD_FILE have content
fi

count=1

for line in $content ; do
	new_file_content=$(echo -e "$count: $line")
	count=$(($count + 1))
	echo $new_file_content >> $NEW_FILE
done

sed -i 's/REAL_PASSWD/****/g' $NEW_FILE
#с точки зрения безопасности REAL_PASSWD надо-бы читать из фаила или из пользовательского ввода при запуске.
