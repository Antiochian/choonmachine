# choonmachine
Tiny bash script to automate shuffle-play on my CCTV monitor - its only really here for reference.

I use this in my bedroom with a repurposed CCTV monitor hooked up to a raspberry pi to shuffle play my large folder of short 2-20 second idents upon the click of an infrared remote (which calls the script).

As a reminder to my future self, here is the setup:
- All video files placed in folder in .mov format
- choon.sh placed at ~/choon.sh
- /home/pi/.config/lxsession/LXDE-pi/autostart edited to include the line "@sh ~/choon.sh &"
- X server set up not to finish initialising until power button on infrared remote is pressed (to delay start of script)
 
[A video of this setup can be seen here.](https://streamable.com/rtfv1 "Streamable")
![Choonmachine Setup](choonmachine.png)
