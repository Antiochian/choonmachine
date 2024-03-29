#! /bin/bash
#Overall program flow
#	1. Checks for internet connection and switches into ONLINE or OFFLINE mode
#	2. Iterates through a shuffled list all valid filenames in target folder, either my SSH server (ONLINE mode) or a local directory (OFFLINE omde)
#	3. While first video is playing, downloads second video in background
#	4. After video finishes, replace "current.mov" file and repeat until all files have been played
#	5. end

#CHECK INTERNET CONNECTION
if ping -1 -c 1 -W 2 google.com
then #ONLINE MODE
	echo "Network connection successful"
	#First, check if the last run has left a "current.mov" file to play
	if test ! -f "/home/pi/loadedchoons/current.mov"
	then #if no file is found, import local "startup" video to initialise
		echo "Initial file not properly loaded, Importing locally..."
		cp loadedchoons/startup.mov loadedchoons/current.mov
	else
		echo "Initial file loaded successfully"
	fi
	
	#randomly reorders contents of webserver folder and iterates through filenames
	for f in $(sshpass -f 'SSHpassword.txt' ssh trin3161@linux.ox.ac.uk ls CURRENT/*.mov | shuf) 
	do
		#Download next file in background WHILE video is playing to save time
		sshpass -f '/home/pi/SSHpassword.txt' scp -o PreferredAuthentications=password -v XXXX@XXXX:$f /home/pi/loadedchoons/next.mov &
		omxplayer --vol -900 -o local -b /home/pi/loadedchoons/current.mov #play current file
		wait #wait for download to finish if it hasnt already
		#Change "next" file to "current" for loop
		cp /home/pi/loadedchoons/next.mov /home/pi/loadedchoons/current.mov
		echo "Up Next: $f" #print current file
	done
else #OFFLINE MODE
	echo "Failed connection to network, reverting to offline storage..."
	for f in $(ls OfflineMovs/*.mov | shuf)
	do
		echo "Up Next: $f"
		omxplayer --vol -900 -o local -b $f
fi
exit 0
