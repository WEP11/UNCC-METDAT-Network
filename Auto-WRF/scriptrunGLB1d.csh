################################################################################################################################
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
#
#
################################################################################################################################

#Directory Environment Variables
export dropbox=/home/wxdisplay/Models/OUTPUT

rm $dropbox/system/WRF_STATUS.log
rm $dropbox/system/WRF_glb.log

# DOWNLOAD CURRENT DATA
echo "EXECUTING WRF-ARW GLOBAL 1d (GFS)" >& $dropbox/system/WRF_STATUS.log
(date  +"%H:%M:%S") >> $dropbox/system/WRF_STATUS.log
echo "---DOWNLOADING DATA---" >> $dropbox/system/WRF_STATUS.log
cd ../DATA
./main_GFS.csh

cd ../DOMAINS/


# --------------------------------------------------------------------------
#                         Pure WRF-ARW
# 
#                     Nesting 1d   Global
#                     1/3d CONUS
#                     1/9d SE-US
#
#               Initializing @ f00 using GFS f00 for last
#                         5-Day Forecast
#----------------------------------------------------------------------------

	# ========= DATE CONTROL ========
	export time=$(date -u +"%H")


	if [[ $time = 4 || $time = 5 || $time = 6 || $time = 7 || $time = 8 || $time = 9 ]]; then
	   
	   export fhour=00
	   export chour=0   # chour is the hour to be used in calculations. Leading 0's cause problems in calculations
		            # but are necessary in the WRF Namelist
	  
	fi
	if [[ $time = 10 || $time = 11 || $time = 12 || $time = 13 || $time = 14 || $time = 15 ]]; then
	   
	   export fhour=06
	   export chour=6
	   
	fi
	if [[ $time = 16 || $time = 17 || $time = 18 || $time = 19 || $time = 20 || $time = 21 ]]; then
	      
	   export fhour=12
	   export chour=12
	  
	fi
	if [[ $time = 22 || $time = 23 || $time = 0 || $time = 1 || $time = 2 || $time = 3 ]]; then
	   
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
	#export end_year=$(date -u +%Y)
	#export end_mon=$(date -u +%m)
	#export end_day=$(( $start_dayc+((($start_dayc*24)+84)/24) ))
	#export end_hour=$(( ($start_dayc*24+84)%24 ))

	add_384_hours() 
	{
	    local datestamp=$1
	    local start_h=$2
	    local epoch=$(date -ud "$datestamp $start_h:00" +%s)
	    date -ud "@$(( epoch + 120*3600 ))" +"%Y %m %d %H" #5-Day Forecast (120hrs)
	}

	read end_year end_month end_day end_hour < <(add_384_hours now $chour)
	# FOR DEBUGGING :: printf "%s\n" "$end_year" "$end_month" "$end_day" "$end_hour"


###############################################################################################################################
#           ***  PREPARING NAMELIST.WPS FILE  ***
###############################################################################################################################
set filename='nam_218_20140126_1800_001.grb'  
set datetime=`echo "$filename" | sed -r 's/.*_([0-9]{4})([0-9]{2})([0-9]{2})_([0-9]{2})([0-9]{2}).*/\1-\2-\3_\4:\5:00/'`

cat << End_Of_Namelist | sed -e 's/#.*//; s/  *$//' > pure_arw/wpsprd/namelist.wps

	&share
	 wrf_core = 'ARW',
	 max_dom = 3,
	 start_date = '${start_year}-${start_mon}-${start_day}_${start_hour}:00:00','${start_year}-${start_mon}-${start_day}_${start_hour}:00:00','${start_year}-${start_mon}-${start_day}_${start_hour}:00:00'
	 end_date   = '${start_year}-${start_mon}-${start_day}_${start_hour}:00:00','${start_year}-${start_mon}-${start_day}_${start_hour}:00:00','${start_year}-${start_mon}-${start_day}_${start_hour}:00:00'
	 interval_seconds = 21600,
	 io_form_geogrid = 2,
	/

	&geogrid
	 parent_id         = 1,1,2,
	 parent_grid_ratio = 1,3,3,
	 i_parent_start    = 1,10,75,
	 j_parent_start    = 1,40,11,
	 e_we          = 136,124,79,
	 e_sn          = 68,58,82,
	 geog_data_res = '10m','5m','2m',
	 map_proj =  'lat-lon',
	 pole_lat  = 90,
	 pole_lon  = 0,
	 stand_lon = 180,
	 geog_data_path = '/home/wxdisplay/Models/GEODATA',
	 opt_geogrid_tbl_path = '/home/wxdisplay/Models/WRF-ARW/WPS/geogrid/',
	 ref_x = 68.0,
	 ref_y = 34.0,
	/

	&ungrib
	 out_format = 'WPS',
	 prefix = 'FILE',
	/

	&metgrid
	 fg_name = 'FILE'
	 io_form_metgrid = 2,
	 opt_metgrid_tbl_path = '/home/wxdisplay/Models/WRF-ARW/WPS/metgrid/'
	/

	&mod_levs
	 press_pa = 201300 , 200100 , 100000 , 
		     95000 ,  90000 , 
		     85000 ,  80000 , 
		     75000 ,  70000 , 
		     65000 ,  60000 , 
		     55000 ,  50000 , 
		     45000 ,  40000 , 
		     35000 ,  30000 , 
		     25000 ,  20000 , 
		     15000 ,  10000 , 
		      5000 ,   1000
	/

