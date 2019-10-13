#! /bin/bash
# This version of the program accepts a RegEx string as an argument for tagfiltering

if [ ! $# == 0 ] #if an argument is supplied
then
  FILTER=$1
  echo "Custom filter applied: $1"
else
  FILTER='*.*'
fi
rm "/home/pi/loadedchoons/current.mov"
#CHECK INTERNET CONNECTION
if ping -1 -c 1 -W 2 google.com
then #ONLINE MODE
	echo "Network connection successful"
	#randomly reorders contents of webserver folder and iterates through filenames
	for f in $(sshpass -f 'SSHpassword.txt' ssh trin3161@linux.ox.ac.uk ls CURRENT/*.mov | grep -E $FILTER | shuf) 
	do
		if test ! -f "/home/pi/loadedchoons/current.mov" #only runs on first play
		then
			echo "Up Next: $f"
			sshpass -f '/home/pi/SSHpassword.txt' scp -o PreferredAuthentications=password -v XXXX@XXXX:$f /home/pi/loadedchoons/current.mov
			omxplayer --vol -900 -o local -b /home/pi/loadedchoons/current.mov #play current file
			wait #wait for download to finish if it hasnt already
			#Change "next" file to "current" for loop
			cp /home/pi/loadedchoons/next.mov /home/pi/loadedchoons/current.mov
			echo "Up Next: $f" #print current file
		else
		#Download next file in background WHILE video is playing to save time
		sshpass -f '/home/pi/SSHpassword.txt' scp -o PreferredAuthentications=password -v XXXX@XXXX:$f /home/pi/loadedchoons/next.mov &
		omxplayer --vol -900 -o local -b /home/pi/loadedchoons/current.mov #play current file
		wait #wait for download to finish if it hasnt already
		#Change "next" file to "current" for loop
		cp /home/pi/loadedchoons/next.mov /home/pi/loadedchoons/current.mov
		echo "Up Next: $f" #print current file
		fi
	done
else #OFFLINE MODE
	echo "Failed connection to network, reverting to offline storage..."
	for f in $(ls OfflineMovs/*.mov | shuf)
	do
		echo "Up Next: $f"
		omxplayer --vol -900 -o local -b $f
fi
exit 0
