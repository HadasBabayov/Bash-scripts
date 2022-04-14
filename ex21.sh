#!/bin/bash
# Hadas Babayov 322807629

# Check if there are enough arguments.
if [ $# -lt 3 ]; then
	echo "Not enough parameters"
	exit -1
fi

# Save the arguments.
folder="$1"
suffix="$2"
substring="$3"

# Move to the relevant folder.
if [[ *"/"*==$folder ]]; then
	cd $folder
fi

# Save the file names in the list, sorted in lexicographic order.
folderAfterSort=$(ls | sort -k 1,1 -t .)


for file in $folderAfterSort; do
	# If the file isn't a folder and with the required suffix, print the lines that contain the requested word.
	if [[ ! -d $file && $file == *.$suffix ]]; then
		cat $file | grep -wi "$substring"
	fi
done


