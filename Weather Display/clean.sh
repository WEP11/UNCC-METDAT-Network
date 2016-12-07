#!/bin/bash
###################################3
# clean.csh
# Author: Warren Pettee
#
# Cleaning up the file structure at the end of the day..
# Because running the slideshow is graphics intensive and
# tends to go rogue after so many days of operating, we
# reboot our system daily at about 4AM. Part of the reboot
# routine is cleaning up all slides except the default/logo.
#
# Notice we have two folders, one per screen..
####################################
#
shopt -s extglob
rm /home/wxdisplay/UPPER_DISPLAY/LEFT/!(12.png)
rm /home/wxdisplay/UPPER_DISPLAY/RIGHT/!(12.png)
shopt -u extglob
