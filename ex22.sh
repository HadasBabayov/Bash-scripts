#!/bin/bash
# Hadas Babayov 322807629

# Check if there are enough arguments.
if [ $# -lt 4 ]; then
	echo "Not enough parameters"
	exit -1
fi

# Save the arguments.
folder="$1"
suffix="$2"
substring="$3"
number="$4"

# Save the file names in the list, sorted in lexicographic order.
nameOfFiles=$(find $folder | sort -n)

for file in $nameOfFiles; do
	# If the current file is a folder - run ex21 on it.
	if [ -d $file ]; then
		bash ex21.sh $file/ $suffix $substring | awk -v num=$number 'NF>=num'
	fi
done
