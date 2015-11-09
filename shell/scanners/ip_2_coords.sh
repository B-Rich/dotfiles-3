#!/bin/bash

cd $HOME/documents/counter-stance/
cat /dev/null > data.txt

iplist=()

getIP() {
 i=0
 while read line; do
  iplist[i]=$line
  i=$(($i + 1))
 done  < $1
}

getIP "$HOME/development/counter/counter-ip"

for ip in "${iplist[@]}"; do
 # { echo "GET /xml/$iplist"; echo ""; sleep 1; } | telnet freegeoip.net 80
 { echo "GET /xml/$ip HTTP/1.1"; echo ""; sleep 1; } | telnet ip-api.com 80 | tee location.log

 echo -e "IP: $ip" >> data.txt
 # cat location.log | grep lat | sed 's/[^0-9]*//g' >> data.txt
 # cat location.log | grep lon | sed 's/[^0-9]*//g' >> data.txt
 # grep -E -o '\<[0-9]{1,2}\.[0-9]{2,5}\>' location.log >> data.txt
 cat location.log | grep lon | grep -E -o '\<[0-9]{1,2}\.[0-9]{2,5}\>' >> data.txt
 cat location.log | grep lat | grep -E -o '\<[0-9]{1,2}\.[0-9]{2,5}\>' >> data.txt
 echo -e "" >> data.txt
 cat /dev/null > location.log
 #i=$(($i + 1))
done
