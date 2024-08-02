#!/bin/bash

# Link: https://askubuntu.com/questions/261363/screen-resolution-repositioning-broken-laptop-screen
# You can make this more robust by adding the newly created mode to some file in
# /usr/share/X11/xorg.conf.d/ so the computer doesn't have to create a new modeline
# every time the system is started. But this will do for now. Let it be. Relax.
#
# This worked the first time I tried it. It's broken now. Come back to it later.

# Got it to work again. Resolution should be a multiple of 8. I don't know why. -_-

# Though it still doesn't work with the second monitor. Need to do something about that. But it's done for now.

# The multiple-screens-working-as-one-large-screen problem might be related to xinerama: https://en.wikipedia.org/wiki/Xinerama.
# See also the comments in the `10-amdgpu.conf` file in `/usr/share/X11/xorgblablabla/`.

#change these 4 variables accordingly
ORIG_X=1600
ORIG_Y=900
NEW_X=1520
NEW_Y=900
###

X_DIFF=$(($NEW_X - $ORIG_X))
Y_DIFF=$(($NEW_Y - $ORIG_Y))

X_DIFF=$(($NEW_X - $ORIG_X))
Y_DIFF=$(($NEW_Y - $ORIG_Y))

ORIG_RES="$ORIG_X"x"$ORIG_Y"
NEW_RES="$NEW_X"x"$NEW_Y"
MODELINE=$(cvt $NEW_X $NEW_Y | grep Modeline | cut -d' ' -f3-)

xrandr --newmode $NEW_RES $MODELINE
xrandr --addmode eDP-1 $NEW_RES
xrandr --output eDP-1 --fb $NEW_RES --panning $NEW_RES --pos 0x0 --mode $NEW_RES
xrandr --output eDP-1 --fb $NEW_RES --pos 0x0 --mode $NEW_RES
# xrandr --fb $NEW_RES --output eDP-1 --mode $ORIG_RES --transform 1,0,$X_DIFF,0,1,$Y_DIFF,0,0,1 --output HDMI2 --right-of eDP1 --mode 1366x768
xrandr --fb $NEW_RES --output eDP-1 --mode $ORIG_RES --transform 1,0,$X_DIFF,0,1,$Y_DIFF,0,0,1