End_Of_Namelist



#################################################################################################################################
#                   *** PREPARING NAMELIST.INPUT FOR WRF
#################################################################################################################################
cat << End_Of_Namelist | sed -e 's/#.*//; s/  *$//' > pure_arw/wrfprd/namelist.input

		 &time_control
		 run_days                            = 0,
		 run_hours                           = 120,
		 run_minutes                         = 0,
		 run_seconds                         = 0,
		 start_year                          = ${start_year}, ${start_year}, ${start_year},
		 start_month                         = ${start_mon},  ${start_mon},  ${start_mon},
		 start_day                           = ${start_day},  ${start_day},  ${start_day},
		 start_hour                          = ${start_hour}, ${start_hour}, ${start_hour},
		 start_minute                        = 00,   00,   00,
		 start_second                        = 00,   00,   00,
		 end_year                            = ${start_year}, ${end_year}, ${end_year},
		 end_month                           = ${start_mon}, ${end_month}, ${end_month},
		 end_day                             = ${start_day}, ${end_day}, ${end_day},
		 end_hour                            = ${start_hour}, ${end_hour}, ${end_hour},
		 end_minute                          = 00,   00,   00,
		 end_second                          = 00,   00,   00,
		  history_interval                    = 60,   30,   30,
		 interval_seconds                    = 21600 
		 input_from_file                     = .true.,.true.,.true.,
		 frames_per_outfile                  = 200000,  200000,  200000,
		 restart                             = .false.,
		 restart_interval                    = 5000,
		 io_form_history                     = 2,
		 io_form_restart                     = 2,
		 io_form_input                       = 2,
		 io_form_boundary                    = 2,
		 debug_level                         = 0,
		 /

		 &domains                 
		time_step                = 600,
		time_step_fract_num      = 00,
		time_step_fract_den      = 112,
		max_dom                  = 3,
		e_we                     = 136,      124,       79,
		e_sn                     = 68,       58,       82,
		e_vert                   = 41,       41,       41,
		p_top_requested          = 5000,
		num_metgrid_levels       = 27,
		num_metgrid_soil_levels  = 4,
		dx                       = 296473.262,98824.421,32941.474,
		dy                       = 298685.749,99561.916,33187.305,
		p_top_requested          = 5000,
		grid_id                  = 1,        2,        3,
		parent_id                = 1,        1,        2,
		i_parent_start           = 1,       10,       75,
		j_parent_start           = 1,       40,       11,
		parent_grid_ratio        = 1,        3,        3,
		parent_time_step_ratio   = 1,        3,        3,
		feedback                 = 1,
		smooth_option            = 00,
		/

		&physics                 
		mp_physics               = 3,        3,        3,
		ra_lw_physics            = 1,        1,        1,
		ra_sw_physics            = 1,        1,        1,
		radt                     = 30,       30,       30,
		sf_sfclay_physics        = 1,        1,        1,
		sf_surface_physics       = 1,        1,        1,
		bl_pbl_physics           = 1,        1,        1,
		bldt                     = 0,        0,        0,
		cu_physics               = 1,        1,        0,
		cudt                     = 5,        5,        5,
		isfflx                   = 1,
		ifsnow                   = 0,
		icloud                   = 1,
		surface_input_source     = 1,
		num_soil_layers          = 5,
		mp_zero_out              = 0,
		maxiens                  = 1,
		maxens                   = 3,
		maxens2                  = 3,
		maxens3                  = 16,
		ensdim                   = 144,
		/

		&fdda                    
		/

		&dynamics                
		diff_opt                 = 0,
		km_opt                   = 4,
		damp_opt                 = 3,
		base_temp                = 290.,
		zdamp                    = 5000.,    5000.,    5000.,
		dampcoef                 = 0.2,      0.2,      0.2,
		khdif                    = 0,        0,        0,
		kvdif                    = 0,        0,        0,
		non_hydrostatic          = .true.,   .true.,   .true.,
		moist_adv_opt            = 0,        0,        0,
		scalar_adv_opt           = 0,        0,        0,
		chem_adv_opt             = 0,        0,        0,
		tke_adv_opt              = 0,        0,        0,
		fft_filter_lat           = 45.,
		w_damping                = 1,
		/

		&bdy_control             
		periodic_x               = .true.,  .false.,  .false.,
		symmetric_xs             = .false.,  .false.,  .false.,
		symmetric_xe             = .false.,  .false.,  .false.,
		open_xs                  = .false.,  .false.,  .false.,
		open_xe                  = .false.,  .false.,  .false.,
		periodic_y               = .false.,  .false.,  .false.,
		symmetric_ys             = .false.,  .false.,  .false.,
		symmetric_ye             = .false.,  .false.,  .false.,
		open_ys                  = .false.,  .false.,  .false.,
		open_ye                  = .false.,  .false.,  .false.,
		nested                   = .false.,   .true.,   .true.,
		polar                    = .true.,  .false.,  .false.,
		/

		&grib2                   
		/

		&namelist_quilt          
		nio_tasks_per_group      = 0,
		nio_groups               = 1,
		/
