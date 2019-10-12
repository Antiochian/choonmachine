#! /bin/bash
#First, check if the last run has left a "current.mov" file to play
if test ! -f "/home/pi/loadedchoons/current.mov"
then #if no file is found, import local "startup" video to begin with
	echo "Initial file not properly loaded, Importing locally..."
	cp loadedchoons/startup.mov loadedchoons/current.mov
else
	echo "Initial file loaded successfully"
fi

#MAIN LOOP
#randomly reorders contents of webserver folder and iterates through filenames
for f in $(sshpass -f 'SSHpassword.txt' ssh trin3161@linux.ox.ac.uk ls IDENTS/*.mov | shuf) 
do
	omxplayer --vol -900 -o local -b /home/pi/loadedchoons/current.mov & #plau current file
	#Download next file WHILE video is playing to save time
	sshpass -f '/home/pi/SSHpassword.txt' scp -o PreferredAuthentications=password -v trin3161@linux.ox.ac.uk:$f /home/pi/loadedchoons/next.mov &
	wait #wait for both video and download to finish
	#Change "next" file to "current" for loop
	cp /home/pi/loadedchoons/next.mov /home/pi/loadedchoons/current.mov
	echo "Up Next: $f" #print current file
done
exit 0
