#!/usr/bin/bash
(sudo /home/orange/Software/rjsupplicant/rjsupplicant.sh -d 1 -s internet -u 2014014476 -p 804072060 & ) 2>>/var/log/ruijie.log;
sleep 1;
sudo NetworkManager;
sleep 0.8;
nmcli device connect enp8s0;
sleep 0.8;
