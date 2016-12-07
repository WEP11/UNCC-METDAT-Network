#!/bin/csh -f
setenv DISPLAY :1.0
source /home/gempak/NAWIPS/Gemenviron


#
# GOES8 variable set in Gemenviron
#   GOES images follow NSAT naming convention
#     Platform/Resolution/type_yymmdd_hhmm
#
cd /METDAT/data/gempak/nexrad/NIDS/CLT/TR0/
#
set CURRENT_RAD=`ls TR0_* | tail -20`

# generate gifs in /tmp
cp coltbl.xwp /tmp
cd /tmp


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
composite -gravity center /home/ldm/SCRIPTS/overlay.png TR0_$count.gif TR0_$count.gif
@ count++
end

convert -delay 50 -loop 0 TR0_*.gif CLT_TR0.gif
mv CLT_TR0.gif /home/ldm/SCRIPTS/
scp TR0_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/CLT
rm TR0_*
cd /home/ldm/SCRIPTS/
scp CLT_TR0.gif wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad
scp CLT_TR0.gif wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/gif

#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/CLT/TR1/
#
set CURRENT_RAD=`ls TR1_* | tail -20`

# generate gifs in /tmp

cd /tmp

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

cd /tmp

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

cd /tmp

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

cd /tmp

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

cd /tmp

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
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/CLT/NET/
#
set CURRENT_RAD=`ls NET_* | tail -20`

# generate gifs in /tmp

cd /tmp

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
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/CLT/NET/$FILE
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

convert -delay 50 -loop 0 NET_*.gif CLT_NET.gif
mv CLT_NET.gif /home/ldm/SCRIPTS/
scp NET_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/CLT
rm NET_*
cd /home/ldm/SCRIPTS/
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/CLT/N1P/
#
set CURRENT_RAD=`ls N1P_* | tail -20`

# generate gifs in /tmp

cd /tmp

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|N1P_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/CLT/N1P/$FILE
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

convert -delay 50 -loop 0 N1P_*.gif CLT_N1P.gif
mv CLT_N1P.gif /home/ldm/SCRIPTS/
scp N1P_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/CLT
rm N1P_*
cd /home/ldm/SCRIPTS/
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/CLT/NTV/
#
set CURRENT_RAD=`ls NTV_* | tail -20`

# generate gifs in /tmp

cd /tmp

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|NTV_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/CLT/NTV/$FILE
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

convert -delay 50 -loop 0 NTV_*.gif CLT_NTV.gif
mv CLT_NTV.gif /home/ldm/SCRIPTS/
scp NTV_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/CLT
rm NTV_*
cd /home/ldm/SCRIPTS/


#########################################################################################################################
#                                                   GSP- GREENVILLE-SPARTANBURG,SC NEXRADIII
#########################################################################################################################
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/N0Q/
#
set CURRENT_RAD=`ls N0Q_* | tail -20`

# generate gifs in /tmp

cd /tmp

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

convert -delay 50 -loop 0 N0Q_*.gif GSP_N0Q.gif
mv GSP_N0Q.gif /home/ldm/SCRIPTS/
scp N0Q_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm N0Q_*
cd /home/ldm/SCRIPTS/

#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/N1Q/
#
set CURRENT_RAD=`ls N1Q_* | tail -20`

# generate gifs in /tmp

cd /tmp

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

convert -delay 50 -loop 0 N1Q_*.gif GSP_N1Q.gif
mv GSP_N1Q.gif /home/ldm/SCRIPTS/
scp N1Q_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm N1Q_*
cd /home/ldm/SCRIPTS/

#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/N3Q/
#
set CURRENT_RAD=`ls N3Q_* | tail -20`

# generate gifs in /tmp

cd /tmp

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

convert -delay 50 -loop 0 N3Q_*.gif GSP_N3Q.gif
mv GSP_N3Q.gif /home/ldm/SCRIPTS/
scp N3Q_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm N3Q_*
cd /home/ldm/SCRIPTS/

############################################################################################################################################
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/N0U/
#
set CURRENT_RAD=`ls N0U_* | tail -20`

# generate gifs in /tmp

cd /tmp

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

convert -delay 50 -loop 0 N0U_*.gif GSP_N0U.gif
mv GSP_N0U.gif /home/ldm/SCRIPTS/
scp N0U_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm N0U_*
cd /home/ldm/SCRIPTS/
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/N1U/
#
set CURRENT_RAD=`ls N1U_* | tail -20`

# generate gifs in /tmp

cd /tmp

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

convert -delay 50 -loop 0 N1U_*.gif GSP_N1U.gif
mv GSP_N1U.gif /home/ldm/SCRIPTS/
scp N1U_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm N1U_*
cd /home/ldm/SCRIPTS/
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/N3U/
#
set CURRENT_RAD=`ls N3U_* | tail -20`

# generate gifs in /tmp

cd /tmp

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

convert -delay 50 -loop 0 N3U_*.gif GSP_N3U.gif
mv GSP_N3U.gif /home/ldm/SCRIPTS/
scp N3U_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm N3U_*
cd /home/ldm/SCRIPTS/#########################################################################################################################
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/NET/
#
set CURRENT_RAD=`ls NET_* | tail -20`

# generate gifs in /tmp

cd /tmp

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

convert -delay 50 -loop 0 N3U_*.gif GSP_N3U.gif
mv GSP_NET.gif /home/ldm/SCRIPTS/
scp NET_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm NET_*
cd /home/ldm/SCRIPTS/#########################################################################################################################
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/OHA/
#
set CURRENT_RAD=`ls OHA_* | tail -20`

