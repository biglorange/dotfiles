#!/usr/bin/bash
(sudo /home/orange/Software/rjsupplicant/rjsupplicant.sh -d 1 -s internet -u 2014014472 -p 180014 &) 2>>/var/log/ruijie.log;
sleep 1;
sudo NetworkManager;
sleep 0.8;
nmcli device connect enp8s0;
sleep 0.8;
