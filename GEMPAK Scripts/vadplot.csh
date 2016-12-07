#!/bin/csh -f
setenv DISPLAY :0
source /home/gempak/NAWIPS/Gemenviron


cd /home/ldm/SCRIPTS/
rm vadplot.gif

#
# GOES8 variable set in Gemenviron
#   GOES images follow NSAT naming convention
#     Platform/Resolution/type_yymmdd_hhmm
#

gpvad << EOF
RADFIL   = NEXRIII|CLT|NVW
RADTIM   = last
WIND     = bk1
TITLE    = 1/-2/VAD DISPLAY ~
PANEL    = 0
DEVICE   = gf|vadplot.gif|1280;1024
CLEAR    = y
TEXT     = 1/1/1/hw
CLRBAR   = 1/v/cl/.05;.5/.3;.01
r

e
EOF

gpend