# generate gifs in /tmp

cd /tmp

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

convert -delay 50 -loop 0 OHA_*.gif GSP_OHA.gif
mv GSP_OHA.gif /home/ldm/SCRIPTS/
scp OHA_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm OHA_*
cd /home/ldm/SCRIPTS/#########################################################################################################################
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/GSP/NTV/
#
set CURRENT_RAD=`ls NTV_* | tail -20`

# generate gifs in /tmp

cd /tmp

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|NTV_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/GSP/NTV/$FILE
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

convert -delay 50 -loop 0 NTV_*.gif GSP_NTV.gif
mv GSP_NTV.gif /home/ldm/SCRIPTS/
scp NTV_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/GSP
rm NTV_*
cd /home/ldm/SCRIPTS/#########################################################################################################################
########################################################################################################################
#                                                   RAX- Raleigh, NC NEXRADIII
#########################################################################################################################
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/RAX/N0Q/
#
set CURRENT_RAD=`ls N0Q_* | tail -20`

# generate gifs in /tmp

cd /tmp

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
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/RAX/N0Q/$FILE
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

convert -delay 50 -loop 0 N0Q_*.gif RAX_N0Q.gif
mv RAX_N0Q.gif /home/ldm/SCRIPTS/
scp N0Q_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/RAX
rm N0Q_*
cd /home/ldm/SCRIPTS/

#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/RAX/N1Q/
#
set CURRENT_RAD=`ls N1Q_* | tail -20`

# generate gifs in /tmp

cd /tmp

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
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/RAX/N1Q/$FILE
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

convert -delay 50 -loop 0 N1Q_*.gif RAX_N1Q.gif
mv RAX_N1Q.gif /home/ldm/SCRIPTS/
scp N1Q_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/RAX
rm N1Q_*
cd /home/ldm/SCRIPTS/

#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/RAX/N3Q/
#
set CURRENT_RAD=`ls N3Q_* | tail -20`

# generate gifs in /tmp

cd /tmp

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
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/RAX/N3Q/$FILE
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

convert -delay 50 -loop 0 N3Q_*.gif RAX_N3Q.gif
mv RAX_N3Q.gif /home/ldm/SCRIPTS/
scp N3Q_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/RAX
rm N3Q_*
cd /home/ldm/SCRIPTS/

############################################################################################################################################
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/RAX/N0U/
#
set CURRENT_RAD=`ls N0U_* | tail -20`

# generate gifs in /tmp

cd /tmp

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
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/RAX/N0U/$FILE
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

convert -delay 50 -loop 0 N0U_*.gif RAX_N0U.gif
mv RAX_N0U.gif /home/ldm/SCRIPTS/
scp N0U_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/RAX
rm N0U_*
cd /home/ldm/SCRIPTS/
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/RAX/N1U/
#
set CURRENT_RAD=`ls N1U_* | tail -20`

# generate gifs in /tmp

cd /tmp

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
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/RAX/N1U/$FILE
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

convert -delay 50 -loop 0 N1U_*.gif RAX_N1U.gif
mv RAX_N1U.gif /home/ldm/SCRIPTS/
scp N1U_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/RAX
rm N1U_*
cd /home/ldm/SCRIPTS/
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/RAX/N3U/
#
set CURRENT_RAD=`ls N3U_* | tail -20`

# generate gifs in /tmp

cd /tmp

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
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/RAX/N3U/$FILE
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

convert -delay 50 -loop 0 N3U_*.gif RAX_N3U.gif
mv RAX_N3U.gif /home/ldm/SCRIPTS/
scp N3U_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/RAX
rm N3U_*
cd /home/ldm/SCRIPTS/#########################################################################################################################
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/RAX/NET/
#
set CURRENT_RAD=`ls NET_* | tail -20`

# generate gifs in /tmp

cd /tmp

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
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/RAX/NET/$FILE
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

convert -delay 50 -loop 0 N3U_*.gif RAX_N3U.gif
mv RAX_NET.gif /home/ldm/SCRIPTS/
scp NET_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/RAX
rm NET_*
cd /home/ldm/SCRIPTS/#########################################################################################################################
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/RAX/OHA/
#
set CURRENT_RAD=`ls OHA_* | tail -20`

# generate gifs in /tmp

cd /tmp

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
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/RAX/OHA/$FILE
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

convert -delay 50 -loop 0 OHA_*.gif RAX_OHA.gif
mv RAX_OHA.gif /home/ldm/SCRIPTS/
scp OHA_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/RAX
rm OHA_*
cd /home/ldm/SCRIPTS/#########################################################################################################################
#########################################################################################################################
cd /METDAT/data/gempak/nexrad/NIDS/RAX/NTV/
#
set CURRENT_RAD=`ls NTV_* | tail -20`

# generate gifs in /tmp

cd /tmp

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_RAD)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|NTV_$count.gif|1280;1024
SATFIL   = 
RADFIL   = /METDAT/data/gempak/nexrad/NIDS/RAX/NTV/$FILE
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

convert -delay 50 -loop 0 NTV_*.gif RAX_NTV.gif
mv RAX_NTV.gif /home/ldm/SCRIPTS/
scp NTV_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/RAX
rm NTV_*
cd /home/ldm/SCRIPTS/#########################################################################################################################
