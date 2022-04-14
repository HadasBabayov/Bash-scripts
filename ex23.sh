#!/bin/bash
# Hadas Babayov 322807629

# Check if the input is valid.
if [[ "$1" != "system" && "$1" != "host" ]]; then
	echo "Invalid input"
	exit -1
fi

hostFile="hostnamectl"
systemFile="os-release"

# If there is a single argument, we will print the full files.
if [[ $# -eq 1 && "$1" == "system" ]]; then
	cat $systemFile
	exit 0
fi

if [[ $# -eq 1 && "$1" == "host" ]]; then
	cat $hostFile
	exit 0
fi

# Flags -- prevent print a line more than once.
nameFlag=0 
versionFlag=0 
prettyNameFlag=0 
homeUrlFlag=0 
supportUrlFlag=0 
staticHostNameFlag=0 
iconNameFlag=0 
machineIdFlag=0 
bootIdFlag=0 
virtualizationFlag=0 
kernelFlag=0 
architectureFlag=0 

# If the first argument is "system"
if [[ "$1" == "system" ]]; then
	# We will go over the rest of the arguments and print the requested lines.
	for arg in "$@"; do
		# Update the flags if a line has been printed.
		case $arg in
			--name)
				if [ $nameFlag == 0 ]; then
					awk -F"=" '/^NAME/{print $2; exit}' $systemFile | xargs
					nameFlag=1
				fi
			shift 
			;;
			--version)
				if [ $versionFlag == 0 ]; then 
					awk -F"=" '/VERSION/{print $2; exit}' $systemFile | xargs
					versionFlag=1
				fi
			shift 
			;;
			--pretty_name)
				if [ $prettyNameFlag == 0 ]; then
					awk -F"=" '/PRETTY_NAME/{print $2;}' $systemFile | xargs
					prettyNameFlag=1
				fi
			shift 
			;;
			--home_url)
				if [ $homeUrlFlag == 0 ]; then
					awk -F"=" '/HOME_URL/{print $2;}' $systemFile | xargs
					homeUrlFlag=1
				fi
			shift 
			;;
			--support_url)
				if [ $supportUrlFlag == 0 ]; then
					awk -F"=" '/SUPPORT_URL/{print $2;}' $systemFile | xargs
					supportUrlFlag=1
				fi
			shift 
			;;
			*)
			shift 
			;;
		esac
	done
	
	# If nothing is printed, and all the flags are incorrect - print the full file.
	if [[ $nameFlag == 0 && $versionFlag == 0 && $prettyNameFlag == 0 && $homeUrlFlag == 0 && $supportUrlFlag == 0 ]]; then
		cat $systemFile
	fi
fi

# If the first argument is "host"
if [[ "$1" == "host" ]]; then	
	# We will go over the rest of the arguments and print the requested lines.
	for arg in "$@"; do
		# Update the flags if a line has been printed.
		case $arg in
			--name)
			if [ $nameFlag == 0 ]; then
					awk -F": " '/Icon name/{print $2;}' $hostFile
					nameFlag=1
					iconNameFlag=1
				fi
			shift 
			;;
			--static_hostname)
				if [ $staticHostNameFlag == 0 ]; then
					awk -F": " '/Static hostname/{print $2;}' $hostFile
					staticHostNameFlag=1
				fi
			shift 
			;;
			--icon_name)
				if [ $iconNameFlag == 0 ]; then
					awk -F": " '/Icon name/{print $2;}' $hostFile
					iconNameFlag=1
					nameFlag=1
				fi
			shift 
			;;
			--machine_id)
				if [ $machineIdFlag == 0 ]; then
					awk -F": " '/Machine ID/{print $2;}' $hostFile
					machineIdFlag=1
				fi
			shift 
			;;
			--boot_id)
				if [ $bootIdFlag == 0 ]; then
					awk -F": " '/Boot ID/{print $2;}' $hostFile
					bootIdFlag=1
				fi
			shift 
			;;
			--virtualization)
				if [ $virtualizationFlag == 0 ]; then
					awk -F": " '/Virtualization/{print $2;}' $hostFile
					virtualizationFlag=1
				fi
			shift 
			;;
			--kernel)
				if [ $kernelFlag == 0 ]; then
					awk -F": " '/Kernel/{print $2;}' $hostFile
					kernelFlag=1
				fi
			shift 
			;;
			--architecture)
				if [ $architectureFlag == 0 ]; then
					awk -F": " '/Architecture/{print $2;}' $hostFile
					architectureFlag=1
				fi
			shift 
			;;
			*)
			shift 
			;;
		esac
	done
	
	# If nothing is printed, and all the flags are incorrect - print the full file.
	if [[ $nameFlag == 0 && $staticHostNameFlag == 0 && $iconNameFlag == 0 && $machineIdFlag == 0 && $bootIdFlag == 0 && $virtualizationFlag == 0 && $kernelFlag == 0 && $architectureFlag == 0 ]]; then
		cat $hostFile
	fi
fi


