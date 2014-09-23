#!/bin/sh
#set -x
sudo stop network-manager
sudo ifconfig wlan0 up
sudo iwlist wlan0 scan > input.txt
status=`cat input.txt | grep "key.*" | awk -F : '{print $2}'`
i=1
signal=0
for essid in `cat input.txt | grep "ESSID.*" | awk -F : '{print $2}'`
do
key=`echo $status | cut -d " " -f $i`
essid=`echo $essid | cut -c 2- | rev | cut -c 2- | rev`
#echo $essid
if [ $key = "off" -a $essid != "\x00" ]
then
	
	echo $essid 
	sudo iwconfig wlan0 essid $essid
	sudo dhclient wlan0
	flag=`echo $?`
	if [ $flag -eq 0 ]
	then
		signal=1
		break	
	fi
fi
i=`expr $i + 1`
done

if [ $signal -eq 0 ]
then
	sudo start network-manager 
fi


	