End_Of_Namelist

###############################################################################################################



#Run Sequence

echo "---BEGINNING Pure-WRF-ARW RUN---" >> $dropbox/system/WRF_STATUS.log
echo "Pure WRF-ARW:" >> $dropbox/system/WRF_STATUS.log
cd pure_arw/wpsprd
./geogrid.exe >> $dropbox/system/WRF_glb.log
echo "Geogrid Complete!" >> $dropbox/system/WRF_STATUS.log
(date  +"%H:%M:%S") >> $dropbox/system/WRF_STATUS.log

ln -sf ../../../WRF-ARW/WPS/ungrib/Variable_Tables/Vtable.GFS Vtable
echo "GFS Vtables linked!" >> $dropbox/system/WRF_STATUS.log
(date  +"%H:%M:%S") >> $dropbox/system/WRF_STATUS.log
./link_grib.csh ../../../DATA/GFS"$fhour"/gfs.t"$fhour"z.pgrbf00.2p5deg.grib2
echo "Grib Files Linked!" >> $dropbox/system/WRF_STATUS.log
(date  +"%H:%M:%S") >> $dropbox/system/WRF_STATUS.log
./ungrib.exe >> $dropbox/system/WRF_glb.log
echo "Ungribed!" >> $dropbox/system/WRF_STATUS.log
(date  +"%H:%M:%S") >> $dropbox/system/WRF_STATUS.log

./metgrid.exe >> $dropbox/system/WRF_glb.log
echo "Metgrid Complete!" >> $dropbox/system/WRF_STATUS.log
(date  +"%H:%M:%S") >> $dropbox/system/WRF_STATUS.log

cd ../wrfprd
ln -sf ../wpsprd/met_em* .
echo "WPS Output Linked!" >> $dropbox/system/WRF_STATUS.log
(date  +"%H:%M:%S") >> $dropbox/system/WRF_STATUS.log
./real.exe >> $dropbox/system/WRF_glb.log
echo "real.exe Complete!" >> $dropbox/system/WRF_STATUS.log
(date  +"%H:%M:%S") >> $dropbox/system/WRF_STATUS.log
./wrf.exe >> $dropbox/system/WRF_glb.log
echo "WRF-ARW COMPLETE!!!" >> $dropbox/system/WRF_STATUS.log
(date  +"%H:%M:%S") >> $dropbox/system/WRF_STATUS.log


echo "Models Complete, Plotting Data..." >> $dropbox/system/WRF_STATUS.log


# Output a nice NCL PDF Plot in 6hr intervals
cp wrfout_d01_"$start_year"-"$start_mon"-"$start_day"_"$start_hour":00:00 ../../NCL_SCRIPTS/wrfoutd01.nc
cp wrfout_d02_"$start_year"-"$start_mon"-"$start_day"_"$start_hour":00:00 ../../NCL_SCRIPTS/wrfoutd02.nc
cp wrfout_d03_"$start_year"-"$start_mon"-"$start_day"_"$start_hour":00:00 ../../NCL_SCRIPTS/wrfoutd03.nc

cd ../../NCL_SCRIPTS

# Run NCL plotting scripts
ncl globalplot.ncl >> $dropbox/system/WRF_glb.log
ncl meteo.ncl >> $dropbox/system/WRF_glb.log
#ncl upprplt.ncl >> $dropbox/system/WRF_glb.log

# Place plots in publishing folder

scp 12kmsfc-* wxdisplay@10.17.157.196:/home/weewx/public_html/WRF_ARW/global/12km/surface
scp 12kmradar-* wxdisplay@10.17.157.196:/home/weewx/public_html/WRF_ARW/global/12km/radar
scp 12kmupperair-* wxdisplay@10.17.157.196:/home/weewx/public_html/WRF_ARW/global/12km/upper
scp 12kmmeteo-* wxdisplay@10.17.157.196:/home/weewx/public_html/WRF_ARW/global/surface/12km/meteo

echo "WRF-ARW Output Successfully Plotted!" >> $dropbox/system/WRF_STATUS.log
(date  +"%H:%M:%S") >> $dropbox/system/WRF_STATUS.log

echo "CLEANING UP... ..."

rm pwrfout*
cp wrfoutd01.nc pwrfoutd01.nc
cp wrfoutd02.nc pwrfoutd02.nc
cp wrfoutd03.nc pwrfoutd03.nc
rm wrfout* 
rm 12km*

cd ../pure_arw/wpsprd
rm met_em* 
rm GRIBFILE*
rm NAM*
rm PFILE* 
rm FILE*

cd ../wrfprd
rm met_em* 
rm wrfout* 

######################################### END #########################################
