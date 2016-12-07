#!/bin/bash
##########################################
# wxdisplay.sh
# Author: Warren Pettee
#
# This script will allow a slideshow of folder contents
# using the Eye of Gnome tool. Note that a default slide
# is always included as a baseline, we use a logo. You
# can then dump any slides you want into the folder throughout
# the day to keep the display up to date.
#
###########################################

# This is a dual screen setup, watch how we arrange the windows...
cd ~/UPPER_DISPLAY/LEFT
#open two fullscreen windows
eog -s --new-instance 12.png&
#wait until windows are actually created
while [ 1 ]; do 
   found=$(wmctrl -l |grep '12.png'); 
   if ! [[ -z "$found" ]]; then 
      break; 
   fi; 
done;
#move first win to the left
wmctrl -r '12.png' -e 1,0,0,-1,-1

cd ../RIGHT
eog -s --new-instance 12.png&
#wait
while [ 1 ]; do 
   found=$(wmctrl -l |grep '12.png'); 
   if ! [[ -z "$found" ]]; then 
      break; 
   fi; 
done;
#move
wmctrl -r '12.png' -e 1,1280,0,-1,-1

# eog has other arguments that would allow it to sit on a single image
# i.e. if you had a radar loop you wanted always visible
