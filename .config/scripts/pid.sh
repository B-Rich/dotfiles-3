#!/bin/bash

if [[ ${1} == "bot" ]]
 then
  bot_pid=`pgrep -f "ruby .*bot.rb" | head -n 1 | tail -n 1`
  if [[ ${bot_pid} != "" ]]; then
   echo ${bot_pid}
  else
   bot_pid=`pgrep -f "bot.*vim" | head -n 1 | tail -n 1`
   if [[ ${bot_pid} != "" ]]; then
       echo ${bot_pid}
   else
       echo "Offline"
   fi
  fi
else 
  requested_pid=`pgrep ${1} | head -n 1 | tail -n 1`
  if [[ ${requested_pid} != "" ]]; then
   echo ${requested_pid}
  else
   echo "Offline"
  fi
fi
