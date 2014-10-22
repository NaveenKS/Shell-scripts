#!/bin/sh

site="http://download1.o2tvseries.com"
space="%20"
trail="(O2TvSeries.Com).mp4"

Input() {
echo "Enter serial-name(ex Modern Family):"
read serial
echo "Enter season no(ex 6)"
read season
if [ $season -lt 10 ]
then
season="0"$season
fi
serial=$(echo $serial | sed -e 's/ /%20/g')
}

recently_added() {
wget -q "http://o2tvseries.com/search/recently_added" -O temp
pcregrep -M "<div class=\"data main\">[\s]*.*<\/div>" temp > temp1
cat temp1 | gawk 'match($0,/<b>(.*)<\/b>(.*)<\/div>/,a) {print a[1] a[2]}'
rm temp temp1
}

list () {
wget -q "http://o2tvseries.com/search/list_all_tv_series" -O temp
pcregrep -M "<div class=\"data\">[\s]*.*<\/a>" temp > temp1
cat temp1 | gawk 'match($0,/(<a href=".*">)(.*)(<\/a>)/,a) {print a[2]}'
rm temp temp1
}

search () {
echo "searching"
}

single () {
echo "Enter episode no(ex 2)"
read episode

if [ $episode -lt 10 ]
then 
episode="0"$episode
echo $episode
fi

url="$site"/"$serial"/Season"$space$season$year"/"$serial$space"-"$space"S"$season"E"$episode$space$trail"
echo $url
echo "This might take  few seconds.Please be patient, Don't exit."
wget -q --spider $url
status=$(echo $?)
if [ $status -eq 0 ]
then
axel $url
#echo "somethin"
else
url="$site"/"$serial"/Season"$space$season$year"/"$serial$space"-"$space"S"$season"E"$episode"%20-%201"$space$trail"
axel $url
fi
}

batch () {
echo "Enter Start episode no:"
read from 
echo "Enter End episode no:"
read to
if [ $from -lt 10 ]
then
episode="0"$from
else
episode=$from
fi
url="$site"/"$serial"/Season"$space$season$year"/"$serial$space"-"$space"S"$season"E"$episode$space$trail"
echo "This might take  few seconds.Please be patient, Don't exit."
wget -q --spider $url
status=$(echo $?)
if [ $status -eq 0 ]
then
flag=1
else
flag=0
fi


while [ $from -le $to ]
do
if [ $from -lt 10 ]
then
episode="0"$from
else
episode=$from
fi
echo $episode
if [ $flag -eq 1 ]
then
axel $url
else
url="$site"/"$serial"/Season"$space$season$year"/"$serial$space"-"$space"S"$season"E"$episode"%20-%201"$space$trail"
axel $url
fi
from=`expr $from + 1`
done
}

choice='n'

while [ $choice != 'q' ]
do
echo "\n-----------------------------------------------------\n"
echo "Enter 1 to list all the serial names:"
echo "Enter 2 to see the recently added episodes:"
echo "Enter 3 for downloading a single episode:"
echo "Enter 4 for downloading multiple episodes in a season:"
echo "Enter q to quit:"
echo "\n-----------------------------------------------------\n"
read choice
case $choice in 
1) #echo "1"
   list;;
2) #echo "2"
   recently_added;;
3) #echo "3"
   Input 
   single;;
4) #echo "4"
   Input
   batch;;
q) echo "exiting";;
*) echo "invalid option"
esac
done


