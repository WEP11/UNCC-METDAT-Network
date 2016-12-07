#!/bin/csh -f
#########################################################################################################################
#                                                   GSP- GREENVILLE-SPARTANBURG,SC NEXRADIII
#########################################################################################################################

setenv DISPLAY :1.0
source /home/gempak/NAWIPS/Gemenviron

cd /METDAT/data/gempak/nexrad/NIDS/GSP/N0Q/
#
set CURRENT_RAD=`ls N0Q_* | tail -20`

# generate gifs in /tmp
rm /tmp/GSP/*
mkdir /tmp/GSP
cd /tmp/GSP

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
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/GSP/N0Q/$FILE
PROJ     = rad
GAREA    = KGSP+
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

scp N0Q_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm N0Q_*
cd /home/ldm/SCRIPTS/

#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/N1Q/
#
set CURRENT_RAD=`ls N1Q_* | tail -20`

# generate gifs in /tmp

cd /tmp/GSP

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
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/GSP/N1Q/$FILE
PROJ     = rad
GAREA    = KGSP+
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

scp N1Q_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm N1Q_*
cd /home/ldm/SCRIPTS/

#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/N3Q/
#
set CURRENT_RAD=`ls N3Q_* | tail -20`

# generate gifs in /tmp

cd /tmp/GSP

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
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/GSP/N3Q/$FILE
PROJ     = rad
GAREA    = KGSP+
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

scp N3Q_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm N3Q_*
cd /home/ldm/SCRIPTS/

############################################################################################################################################
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/N0U/
#
set CURRENT_RAD=`ls N0U_* | tail -20`

# generate gifs in /tmp

cd /tmp/GSP

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
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/GSP/N0U/$FILE
PROJ     = rad
GAREA    = KGSP+
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

scp N0U_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm N0U_*
cd /home/ldm/SCRIPTS/
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/N1U/
#
set CURRENT_RAD=`ls N1U_* | tail -20`

# generate gifs in /tmp

cd /tmp/GSP

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
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/GSP/N1U/$FILE
PROJ     = rad
GAREA    = KGSP+
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

scp N1U_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm N1U_*
cd /home/ldm/SCRIPTS/
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/N3U/
#
set CURRENT_RAD=`ls N3U_* | tail -20`

# generate gifs in /tmp

cd /tmp/GSP

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
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/GSP/N3U/$FILE
PROJ     = rad
GAREA    = KGSP+
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

scp N3U_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm N3U_*
cd /home/ldm/SCRIPTS/#########################################################################################################################
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/NET/
#
set CURRENT_RAD=`ls NET_* | tail -20`

# generate gifs in /tmp

cd /tmp/GSP

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|NET_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/GSP/NET/$FILE
PROJ     = rad
GAREA    = KGSP+
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

scp NET_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm NET_*
cd /home/ldm/SCRIPTS/#########################################################################################################################
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/OHA/
#
set CURRENT_RAD=`ls OHA_* | tail -20`

# generate gifs in /tmp

cd /tmp/GSP

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|OHA_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/GSP/OHA/$FILE
PROJ     = rad
GAREA    = KGSP+
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

scp OHA_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm OHA_*
cd /home/ldm/SCRIPTS/
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/DHR/
#
set CURRENT_RAD=`ls DHR_* | tail -20`

# generate gifs in /tmp

cd /tmp/GSP

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|DHR_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/GSP/DHR/$FILE
PROJ     = rad
GAREA    = KGSP+
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

scp DHR_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm DHR_*
cd /home/ldm/SCRIPTS/
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/N0X/
#
set CURRENT_RAD=`ls N0X_* | tail -20`

# generate gifs in /tmp

cd /tmp/GSP

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|N0X_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/GSP/N0X/$FILE
PROJ     = rad
GAREA    = KGSP+
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

scp N0X_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm N0X_*
cd /home/ldm/SCRIPTS/
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/N1X/
#
set CURRENT_RAD=`ls N1X_* | tail -20`

# generate gifs in /tmp

cd /tmp/GSP

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|N1X_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/GSP/N1X/$FILE
PROJ     = rad
GAREA    = KGSP+
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

scp N1X_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm N1X_*
cd /home/ldm/SCRIPTS/
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/N2X/
#
set CURRENT_RAD=`ls N2X_* | tail -20`

# generate gifs in /tmp

cd /tmp/GSP

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|N2X_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/GSP/N2X/$FILE
PROJ     = rad
GAREA    = KGSP+
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

scp N2X_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm N2X_*
cd /home/ldm/SCRIPTS/
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/N0C/
#
set CURRENT_RAD=`ls N0C_* | tail -20`

# generate gifs in /tmp

cd /tmp/GSP

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|N0C_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/GSP/N0C/$FILE
PROJ     = rad
GAREA    = KGSP+
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

scp N0C_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm N0C_*
cd /home/ldm/SCRIPTS/
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/N1C/
#
set CURRENT_RAD=`ls N1C_* | tail -20`

# generate gifs in /tmp

cd /tmp/GSP

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|N1C_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/GSP/N1C/$FILE
PROJ     = rad
GAREA    = KGSP+
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

scp N1C_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm N1C_*
cd /home/ldm/SCRIPTS/
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/N2C/
#
set CURRENT_RAD=`ls N2C_* | tail -20`

# generate gifs in /tmp

cd /tmp/GSP

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|N2C_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/GSP/N2C/$FILE
PROJ     = rad
GAREA    = KGSP+
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

scp N2C_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm N2C_*
cd /home/ldm/SCRIPTS/
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/N0K/
#
set CURRENT_RAD=`ls N0K_* | tail -20`

# generate gifs in /tmp

cd /tmp/GSP

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|N0K_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/GSP/N0K/$FILE
PROJ     = rad
GAREA    = KGSP+
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

scp N0K_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm N0K_*
cd /home/ldm/SCRIPTS/
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/N1K/
#
set CURRENT_RAD=`ls N1K_* | tail -20`

# generate gifs in /tmp

cd /tmp/GSP

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|N1K_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/GSP/N1K/$FILE
PROJ     = rad
GAREA    = KGSP+
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

scp N1K_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm N1K_*
cd /home/ldm/SCRIPTS/
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/N2K/
#
set CURRENT_RAD=`ls N2K_* | tail -20`

# generate gifs in /tmp

cd /tmp/GSP

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|N2K_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/GSP/N2K/$FILE
PROJ     = rad
GAREA    = KGSP+
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

scp N2K_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm N2K_*
cd /home/ldm/SCRIPTS/
