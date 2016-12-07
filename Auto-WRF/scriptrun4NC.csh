##############################################################################################################################
#
#                    *** WRF AUTOMATIC EXECUTION SCRIPT ***
#                          Component of METDAT System
#
#
# This is an automatic WRF-ARW Script developed by Warren Pettee (wpettee@uncc.edu)
#
#
# It completes the entire WRF sequence as follows:
#
# DATA COLLECTION -> Namelist Preparation -> WPS -> WRF -> NCL Plotting
#
################################################################################################################################

#Directory Environment Variables
export dropbox=/home/wxdisplay/Models/OUTPUT

rm $dropbox/system/WRF_STATUS.log
rm $dropbox/system/WRF_4km.log

# DOWNLOAD CURRENT DATA
echo "EXECUTING 4km-WRF-ARW NC" >> $dropbox/system/WRF_STATUS.log
echo "---DOWNLOADING DATA---" >> $dropbox/system/WRF_STATUS.log
cd ../DATA
./main_NAM.csh

cd ../DOMAINS/


# --------------------- RUN 30km WRF-ARW off NAM_AWIP GRID------------------------------------

	# ========= DATE CONTROL ========
	export time=$(date -u +"%H")


	if [[ $time = 3 || $time = 4 || $time = 5 || $time = 6 || $time = 7 || $time = 8 ]]; then
	   
	   export fhour=00
	   export chour=0   # chour is the hour to be used in calculations. Leading 0's cause problems in calculations
		            # but are necessary in the WRF Namelist
	  
	fi
	if [[ $time = 9 || $time = 10 || $time = 11 || $time = 12 || $time = 13 || $time = 14 ]]; then
	   
	   export fhour=06
	   export chour=6
	   
	fi
	if [[ $time = 15 || $time = 16 || $time = 17 || $time = 18 || $time = 19 || $time = 20 ]]; then
	      
	   export fhour=12
	   export chour=12
	  
	fi
	if [[ $time = 21 || $time = 22 || $time = 23 || $time = 0 || $time = 1 || $time = 2 ]]; then
	   
	   export fhour=18
	   export chour=18
	   
	fi

	#Date variables
	export start_year=$(date -u +%Y)
	export start_mon=$(date -u +%m)
	export start_monc=${start_mon#0} # strip leading 0
	export start_day=$(date -u +%d)
	export start_dayc=${start_day#0} # strip leading 0
	export start_hour=$fhour
	
	add_84_hours() 
	{
	    local datestamp=$1
	    local start_h=$2
	    local epoch=$(date -ud "$datestamp $start_h:00" +%s)
	    date -ud "@$(( epoch + 84*3600 ))" +"%Y %m %d %H"
	}

	read end_year end_month end_day end_hour < <(add_84_hours now $chour)
	# FOR DEBUGGING :: printf "%s\n" "$end_year" "$end_month" "$end_day" "$end_hour"





#           ***  PREPARING NAMELIST.WPS FILE  ***
###############################################################################################################################
set filename='nam_218_20140126_1800_001.grb' 
set datetime=`echo "$filename" | sed -r 's/.*_([0-9]{4})([0-9]{2})([0-9]{2})_([0-9]{2})([0-9]{2}).*/\1-\2-\3_\4:\5:00/'`

cat << End_Of_Namelist | sed -e 's/#.*//; s/  *$//' > cus_arw/wpsprd/namelist.wps

	&share
	 wrf_core = 'ARW',
	 max_dom = 1,
	 start_date = '${start_year}-${start_mon}-${start_day}_${start_hour}:00:00',
	 end_date   = '${end_year}-${end_month}-${end_day}_${end_hour}:00:00',
	 interval_seconds = 10800
	 io_form_geogrid = 2,
	/

	&geogrid
	 parent_id         =   1,   1,   2
	 parent_grid_ratio =   1,   3,   3
	 i_parent_start    =   1,  30,   112
	 j_parent_start    =   1,  11,   69
	 e_we              =  270, 246,  25
	 e_sn              =  156, 246,  25
	 geog_data_res     = '10m','2m', 2m
	 dx = 4000
	 dy = 4000
	 map_proj = 'lambert',
	 ref_lat   =  36,
	 ref_lon   = -79,
	 truelat1  =  30.0,
	 truelat2  =  60.0,
	 stand_lon = -98.0,
	 geog_data_path = '/home/wxdisplay/Models/GEODATA/'
         opt_geogrid_tbl_path = '../../../WRF-ARW/WPS/geogrid/'
	/


	&ungrib
	 out_format = 'WPS',
	 prefix = 'NAM',
	/

	&metgrid
	 fg_name = 'NAM'
	 io_form_metgrid = 2,
         opt_metgrid_tbl_path = '../../../WRF-ARW/WPS/metgrid/'
	/

End_Of_Namelist



#################################################################################################################################
#                   *** PREPARING NAMELIST.INPUT FOR WRF
#################################################################################################################################
cat << End_Of_Namelist | sed -e 's/#.*//; s/  *$//' > cus_arw/wrfprd/namelist.input

		 &time_control
		 run_days                            = 0,
		 run_hours                           = 48,
		 run_minutes                         = 0,
		 run_seconds                         = 0,
		 start_year                          = ${start_year}, ${start_year}, ${start_year},
		 start_month                         = ${start_mon},  ${start_mon},  ${start_mon},
		 start_day                           = ${start_day},  ${start_day},  ${start_day},
		 start_hour                          = ${start_hour}, ${start_hour}, ${start_hour},
		 start_minute                        = 00,   00,   00,
		 start_second                        = 00,   00,   00,
		 end_year                            = ${end_year}, ${end_year}, ${end_year},
		 end_month                           = ${end_month}, ${end_month}, ${end_month},
		 end_day                             = ${end_day}, ${end_day}, ${end_day},
		 end_hour                            = ${end_hour}, ${end_hour}, ${end_hour},
		 end_minute                          = 00,   00,   00,
		 end_second                          = 00,   00,   00,
		 interval_seconds                    = 86400
		 input_from_file                     = .true.,.true.,.true.,
		 history_interval                    = 60,  60,   60,
		 frames_per_outfile                  = 1000, 1000, 1000,
		 restart                             = .false.,
		 restart_interval                    = 5000,
		 io_form_history                     = 2
		 io_form_restart                     = 2
		 io_form_input                       = 2
		 io_form_boundary                    = 2
		 debug_level                         = 0
		 /

		 &domains
		 time_step                           = 30,
		 time_step_fract_num                 = 0,
		 time_step_fract_den                 = 1,
		 max_dom                             = 1,
		 e_we                                = 270, 80,  25,
		 e_sn                                = 156, 80,  25,
		 e_vert                              = 30,     30,    30,
		 p_top_requested                     = 5000,
		 num_metgrid_levels                  = 43,
		 num_metgrid_soil_levels             = 4,
		 dx                                  = 4000, 10000,  1333.333,
		 dy                                  = 4000, 10000,  1333.333,
		 grid_id                             = 1,     2,     3,
		 parent_id                           = 0,     1,     2,
		 i_parent_start                      = 1,     36,    112,
		 j_parent_start                      = 1,     21,    69,
		 parent_grid_ratio                   = 1,     3,     3,
		 parent_time_step_ratio              = 1,     3,     3,
		 feedback                            = 1,
		 smooth_option                       = 0
		 /

		 &physics
		 mp_physics                          = 3,     3,     3,
		 ra_lw_physics                       = 1,     1,     1,
		 ra_sw_physics                       = 1,     1,     1,
		 radt                                = 30,    30,    30,
		 sf_sfclay_physics                   = 1,     1,     1,
		 sf_surface_physics                  = 2,     2,     2,
		 bl_pbl_physics                      = 1,     1,     1,
		 bldt                                = 0,     0,     0,
		 cu_physics                          = 1,     1,     0,
		 cudt                                = 5,     5,     5,
		 isfflx                              = 1,
		 ifsnow                              = 1,
		 icloud                              = 1,
		 surface_input_source                = 1,
		 num_soil_layers                     = 4,
		 sf_urban_physics                    = 0,     0,     0,
		 /

		 &fdda
		 /

		 &dynamics
		 w_damping                           = 0,
		 diff_opt                            = 1,
		 km_opt                              = 4,
		 diff_6th_opt                        = 0,      0,      0,
		 diff_6th_factor                     = 0.12,   0.12,   0.12,
		 base_temp                           = 290.
		 damp_opt                            = 0,
		 zdamp                               = 5000.,  5000.,  5000.,
		 dampcoef                            = 0.2,    0.2,    0.2
		 khdif                               = 0,      0,      0,
		 kvdif                               = 0,      0,      0,
		 non_hydrostatic                     = .true., .true., .true.,
		 moist_adv_opt                       = 1,      1,      1,     
		 scalar_adv_opt                      = 1,      1,      1,     
		 /

		 &bdy_control
		 spec_bdy_width                      = 5,
		 spec_zone                           = 1,
		 relax_zone                          = 4,
		 specified                           = .true., .false.,.false.,
		 nested                              = .false., .true., .true.,
		 /

		 &grib2
		 /

		 &namelist_quilt
		 nio_tasks_per_group = 0,
		 nio_groups = 1,
		 /

End_Of_Namelist

###############################################################################################################



#Run Sequence

echo "---BEGINNING NAM-WRF-ARW RUN---" >> $dropbox/system/WRF_STATUS.log
echo "4km WRF-ARW:" >> $dropbox/system/WRF_STATUS.log
cd cus_arw/wpsprd
./geogrid.exe >> $dropbox/system/WRF_4km.log
echo "Geogrid Complete!" >> $dropbox/system/WRF_STATUS.log
(date  +"%H:%M:%S") >> $dropbox/system/WRF_STATUS.log

ln -sf ../../../WRF-ARW/WPS/ungrib/Variable_Tables/Vtable.NAM Vtable
echo "NAM Vtables linked!" >> $dropbox/system/WRF_STATUS.log
(date  +"%H:%M:%S") >> $dropbox/system/WRF_STATUS.log
./link_grib.csh ../../../DATA/NAM"$fhour"/
echo "Grib Files Linked!" >> $dropbox/system/WRF_STATUS.log
(date  +"%H:%M:%S") >> $dropbox/system/WRF_STATUS.log
./ungrib.exe >> $dropbox/system/WRF_4km.log
echo "Ungribed!" >> $dropbox/system/WRF_STATUS.log
(date  +"%H:%M:%S") >> $dropbox/system/WRF_STATUS.log

./metgrid.exe >> $dropbox/system/WRF_4km.log
echo "Metgrid Complete!" >> $dropbox/system/WRF_STATUS.log
(date  +"%H:%M:%S") >> $dropbox/system/WRF_STATUS.log

cd ../wrfprd
ln -sf ../wpsprd/met_em* .
echo "WPS Output Linked!" >> $dropbox/system/WRF_STATUS.log
(date  +"%H:%M:%S") >> $dropbox/system/WRF_STATUS.log
./real.exe >> $dropbox/system/WRF_4km.log
echo "real.exe Complete!" >> $dropbox/system/WRF_STATUS.log
(date  +"%H:%M:%S") >> $dropbox/WRF_STATUS.log
./wrf.exe >> $dropbox/system/WRF_4km.log
echo "WRF-ARW COMPLETE!!!" >> $dropbox/system/WRF_STATUS.log
(date  +"%H:%M:%S") >> $dropbox/system/WRF_STATUS.log


echo "Models Complete, Plotting Data..." >> $dropbox/system/WRF_STATUS.log


# Output a nice NCL PDF Plot in 6hr intervals
cp wrfout_d01_"$start_year"-"$start_mon"-"$start_day"_"$start_hour":00:00 ../../NCL_SCRIPTS/wrfoutd01.nc
#cp wrfout_d02_"$start_year"-"$start_mon"-"$start_day"_"$start_hour":00:00 ../../NCL_SCRIPTS/wrfoutd02.nc



cd ../../NCL_SCRIPTS/

ncl superplot.ncl
#ncl sfcplt.ncl >> $dropbox/system/WRF_4km.log
#ncl upprplt.ncl >> $dropbox/system/WRF_4km.log

cp UpperAirPlot.pdf $dropbox/UpperAir/UpperAir_4km_"$start_year"-"$start_mon"-"$start_day"_f"$start_hour".pdf
cp SurfacePlot.pdf $dropbox/Surface/Surface_4km_"$start_year"-"$start_mon"-"$start_day"_f"$start_hour".pdf
cp PrecipPlot.pdf $dropbox/Precip/Precip_4km_"$start_year"-"$start_mon"-"$start_day"_f"$start_hour".pdf
cp radar.gif $dropbox/Precip/SimRadar_4km_"$start_year"-"$start_mon"-"$start_day"_f"$start_hour".gif
cp SoundingPlot.pdf $dropbox/UpperAir/Sounding_4km_"$start_year"-"$start_mon"-"$start_day"_f"$start_hour".pdf
cp capeplt.pdf $dropbox/UpperAir/CAPE_4km_"$start_year"-"$start_mon"-"$start_day"_f"$start_hour".pdf

echo "WRF-ARW, NAM Output Successfully Plotted!" >> $dropbox/system/WRF_STATUS.log
(date  +"%H:%M:%S") >> $dropbox/system/WRF_STATUS.log
echo "CLEANING UP... ..."

rm wrfout* 
cd ../cus_arw/wpsprd
rm met_em* 
rm GRIBFILE*
rm NAM*
rm PFILE* 
cd ../wrfprd
rm met_em* 
rm wrfout* 
