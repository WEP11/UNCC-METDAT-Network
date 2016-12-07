#!/bin/csh -f
##########################################################################
#                           ATL TDWR Plotting Agent                      #
##########################################################################
setenv DISPLAY :1.0
source /home/gempak/NAWIPS/Gemenviron


cd /METDAT/data/gempak/nexrad/NIDS/ATL/TR0/
#
set CURRENT_RAD=`ls TR0_* | tail -20`

# generate gifs in /tmp
rm /tmp/ATL/*
mkdir /tmp/ATL
cd /tmp/ATL


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
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/ATL/TR0/$FILE
PROJ     = rad
GAREA    = KATL+
CLEAR    = y
PANEL    = 0
TEXT     = 1.2/23/1/hw
LATLON   = 0
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
@ count++
end

scp TR0_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/ATL
rm TR0_*
cd /home/ldm/SCRIPTS/

#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/ATL/TR1/
#
set CURRENT_RAD=`ls TR1_* | tail -20`

# generate gifs in /tmp

cd /tmp/ATL

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
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/ATL/TR1/$FILE
PROJ     = rad
GAREA    = KATL+
CLEAR    = y
PANEL    = 0
TEXT     = 1.2/23/1/hw
LATLON   = 0
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
@ count++
end

scp TR1_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/ATL
rm TR1_*
cd /home/ldm/SCRIPTS/
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/ATL/TR2/
#
set CURRENT_RAD=`ls TR2_* | tail -20`

# generate gifs in /tmp

cd /tmp/ATL

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
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/ATL/TR2/$FILE
PROJ     = rad
GAREA    = KATL+
CLEAR    = y
PANEL    = 0
TEXT     = 1.2/23/1/hw
LATLON   = 0
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
@ count++
end

scp TR2_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/ATL
rm TR2_*
cd /home/ldm/SCRIPTS/
############################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/ATL/TV0/
#
set CURRENT_RAD=`ls TV0_* | tail -20`

# generate gifs in /tmp

cd /tmp/ATL

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
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/ATL/TV0/$FILE
PROJ     = rad
GAREA    = KATL+
CLEAR    = y
PANEL    = 0
TEXT     = 1.2/23/1/hw
LATLON   = 0
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
@ count++
end

scp TV0_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/ATL
rm TV0_*
cd /home/ldm/SCRIPTS/
############################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/ATL/TV1/
#
set CURRENT_RAD=`ls TV1_* | tail -20`

# generate gifs in /tmp

cd /tmp/ATL

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
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/ATL/TV1/$FILE
PROJ     = rad
GAREA    = KATL+
CLEAR    = y
PANEL    = 0
TEXT     = 1.2/23/1/hw
LATLON   = 0
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
@ count++
end

scp TV1_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/ATL
rm TV1_*
cd /home/ldm/SCRIPTS/
############################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/ATL/TV2/
#
set CURRENT_RAD=`ls TV2_* | tail -20`

# generate gifs in /tmp

cd /tmp/ATL

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
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/ATL/TV2/$FILE
PROJ     = rad
GAREA    = KATL+
CLEAR    = y
PANEL    = 0
TEXT     = 1.2/23/1/hw
LATLON   = 0
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
@ count++
end

scp TV2_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/ATL
rm TV2_*
cd /home/ldm/SCRIPTS/
