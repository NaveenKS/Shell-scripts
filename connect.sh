#!/bin/sh
#set -x
v="off"
sudo stop network-manager
sudo ifconfig wlan0 up
sudo iwlist wlan0 scan > input.txt
status=`cat input.txt | grep "key.*" | awk -F : '{print $2}'`
i=1
for essid in `cat input.txt | grep "ESSID.*" | awk -F : '{print $2}'`
do
key=`echo $status | cut -d " " -f $i`
echo $key
if [ $key = "off" ]
then
	
	echo $essid 
	sudo iwconfig wlan0 essid "kari"
	sudo dhclient wlan0	
fi
i=`expr $i + 1`
done



	

