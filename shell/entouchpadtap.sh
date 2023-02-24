^#!usr/bin/bash
id=$(/usr/bin/xinput | grep Touchpad | cut -c55-56)
prop=$(/usr/bin/xinput list-props ${id} | grep 'Tapping Enabled Default' | cut -c36-38)
prop=$[${prop}-1]
#echo "${prop}"
/usr/bin/xinput set-prop ${id} ${prop} 1
ret=$?
echo "${ret}"
if [ '$(ret)' != '0' ] ; then
	echo "xinput set-prop failed ret=${ret}"
fi
