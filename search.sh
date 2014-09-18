#This is shell script to search for a file containing a specified word in a single directory
#!/bin/bash
#recursive function
search(){
local search_dir=$1
local search_name=$2
for file in `ls $search_dir`
	do
	if [ -d $search_dir/$file ]
	then
		search $search_dir/$file $2
	elif [ -f $search_dir/$file ]
	then
		cat $search_dir/$file | grep $search_name > /dev/null
		command_status=`echo $?`
		if [ $command_status -eq 0 ]
		then
			echo $1/$file
		fi
	fi
done
}

search $1 $2
