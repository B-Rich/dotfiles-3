#!/bin/bash

echo -n " Started: "
date

# variables
cnt_cn=0
cnt_ru=0
cnt_us=0
cnt_it=0
cnt_eu=0
cnt_bg=0
cnt_lv=0
cnt_sk=0
cnt_jp=0
cnt_other=0

#core
num=0
while read line; do
 num=$(($num + 1))
 country=`whois ${line} | grep -i country | awk '{print $2}' | head -n 1 | tail -n 1`
 echo -e " ${num}:\t${line}\t\tCountry:  ${country}"
 case ${country} in 
 	"CN")
		cnt_cn=$(($cnt_cn + 1)) ;;
	"RU")
		cnt_ru=$(($cnt_ru + 1)) ;;
	"US")
		cnt_us=$(($cnt_us + 1)) ;;
	"IT")
		cnt_it=$(($cnt_it + 1)) ;;
	"EU")
		cnt_eu=$(($cnt_eu + 1)) ;;
	"BG")
		cnt_bg=$(($cnt_bg + 1)) ;;
	"LV")
		cnt_bg=$(($cnt_lv + 1)) ;;
	"SK")
		cnt_sk=$(($cnt_sk + 1)) ;;
	"JP")
		cnt_jp=$(($cnt_hp + 1)) ;;
	*)
		cnt_other=$(($cnt_other + 1));
 esac

done < attackers.txt

echo -e "\n Results  -------"
echo "China: ${cnt_cn}"
echo "Russia: ${cnt_ru}"
echo "US: ${cnt_us}"
echo "Italy: ${cnt_it}"
echo "EU: ${cnt_eu}"
echo "Bulgaria: ${cnt_bg}"
echo "Lavita: ${cnt_lv}"
echo "S Korea: ${cnt_sk}"
echo "Japan: ${cnt_jp}"
echo "Other: ${cnt_other}"
