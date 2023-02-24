#!/usr/bin/bash
#echo $1
if [ $1 == "disable" ]
then
	usbkeyboard=''
	usbkeyboard=$(/usr/bin/xinput | grep -nE 'RK-Bluetooth|SONiX' | sed -n '2p')
	if [ -n "$usbkeyboard" ]
	then
		echo "External Keyboard Plugged"
		id=$(/usr/bin/xinput | grep AT | cut -c53-54)
		xinput set-prop $id "Device Enabled" 0
		echo "Inner Keyboard disabled"
	else
		echo "External Keyboard NOT Plugged, please check!"
	fi
elif [ $1 == "enable" ]
then
	id=$(/usr/bin/xinput | grep AT | cut -c53-54)
	xinput set-prop $id "Device Enabled" 1
	echo "Inner Keyboard enabled"
fi
