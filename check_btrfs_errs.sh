#!/bin/sh

# Check for btrfs device errors

/sbin/btrfs dev stats / 2>/dev/null | {

errors=""
status=4

while read line ; do
   if [ "$status" = 4 ]; then
       status=0
   fi

   if [ "`echo $line | awk '{ print $2 }'`" != "0" ]; then
       line=`echo "$line" | xargs`
       errors="$errors | $line"
       status=2
   fi
done

if [ "$status" = 0 ]; then
    echo "OK | no btrfs errors"
    exit 0
elif [ "$status" = 2 ]; then
    echo "CRIT$errors"
    exit 2
else
    echo "UNKNOWN"
    exit 4
fi
}
