#!/bin/bash
journalctl _COMM=sshd | grep "Failed password" | wc -l > /home/schism/Documents/failed.log
journalctl _COMM=sshd | grep "Accepted password" | wc -l > /home/schism/Documents/accepted.log
