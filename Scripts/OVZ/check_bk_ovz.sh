#!/bin/bash
rm -f /usr/local/src/MSG.csv 
/usr/sbin/vzlist -a | grep running |awk '{print $1}' > /usr/local/src/id.txt
ls -alh /backup | grep .tgz | awk '{print $5,$6,$7,$8,$9}' > /usr/local/src/bk.txt

#compare id vs file backup
for line in `cat /usr/local/src/id.txt`
do 
ip=`/usr/sbin/vzctl exec $line "curl ifconfig.me"`
cat /usr/local/src/bk.txt | grep "vzdump-$line.tgz" > /dev/null 2>&1
if [ $? = 0 ]
then
status="Ok"
size=`cat /usr/local/src/bk.txt |grep $line | awk '{print $1}'`
date=`cat /usr/local/src/bk.txt |grep $line | awk '{print $2,$3,$4}'`
echo "$line, $ip, $status, $size, $date" >> /usr/local/src/MSG.csv

else
status="Not Ok"
echo "$line, $ip, $status" >> /usr/local/src/MSG.csv
fi
done

sed -i '1iVMID, IP, Status, Dung lượng, Thời điểm BK' /usr/local/src/MSG.csv
scp /usr/local/src/MSG.csv root@103.101.161.38:/checkbk/`hostname`
