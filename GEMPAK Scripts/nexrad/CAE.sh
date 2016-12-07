#!/bin/csh -f
#########################################################################################################################
#                                                   CAE- GREENVILLE-SPARTANBURG,SC NEXRADIII
#########################################################################################################################

setenv DISPLAY :1.0
source /home/gempak/NAWIPS/Gemenviron

cd /METDAT/data/gempak/nexrad/NIDS/CAE/N0Q/
#
set CURRENT_RAD=`ls N0Q_* | tail -20`

# generate gifs in /tmp
rm /tmp/CAE/*
mkdir /tmp/CAE
cd /tmp/CAE

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|N0Q_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/CAE/N0Q/$FILE
PROJ     = rad
GAREA    = dset
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

scp N0Q_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/CAE
rm N0Q_*
cd /home/ldm/SCRIPTS/

#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/CAE/N1Q/
#
set CURRENT_RAD=`ls N1Q_* | tail -20`

# generate gifs in /tmp

cd /tmp/CAE

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|N1Q_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/CAE/N1Q/$FILE
PROJ     = rad
GAREA    = dset
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

scp N1Q_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/CAE
rm N1Q_*
cd /home/ldm/SCRIPTS/

#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/CAE/N3Q/
#
set CURRENT_RAD=`ls N3Q_* | tail -20`

# generate gifs in /tmp

cd /tmp/CAE

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|N3Q_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/CAE/N3Q/$FILE
PROJ     = rad
GAREA    = dset
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

scp N3Q_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/CAE
rm N3Q_*
cd /home/ldm/SCRIPTS/

############################################################################################################################################
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/CAE/N0U/
#
set CURRENT_RAD=`ls N0U_* | tail -20`

# generate gifs in /tmp

cd /tmp/CAE

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|N0U_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/CAE/N0U/$FILE
PROJ     = rad
GAREA    = dset
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

scp N0U_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/CAE
rm N0U_*
cd /home/ldm/SCRIPTS/
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/CAE/N1U/
#
set CURRENT_RAD=`ls N1U_* | tail -20`

# generate gifs in /tmp

cd /tmp/CAE

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|N1U_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/CAE/N1U/$FILE
PROJ     = rad
GAREA    = dset
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

scp N1U_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/CAE
rm N1U_*
cd /home/ldm/SCRIPTS/
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/CAE/N3U/
#
set CURRENT_RAD=`ls N3U_* | tail -20`

# generate gifs in /tmp

cd /tmp/CAE

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|N3U_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/CAE/N3U/$FILE
PROJ     = rad
GAREA    = dset
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

scp N3U_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/CAE
rm N3U_*
cd /home/ldm/SCRIPTS/
