#! /bin/bash

while : #loop forever
do

cp loadedchoons/startup.mov loadedchoons/current.nov

for f in $(sshpass -f 'SSHpassword.txt' ssh trin3161@linux.ox.ac.uk ls IDENTS/*.mov | shuf) #randomly reorders contents of webserver folder
do
	echo "Filename: $f" #print current file
	#Download next file
	sshpass -f '/home/pi/SSHpassword.txt' scp -o PreferredAuthentications=password -v trin3161@linux.ox.ac.uk:$f /home/pi/loadedchoons/next.mov
	omxplayer --vol -900 -o local -b /home/pi/loadedchoons/current.mov #plau current file
	#Change "next" file to "current" for loop
	cp /home/pi/loadedchoons/next.mov /home/pi/loadedchoons/current.mov
done
done
exit 0
