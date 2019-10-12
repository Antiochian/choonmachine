# choonmachine
Tiny bash script to automate shuffle-play on my CCTV monitor/music video player.

The program connects to my web server via SSH and starts to randomly play through a folder of music videos I have stored there. If there is no internet connection, it instead plays through a folder of music videos kept in offline-storage.
|Required File/Folder     | Description                                                 |
|-------------------------|---------------------------------------------------------------|
| /home/pi/loadedchoons/  | Buffer folder, will be generated automatically if not present |
| trinXXXX@linux.ox.ac.uk | The username and location of my SSH server                    |
| SSHpassword.txt         | password file for previously-mentioned SSH server             |
| /home/pi/OfflineMovs/   | A folder containing backup, offline media files               |

[A video of an earlier, much  setup can be seen here.](https://streamable.com/rtfv1 "Streamable")
![Choonmachine Setup](choonmachine.png)

