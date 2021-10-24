#!/bin/bash
# Check backup OVZ
CHAT_ID=-1001150830336
TOKEN=1587575809:AAHzVGnxUH7j6pzHRYRTqCNSZEINvZlnPBM

NOW="$(date +"%d-%m-%Y")"
text="Kiểm tra Backup của Node 39.17 ngày $NOW"
curl -X POST "https://api.telegram.org/bot${TOKEN}/sendMessage" -d "chat_id=${CHAT_ID}&text=${text}"

MSG=$(csvtomd /checkbk/Mail3917/MSG.csv)
MSG="""\`$MSG\`"""
curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHAT_ID} -d text="$MSG" -d parse_mode=markdown 



# Check su dung tai nguyen mail server OVZ

CHAT_ID1=1107771830
TOKEN1=1702666185:AAHSF_J5YvVoSnnGWdtW8fKnHNrFeAAetIc

text1="Kiểm tra sử dụng tài nguyên Email Server trên Node 39.17 ngày $NOW"
curl -X POST "https://api.telegram.org/bot${TOKEN1}/sendMessage" -d "chat_id=${CHAT_ID1}&text=${text1}"

USED=$(csvtomd /checkbk/Mail3917/USED.csv)
USED="""\`$USED\`"""
curl -s -X POST https://api.telegram.org/bot${TOKEN1}/sendMessage -d chat_id=${CHAT_ID1} -d text="$USED" -d parse_mode=markdown



