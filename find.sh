#This is shell script to search for a file containing a specified word in a single directory
#!/bin/sh
search_dir=$1
search_name=$2
echo $2" is found in the files: "
for file in `ls $search_dir`
do
cat $file | grep $search_name > /dev/null
command_status=`echo $?`
if [ $command_status -eq 0 ]
then
	echo $file
fi
done
