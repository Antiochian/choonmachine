#! /bin/bash
for f in $(ls FOLDERLOCATION/*.mov | shuf);
do echo "CHOON: $f";
omxplayer --vol -900 -o local -b $f;
done;
exit 0
