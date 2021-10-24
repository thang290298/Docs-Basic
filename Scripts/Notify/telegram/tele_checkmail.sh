#!/bin/bash
# Check su dung tai nguyen mail server OVZ

CHAT_ID1=1107771830
TOKEN1=1702666185:AAHSF_J5YvVoSnnGWdtW8fKnHNrFeAAetIc
NOW="$(date +"%d-%m-%Y")"



ls -alh /checkmail/ | grep .csv | awk '{print $9}' > /checkmail/mail.txt
for line in `cat /checkmail/mail.txt`
do
text1="Kiểm tra sử dụng tài nguyên Email Server trên Node $line ngày $NOW"
curl -X POST "https://api.telegram.org/bot${TOKEN1}/sendMessage" -d "chat_id=${CHAT_ID1}&text=${text1}"

USED=$(csvtomd /checkmail/$line)
USED="""\`$USED\`"""
curl -s -X POST https://api.telegram.org/bot${TOKEN1}/sendMessage -d chat_id=${CHAT_ID1} -d text="$USED" -d parse_mode=markdown

done