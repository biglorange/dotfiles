#!/usr/bin/bash
start='data +%s'
timestamp=`date +%s`
filepath=/arch-backup.tgz
filetimestamp=`stat -c %Y $filepath`
timechange=$[$timestamp - $filetimestamp]
if [[ $timechange -gt 604800 ]];then
	sudo tar --use-compress-program=pigz -cvpf /arch-backup.tgz --exclude=/arch-backup.tgz --exclude=/home --exclude=/mnt --exclude=/dev --exclude=/proc --exclude=/lost+found --exclude=/sys --exclude=/run --exclude=/boot --exclude=/var --exclude=/tmp /
	cp /arch-backup.tgz /home/orange/Google\ Drive/Google\ Drive/05_archlinuxBackup/
fi
cd /home/orange/Google\ Drive
grive
