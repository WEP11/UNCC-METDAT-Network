#!/bin/csh -f
##################################################################
# GENERATE SOUNDING DATA FOR 6-HOURLIES....
##################################################################
set LOC='KCLT,KGSO,KRCZ,KRDU,TNB,KHKY,KINT,KAVL,LBT,KILM,KOAJ,KMHX,KISO,KGSB,KRWI,KIXA,KPGV,KECG,KHAT,KORF,KPHF,KDAN,KROA,FRI,KBLF,KLWB,KCHO,KIAD,KSBY,WAL,KATL,KFFC,KAGS,KCAE,KGSP,KSSC,KFLO,KMYR,KCHS,KTRI,MOR,GRUN,KBLF,KDCA,KBWI'

cd /home/ldm/bufrgruven15.44
perl bufr_gruven.pl --dset hrwarw --stations $LOC
perl bufr_gruven.pl --dset gfspara --stations $LOC
perl bufr_gruven.pl --dset gfs3 --stations $LOC
perl bufr_gruven.pl --dset nam --stations $LOC
perl bufr_gruven.pl --dset nam4km --stations $LOC
perl bufr_gruven.pl --dset namm --stations $LOC

scp metdat/bufkit/hrwarw* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/bufkit
scp metdat/bufkit/gfspara* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/bufkit
scp metdat/bufkit/gfs3* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/bufkit
scp metdat/bufkit/nam* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/bufkit
scp metdat/bufkit/nam4km* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/bufkit
scp metdat/bufkit/namm* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/bufkit

scp metdat/ascii/*_hrwarw.* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/bufkit/ascii
scp metdat/ascii/*_gfspara.* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/bufkit/ascii
scp metdat/ascii/*_gfs3.* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/bufkit/ascii
scp metdat/ascii/*_nam.* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/bufkit/ascii
scp metdat/ascii/*_nam4km.* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/bufkit/ascii
scp metdat/ascii/*_namm.* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/bufkit/ascii

perl bufr_gruven.pl --dset sref --stations $LOC
scp metdat/ascii/*_sref.* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/bufkit/ascii
scp metdat/bufkit/*_sref.* wxdisplay@10.17.157.196:/home/wxdisplay/webfolder/bufkit

cd /home/ldm/SCRIPTS

