#!/bin/csh -f
setenv DISPLAY :1.0
source /home/gempak/NAWIPS/Gemenviron


#
# GOES8 variable set in Gemenviron
#   GOES images follow NSAT naming convention
#     Platform/Resolution/type_yymmdd_hhmm
#
cd /METDAT/data/gempak/images/sat/EAST-CONUS/1km/VIS
#
set CURRENT_SAT=`ls VIS_* | tail -20`

# generate gifs in /tmp/sat
mkdir /tmp/sat
rm /tmp/sat/*
cd /tmp/sat

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_SAT)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|VIS_$count.gif|1280;1024
SATFIL   = /METDAT/data/gempak/images/sat/EAST-CONUS/1km/VIS/$FILE
RADFIL   = 
PROJ     = sat
GAREA    = nc
CLEAR    = y
PANEL    = 0
TEXT     = 1.2/23/1/hw
LATLON   = 0
\$mapfil = hipowo.gsf
r

e
EOF

gpend
@ count++
end

convert -delay 30 -loop 0 VIS_*.gif 1kmVIS_live.gif
mv 1kmVIS_live.gif /home/ldm/SCRIPTS/
scp VIS_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/sat/nc
rm VIS_*
cd /home/ldm/SCRIPTS/
scp 1kmVIS_live.gif wxdisplay@10.17.157.196:/home/wxdisplay/Forecast
scp 1kmVIS_live.gif wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/gif
#
# GOES8 variable set in Gemenviron
#   GOES images follow NSAT naming convention
#     Platform/Resolution/type_yymmdd_hhmm
#
cd /METDAT/data/gempak/images/sat/EAST-CONUS/4km/IR
#
set CURRENT_SAT=`ls IR_* | tail -20`

# generate gifs in /tmp/sat

cd /tmp/sat

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_SAT)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|IR_$count.gif|1280;1024
SATFIL   = /METDAT/data/gempak/images/sat/EAST-CONUS/4km/IR/$FILE
RADFIL   = 
LUTFIL   = /home/gempak/NAWIPS/gempak/tables/luts/ir_rgbv.tbl
PROJ     = sat
GAREA    = dset
CLEAR    = y
PANEL    = 0
TEXT     = 1.2/23/1/hw
LATLON   = 0
\$mapfil = hipowo.gsf
r

e
EOF

gpend
@ count++
end

convert -delay 30 -loop 0 IR_*.gif 4kmIR_live.gif
mv 4kmIR_live.gif /home/ldm/SCRIPTS/
scp IR_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/sat/nc
rm IR_*
cd /home/ldm/SCRIPTS/
scp 4kmIR_live.gif wxdisplay@10.17.157.196:/home/wxdisplay/Forecast
scp 4kmIR_live.gif wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/gif
#
# GOES8 variable set in Gemenviron
#   GOES images follow NSAT naming convention
#     Platform/Resolution/type_yymmdd_hhmm
#
cd /METDAT/data/gempak/images/sat/EAST-CONUS/4km/WV
#
set CURRENT_SAT=`ls WV_* | tail -20`

# generate gifs in /tmp/sat

cd /tmp/sat

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_SAT)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|WV_$count.gif|1280;1024
SATFIL   = /METDAT/data/gempak/images/sat/EAST-CONUS/4km/WV/$FILE
RADFIL   = 
LUTFIL   = default
PROJ     = sat
GAREA    = dset
CLEAR    = y
PANEL    = 0
TEXT     = 1.2/23/1/hw
LATLON   = 0
\$mapfil = hipowo.gsf
r

e
EOF

gpend
@ count++
end

convert -delay 30 -loop 0 WV_*.gif 4kmWV_live.gif
mv 4kmWV_live.gif /home/ldm/SCRIPTS/
scp WV_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/sat/nc
rm WV_*
cd /home/ldm/SCRIPTS/
scp 4kmWV_live.gif wxdisplay@10.17.157.196:/home/wxdisplay/Forecast
scp 4kmWV_live.gif wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/gif
#########################################################################################################
#
# NEXRAD COMPOSITE
#  Digital Hybrid Reflectivity
#
cd /METDAT/data/gempak/images/sat/NEXRCOMP/1km/dhr
#
set CURRENT_SAT=`ls dhr_* | tail -20`

# generate gifs in /tmp/sat

cd /tmp/sat

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_SAT)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|DHR_$count.gif|1280;1024
SATFIL   = /METDAT/data/gempak/images/sat/NEXRCOMP/1km/dhr/$FILE
RADFIL   = 
PROJ     = sat
GAREA    = US
IMCBAR   = 1
CLEAR    = y
PANEL    = 0
TEXT     = 1.2/23/1/hw
LATLON   = 0
\$mapfil = hipowo.gsf
r

e
EOF

gpend
@ count++
end

convert -delay 30 -loop 0 DHR_*.gif 1kmDHR_NEXRAD.gif
mv 1kmDHR_NEXRAD.gif /home/ldm/SCRIPTS/
scp DHR_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/COMP
rm DHR_*
cd /home/ldm/SCRIPTS/
scp 1kmDHR_NEXRAD.gif wxdisplay@10.17.157.196:/home/wxdisplay/Forecast
scp 1kmDHR_NEXRAD.gif wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/gif
#########################################################################################################
#
# NEXRAD COMPOSITE
#  Digital Vertically Integrated Liquid
#
cd /METDAT/data/gempak/images/sat/NEXRCOMP/1km/dvl
#
set CURRENT_SAT=`ls dvl_* | tail -20`

# generate gifs in /tmp/sat

cd /tmp/sat

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_SAT)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|DVL_$count.gif|1280;1024
SATFIL   = /METDAT/data/gempak/images/sat/NEXRCOMP/1km/dvl/$FILE
RADFIL   = 
PROJ     = sat
GAREA    = US
IMCBAR   = 1
CLEAR    = y
PANEL    = 0
TEXT     = 1.2/23/1/hw
LATLON   = 0
\$mapfil = hipowo.gsf
r

e
EOF

gpend
@ count++
end

scp DVL_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/COMP
rm DVL_*
cd /home/ldm/SCRIPTS/
#########################################################################################################
#
# NEXRAD COMPOSITE
#  Enhanced Echo Tops
#
cd /METDAT/data/gempak/images/sat/NEXRCOMP/1km/eet
#
set CURRENT_SAT=`ls eet_* | tail -20`

# generate gifs in /tmp/sat

cd /tmp/sat

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_SAT)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|EET_$count.gif|1280;1024
SATFIL   = /METDAT/data/gempak/images/sat/NEXRCOMP/1km/eet/$FILE
RADFIL   = 
PROJ     = sat
GAREA    = US
IMCBAR   = 1
CLEAR    = y
PANEL    = 0
TEXT     = 1.2/23/1/hw
LATLON   = 0
\$mapfil = hipowo.gsf
r

e
EOF

gpend
@ count++
end

scp EET_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/COMP
rm EET_*
cd /home/ldm/SCRIPTS/
#########################################################################################################
#
# NEXRAD COMPOSITE
#  Hybrid Hydrometeor Classification
#
cd /METDAT/data/gempak/images/sat/NEXRCOMP/1km/hhc
#
set CURRENT_SAT=`ls hhc_* | tail -20`

# generate gifs in /tmp/sat

cd /tmp/sat

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_SAT)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|HHC_$count.gif|1280;1024
SATFIL   = /METDAT/data/gempak/images/sat/NEXRCOMP/1km/hhc/$FILE
RADFIL   = 
PROJ     = sat
GAREA    = US
IMCBAR   = 1
CLEAR    = y
PANEL    = 0
TEXT     = 1.2/23/1/hw
LATLON   = 0
\$mapfil = hipowo.gsf
r

e
EOF

gpend
@ count++
end

scp HHC_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/COMP
rm HHC_*
cd /home/ldm/SCRIPTS/
#########################################################################################################
#
# NEXRAD COMPOSITE
#  Base Reflectivity
#
cd /METDAT/data/gempak/images/sat/NEXRCOMP/1km/n0r
#
set CURRENT_SAT=`ls n0r_* | tail -20`

# generate gifs in /tmp/sat

cd /tmp/sat

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_SAT)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|N0R_$count.gif|1280;1024
SATFIL   = /METDAT/data/gempak/images/sat/NEXRCOMP/1km/n0r/$FILE
RADFIL   = 
PROJ     = sat
GAREA    = US
IMCBAR   = 1
CLEAR    = y
PANEL    = 0
TEXT     = 1.2/23/1/hw
LATLON   = 0
\$mapfil = hipowo.gsf
r

e
EOF

gpend
@ count++
end

scp N0R_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/COMP
rm N0R_*
cd /home/ldm/SCRIPTS/
#########################################################################################################
#
# NEXRAD COMPOSITE
#  1hr Precipitation
#
cd /METDAT/data/gempak/images/sat/NEXRCOMP/2km/n1p
#
set CURRENT_SAT=`ls n1p_* | tail -20`

# generate gifs in /tmp/sat

cd /tmp/sat

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_SAT)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|N1P_$count.gif|1280;1024
SATFIL   = /METDAT/data/gempak/images/sat/NEXRCOMP/2km/n1p/$FILE
RADFIL   = 
PROJ     = sat
GAREA    = US
IMCBAR   = 1
CLEAR    = y
PANEL    = 0
TEXT     = 1.2/23/1/hw
LATLON   = 0
\$mapfil = hipowo.gsf
r

e
EOF

gpend
@ count++
end

scp N1P_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/COMP
rm N1P_*
cd /home/ldm/SCRIPTS/
#########################################################################################################
#
# NEXRAD COMPOSITE
#  Storm Total Precipitation
#
cd /METDAT/data/gempak/images/sat/NEXRCOMP/4km/ntp
#
set CURRENT_SAT=`ls ntp_* | tail -20`

# generate gifs in /tmp/sat

cd /tmp/sat

if(-e sat.gif ) then
   rm -f sat.gif*
endif
set count=1
foreach FILE ($CURRENT_SAT)

gpmap << EOF
MAP      = 1
TITLE    = 1/-2/
DEVICE   = gf|NTP_$count.gif|1280;1024
SATFIL   = /METDAT/data/gempak/images/sat/NEXRCOMP/4km/ntp/$FILE
RADFIL   = 
PROJ     = sat
GAREA    = US
IMCBAR   = 1
CLEAR    = y
PANEL    = 0
TEXT     = 1.2/23/1/hw
LATLON   = 0
\$mapfil = hipowo.gsf
r

e
EOF

gpend
@ count++
end

scp NTP_* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/nexrad/COMP
rm NTP_*
cd /home/ldm/SCRIPTS/
