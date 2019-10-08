#!/bin/bash

PICTURE=/tmp/ilock.png
SCREENSHOT="scrot $PICTURE"

$SCREENSHOT

convert $PICTURE -scale 20% -blur 0x1 -resize 500% $PICTURE
i3lock -i $PICTURE
rm $PICTURE
