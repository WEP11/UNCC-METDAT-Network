#!/bin/csh
source /home/gempak/NAWIPS/Gemenviron
######################################
#    ...MOS FORECAST FOR KCLT...     #
######################################

cd /home/ldm/SCRIPTS

sflist << E0F
	SFFILE   = GFSMOS
	AREA     = @KCLT
	DATTIM   = all
	SFPARM   = SKYC;TMPF;MXMN;DWPF;PCPT;PP06;QP06
	OUTPUT   = f /forecast.txt
	IDNTYP   = STID
	r
	e
E0F

gpend

scp /home/ldm/SCRIPTS/forecast.txt wxdisplay@10.17.157.196:/home/wxdisplay/Forecast
