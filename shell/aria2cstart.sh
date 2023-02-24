#!/bin/bash
session="/tmp/aria2.session"

if [ ! -f "$session" ]; then
	touch "$session"
fi
su - orange -c "/usr/bin/aria2c --conf-path=/home/orange/.aria2/aria2.conf D"
#/usr/bin/aria2c --conf-path=/home/orange/.aria2/aria2.conf D
