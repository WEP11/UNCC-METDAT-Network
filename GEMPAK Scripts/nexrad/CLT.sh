#!/bin/csh -f
##########################################################################
#                           CLT TDWR Plotting Agent                      #
##########################################################################
setenv DISPLAY :1.0
source /home/gempak/NAWIPS/Gemenviron


cd /METDAT/data/gempak/nexrad/NIDS/CLT/TR0/
#
set CURRENT_RAD=`ls TR0_* | tail -20`

# generate gifs in /tmp
rm /tmp/CLT/*
mkdir /tmp/CLT
cd /tmp/CLT

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|TR0_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/CLT/TR0/$FILE
PROJ     = rad
GAREA    = #35.337;-80.885;0.65;0.9
CLEAR    = y
PANEL    = 0
TEXT     = 1.2/23/1/hw
LCLTON   = 0
WATCH    = all
WARN     = all
HRCN     = all
ISIG     = all
LTNG     =
SVRL     = all
FFA      = all
BND      =  
TCMG     =  
QSCT     =  
WSTM     = all
WCN      = all
\$mapfil = hicnus.nws + hiisus.nws + hiuhus.nws + hipowo.cia
map      = 18         + 15/1/2     + 14/1/1     + 1/1/1
lutfil   = default
imcbar   = 1

r

e

EOF

gpend
composite -gravity center /home/ldm/SCRIPTS/overlay.png TR0_$count.gif TR0_$count.gif
@ count++
end

convert -delay 50 -loop 0 TR0_*.gif CLT_TR0.gif
mv CLT_TR0.gif /home/ldm/SCRIPTS/
scp TR0_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/CLT
rm TR0_*
cd /home/ldm/SCRIPTS/
scp CLT_TR0.gif wxdisplay@10.17.157.196:/home/wxdisplay/Forecast
scp CLT_TR0.gif wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/gif

#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/CLT/TR1/
#
set CURRENT_RAD=`ls TR1_* | tail -20`

# generate gifs in /tmp

cd /tmp/CLT

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|TR1_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/CLT/TR1/$FILE
PROJ     = rad
GAREA    = #35.337;-80.885;0.65;0.9
CLEAR    = y
PANEL    = 0
TEXT     = 1.2/23/1/hw
LCLTON   = 0
WATCH    = all
WARN     = all
HRCN     = all
ISIG     = all
LTNG     =
SVRL     = all
FFA      = all
BND      =  
TCMG     =  
QSCT     =  
WSTM     = all
WCN      = all
\$mapfil = hicnus.nws + hiisus.nws + hiuhus.nws + hipowo.cia
map      = 18         + 15/1/2     + 14/1/1     + 1/1/1
lutfil   = default
imcbar   = 1

r

e

EOF

gpend
composite -gravity center /home/ldm/SCRIPTS/overlay.png TR1_$count.gif TR1_$count.gif
@ count++
end

convert -delay 50 -loop 0 TR1_*.gif CLT_TR1.gif
mv CLT_TR1.gif /home/ldm/SCRIPTS/
scp TR1_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/CLT
rm TR1_*
cd /home/ldm/SCRIPTS/
scp CLT_TR1.gif wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/gif
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/CLT/TR2/
#
set CURRENT_RAD=`ls TR2_* | tail -20`

# generate gifs in /tmp

cd /tmp/CLT

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|TR2_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/CLT/TR2/$FILE
PROJ     = rad
GAREA    = #35.337;-80.885;0.65;0.9
CLEAR    = y
PANEL    = 0
TEXT     = 1.2/23/1/hw
LCLTON   = 0
WATCH    = all
WARN     = all
HRCN     = all
ISIG     = all
LTNG     =
SVRL     = all
FFA      = all
BND      =  
TCMG     =  
QSCT     =  
WSTM     = all
WCN      = all
\$mapfil = hicnus.nws + hiisus.nws + hiuhus.nws + hipowo.cia
map      = 18         + 15/1/2     + 14/1/1     + 1/1/1
lutfil   = default
imcbar   = 1

r

e

EOF

gpend
composite -gravity center /home/ldm/SCRIPTS/overlay.png TR2_$count.gif TR2_$count.gif
@ count++
end

convert -delay 50 -loop 0 TR2_*.gif CLT_TR2.gif
mv CLT_TR2.gif /home/ldm/SCRIPTS/
scp TR2_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/CLT
rm TR2_*
cd /home/ldm/SCRIPTS/
scp CLT_TR2.gif wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/gif
############################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/CLT/TV0/
#
set CURRENT_RAD=`ls TV0_* | tail -20`

# generate gifs in /tmp

cd /tmp/CLT

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|TV0_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/CLT/TV0/$FILE
PROJ     = rad
GAREA    = #35.337;-80.885;0.65;0.9
CLEAR    = y
PANEL    = 0
TEXT     = 1.2/23/1/hw
LCLTON   = 0
WATCH    = all
WARN     = all
HRCN     = all
ISIG     = all
LTNG     =
SVRL     = all
FFA      = all
BND      =  
TCMG     =  
QSCT     =  
WSTM     = all
WCN      = all
\$mapfil = hicnus.nws + hiisus.nws + hiuhus.nws + hipowo.cia
map      = 18         + 15/1/2     + 14/1/1     + 1/1/1
lutfil   = default
imcbar   = 1

r

e

EOF

gpend
composite -gravity center /home/ldm/SCRIPTS/overlay.png TV0_$count.gif TV0_$count.gif
@ count++
end

convert -delay 50 -loop 0 TV0_*.gif CLT_TV0.gif
mv CLT_TV0.gif /home/ldm/SCRIPTS/
scp TV0_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/CLT
rm TV0_*
cd /home/ldm/SCRIPTS/
scp CLT_TV0.gif wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad
scp CLT_TV0.gif wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/gif
############################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/CLT/TV1/
#
set CURRENT_RAD=`ls TV1_* | tail -20`

# generate gifs in /tmp

cd /tmp/CLT

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|TV1_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/CLT/TV1/$FILE
PROJ     = rad
GAREA    = #35.337;-80.885;0.65;0.9
CLEAR    = y
PANEL    = 0
TEXT     = 1.2/23/1/hw
LCLTON   = 0
WATCH    = all
WARN     = all
HRCN     = all
ISIG     = all
LTNG     =
SVRL     = all
FFA      = all
BND      =  
TCMG     =  
QSCT     =  
WSTM     = all
WCN      = all
\$mapfil = hicnus.nws + hiisus.nws + hiuhus.nws + hipowo.cia
map      = 18         + 15/1/2     + 14/1/1     + 1/1/1
lutfil   = default
imcbar   = 1

r

e

EOF

gpend
composite -gravity center /home/ldm/SCRIPTS/overlay.png TV1_$count.gif TV1_$count.gif
@ count++
end

convert -delay 50 -loop 0 TV1_*.gif CLT_TV1.gif
mv CLT_TV1.gif /home/ldm/SCRIPTS/
scp TV1_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/CLT
rm TV1_*
cd /home/ldm/SCRIPTS/
scp CLT_TV1.gif wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad
scp CLT_TV1.gif wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/gif
############################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/CLT/TV2/
#
set CURRENT_RAD=`ls TV2_* | tail -20`

# generate gifs in /tmp

cd /tmp/CLT

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|TV2_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/CLT/TV2/$FILE
PROJ     = rad
GAREA    = #35.337;-80.885;0.65;0.9
CLEAR    = y
PANEL    = 0
TEXT     = 1.2/23/1/hw
LCLTON   = 0
WATCH    = all
WARN     = all
HRCN     = all
ISIG     = all
LTNG     =
SVRL     = all
FFA      = all
BND      =  
TCMG     =  
QSCT     =  
WSTM     = all
WCN      = all
\$mapfil = hicnus.nws + hiisus.nws + hiuhus.nws + hipowo.cia
map      = 18         + 15/1/2     + 14/1/1     + 1/1/1
lutfil   = default
imcbar   = 1

r

e

EOF

gpend
composite -gravity center /home/ldm/SCRIPTS/overlay.png TV2_$count.gif TV2_$count.gif
@ count++
end

convert -delay 50 -loop 0 TV2_*.gif CLT_TV2.gif
mv CLT_TV2.gif /home/ldm/SCRIPTS/
scp TV2_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/CLT
rm TV2_*
cd /home/ldm/SCRIPTS/
scp CLT_TV2.gif wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad
scp CLT_TV2.gif wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/gif
