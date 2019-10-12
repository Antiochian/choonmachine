#! /bin/bash

while : #loop forever
do

#First, check if the last run has left a "current.mov" file to play
if test ! -f "/home/pi/loadedchoons/current.mov"
then
	echo "Initial file not properly loaded, Importing locally..."
	cp loadedchoons/startup.mov loadedchoons/current.mov
else
	echo "Initial file loaded successfully"
fi

#MAIN LOOP
for f in $(sshpass -f 'SSHpassword.txt' ssh trin3161@linux.ox.ac.uk ls WIP2/*.mov | shuf) #randomly reorders contents of webserver folder
do
echo "Filename: $f"
#Play current file
omxplayer --vol -900 -o local -b /home/pi/loadedchoons/current.mov
#Download next file
sshpass -f '/home/pi/SSHpassword.txt' scp trin3161@linux.ox.ac.uk:$f /home/pi/loadedchoons/current.mov
done;
exit 0
for f in $(sshpass -f 'SSHpassword.txt' ssh trin3161@linux.ox.ac.uk ls IDENTS/*.mov | shuf) #randomly reorders contents of webserver folder
do
	#Download next file
	sshpass -f '/home/pi/SSHpassword.txt' scp -o PreferredAuthentications=password -v trin3161@linux.ox.ac.uk:$f /home/pi/loadedchoons/next.mov
	omxplayer --vol -900 -o local -b /home/pi/loadedchoons/current.mov #plau current file
	#Change "next" file to "current" for loop
	cp /home/pi/loadedchoons/next.mov /home/pi/loadedchoons/current.mov
	echo "Up Next: $f" #print current file
done
done
exit 0
