encrypt()
{
echo "enter image file"
read image
echo "enter binary file"
read binary
if [ `ls $image` -a `ls $binary` ]
then
	base64 $image > dup
	base64 $binary >> dup
	echo "binary file has been inserted into image file and stored in the file 'dup'"
else
	echo "file entered  not found"
fi
}

decrypt()
{
echo "enter stegnographed image file"
read duplicate_image
echo "enter the real image file"
read image
if [ $duplicate_image -a $image ]
then
	base64 $image > original_image 
	diff -ed original_image $duplicate_image > temp
	head -n -1 temp | tail -n +2 > temp_1
	base64 -d temp_1 > bin
	sudo chmod 755 bin
	rm temp_1 temp original_image
	echo "binary file has been extracted from "$duplicate_image" and binary file is stored in 'bin'"
	echo "Now u can execute this binary"
else
	echo "file not found"
fi
}

help()
{
echo "Type 1 to encrypt"
echo "Type 2 to decrypt"
echo "Type e to exit" 
}

input=10
while [ $input != 'e' ]
do
	help
	read input
	case $input in
	     "1")
	     encrypt
	     ;;
	     "2")
	     decrypt
	     ;;
	     "e")
	     echo "exiting"
	     ;;
	esac
done
