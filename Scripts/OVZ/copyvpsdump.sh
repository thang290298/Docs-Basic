sshpass -p "6W6paBR^3^$ssEB"  rsync --progress -avz -e ssh /backup/*.tgz root@172.16.2.10:/backup3/weekly3930/ >> /var/log/copyvpsdump.log 2>&1
cat /var/log/copyvpsdump.log | mail -s "copy ovz3930 vpsdump Job Completed" thangnv@nhanhoa.com.vn
