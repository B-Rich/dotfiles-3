#!/bin/bash
orig=`cat /home/schism/documents/user-auth.log`
update=$(($orig + 1))
echo $update > /home/schism/documents/user-auth.log
