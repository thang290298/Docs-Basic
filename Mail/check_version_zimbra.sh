#!/bin/bash
touch /mnt/zimbra/id.txt
/usr/sbin/vzlist -a | grep running | awk '{print $1}' > /mnt/zimbra/id.txt
for line in `cat /mnt/quyenbx/id.txt`
do
ip=`/usr/sbin/vzlist -a | grep ${line} | awk '{print $4}'`
zimbra=`/usr/sbin/vzctl exec ${line} "netstat -tupln" | grep 7071 |awk '{print $4}' | cut -d: -f2`

if [ "$zimbra" = 7071 ];
then
version=`/usr/sbin/vzctl exec ${line} "su - zimbra -c 'zmcontrol -v'"`
echo "VPS $ip zimbra_$version"

else
continue
fi
done
