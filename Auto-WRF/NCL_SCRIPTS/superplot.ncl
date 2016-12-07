load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"  
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/skewt_func.ncl"   
;load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "/home/wxdisplay/Models/DOMAINS/NCL_SCRIPTS/Modified_Libs/WRFUserARW_FIX.ncl" ; THIS FILE FIXES LOW/HIGH COLOR LABELING
;load "./WRFUserARW_FIX.ncl"

begin
; 
; The WRF ARW input file.  
; This needs to have a ".nc" appended, so just do it.
  a = addfile("wrfoutd01.nc","r")

    ;lat2d = wrf_user_getvar(a,"XLAT",18)
    ;lon2d = wrf_user_getvar(a,"XLONG",18) 

; #######################################################################################################################
                                       ; SURFACE SUITE

; We generate plots, but what kind do we prefer?
;  type = "x11"
 type = "pdf"
; type = "ps"
; type = "ncgm"
  wks = gsn_open_wks(type,"Surface1")


; Set some Basic Plot options
  res = True
  
  ;res@Footer = False
  res@NoHeaderFooter           = True            ; Switch headers and footers off
  pltres = True
  pltres@PanelPlot = True      ; Indicate these plots are to be paneled.

  mpres = True
  mpres@mpOutlineBoundarySets = "GeophysicalAndUSStates"
  mpres@mpGeophysicalLineColor      = "chocolate3"
  mpres@mpNationalLineColor         = "chocolate3"
  mpres@mpUSStateLineColor          = "chocolate3"
  mpres@mpLimbLineColor             = "chocolate3"
  mpres@mpPerimLineColor            = "chocolate3"
  mpres@mpGeophysicalLineThicknessF = 2.0
  mpres@mpLimbLineThicknessF        = 2.0
  mpres@mpNationalLineThicknessF    = 2.0
  mpres@mpUSStateLineThicknessF     = 2.0

  times = wrf_user_getvar(a,"times",-1)  ; get all times in the file
  plots = new ( 4, graphic )


  gsn_define_colormap(wks,"temp_19lev")



; SET TIMES FOR THE LOOP

  times = wrf_user_getvar(a,"times",-1)  ; get all times in the file
  ntimes = dimsizes(times)         ; number of times in the file




  do itime = 0,ntimes-1,6
    iplot = 0
    do while (iplot.lt.4)
  
      t = wrf_user_getvar(a,"T2",itime)   ; T2 in Kelvin
      slp = wrf_user_getvar(a,"slp",itime)   ; slp
		wrf_smooth_2d( slp, 3 )    ; smooth slp
      tc = wrf_user_getvar(a,"tc",itime)        ; T in C
      u  = wrf_user_getvar(a,"ua",itime)        ; u averaged to mass points
      v  = wrf_user_getvar(a,"va",itime)        ; v averaged to mass points
      p  = wrf_user_getvar(a, "pressure",itime) ; pressure is our vertical coordinate
      z  = wrf_user_getvar(a, "z",itime)        ; grid point height
      rh = wrf_user_getvar(a,"rh",itime)        ; relative humidity
      q  = wrf_user_getvar(a,"QVAPOR",itime)
      td2 =  wrf_user_getvar(a,"td2",itime)   ; Td2 in C

      tc_plane = wrf_user_intrp3d(tc,p,"h",500,0.,False)
      z_plane  = wrf_user_intrp3d( z,p,"h",500,0.,False)
      rh_plane = wrf_user_intrp3d(rh,p,"h",500,0.,False)
      u_plane  = wrf_user_intrp3d( u,p,"h",500,0.,False)
      v_plane  = wrf_user_intrp3d( v,p,"h",500,0.,False)

      spd     = (u_plane*u_plane + v_plane*v_plane)^(0.5) ; m/sec
      spd@description = "Wind Speed"
      spd@units = "m/s"
      u_plane = u_plane*1.94386     ; kts
      v_plane = v_plane*1.94386     ; kts
      u_plane@units = "kts"
      v_plane@units = "kts"
      z_plane = z_plane/10
      z_plane@units = "dm"
      slp@units = "mb"
      td_f = 1.8*td2+32.                   ; Turn temperature into Fahrenheit
      td_f@description = "Surface Dew Point Temp" 
      td_f@units = "F"
      t2_f = 1.8*(t-273.15)+32.
      t2_f@description = "Surface Temperature"
      t2_f@units = "F"


      ; Plotting options for Surface Pressure
        opts_p = res                          
        opts_p@cnLineColor = "Black"
	opts_p@gsnContourLineThicknessesScale = 3.0
	;opts_p@ContourParameters = (/ 5 /)
        opts_p@cnInfoLabelOn = "true"
        opts_p@cnInfoLabelString = "Sea Level Pressure"
        opts_p@cnInfoLabelSide = "Bottom"
	opts_p@cnInfoLabelFont = 21

	opts_p@cnLowLabelsOn = "true"
	opts_p@cnLowLabelFont = 22
	opts_p@cnLowLabelBackgroundColor = -1
	opts_p@cnLowLabelFontColor = "red"
	opts_p@cnLowLabelFontThicknessF = 2
	opts_p@cnHighLabelsOn = "true"
	opts_p@cnHighLabelFont = 22
	opts_p@cnHighLabelBackgroundColor = -1
	opts_p@cnHighLabelFontColor = "blue"
	opts_p@cnHighLabelFontThicknessF = 2
	
	opts_p@cnLineLabelBackgroundColor = "background"
	opts_p@cnLineLabelPerimOn = "false"
        opts_p@cnLineLabelPlacementMode = "Randomized"
	opts_p@cnLineLabelDensityF = 0.5


        contour_slp = wrf_contour(a,wks,slp,opts_p)

	; Plotting options for Thickness
        opts_thk = res                          
        opts_thk@cnLineColor = "Red"
	opts_thk@gsnContourLineThicknessesScale = 6.0
        opts_thk@gsnContourPosLineDashPattern = 2
	opts_thk@ContourParameters = (/ 450 , 600 , 30 /)
	opts_thk@cnInfoLabelOn = "true"
        opts_thk@cnInfoLabelString = "1000-500mb Thickness"
	opts_thk@cnInfoLabelFont = 21
        opts_thk@cnInfoLabelOrthogonalPosF = 0.07

        opts_thk@cnLineLabelBackgroundColor = "background"
        opts_thk@cnLineLabelFontThicknessF = 5
        opts_thk@cnLineLabelPerimOn = "false"
        ;opts_thk@cnLineLabelPlacementMode = "Randomized"
	;opts_thk@cnLineLabelDensityF = 0.5

	contour_thicksfc5 = wrf_contour(a,wks, z_plane,opts_thk)

	; Plotting options for T                
        optsT = res                          
        optsT@cnFillOn = True 
        optsT@cnLinesOn = False
        optsT@cnLineLabelsOn = False
        optsT@ContourParameters = (/ 2.0 /) 
        optsT@cnLineLabelBackgroundColor = -1
	optsT@gsnSpreadColors   = True
        optsT@cnInfoLabelOrthogonalPosF = 0.07  ; offset second label information
        contour_tc = wrf_contour(a,wks,t2_f,optsT)
        delete(optsT)


      ; Plotting options for RH                
        opts = res                          
        opts@cnFillOn = True  
        opts@pmLabelBarOrthogonalPosF = -0.1
        opts@ContourParameters = (/ 10., 90., 10./)
        opts@cnFillColors = (/"White","White","White", \
                              "White","Chartreuse","Green",\
                              "Green3","Green4", \
                              "ForestGreen","PaleGreen4"/)
        contour_rh = wrf_contour(a,wks,rh_plane,opts)
        delete(opts)


      ; Plotting options for Wind Speed                
        opts = res                          
        opts@cnLineColor = "MediumSeaGreen"
        opts@ContourParameters = (/ 10. /)
        opts@cnInfoLabelOrthogonalPosF = 0.07  ; offset second label information
        opts@gsnContourLineThicknessesScale = 3.0
        contour_spd = wrf_contour(a,wks,spd,opts)
        delete(opts)


      ; Plotting options for Wind Vectors                 
        opts = res          
        opts@FieldTitle = "Wind"   ; overwrite Field Title
        opts@NumVectors = 47       ; wind barb density
        vector = wrf_vector(a,wks,u_plane,v_plane,opts)
        delete(opts)


      ; Plotting options for Geopotential Heigh
        opts_z = res                          
	opts_z@cnInfoLabelFont = 21
        opts_z@cnInfoLabelString = "500mb Heights"
        opts_z@cnLineColor = "Blue"
        opts_z@gsnContourLineThicknessesScale = 3.0

        contour_height = wrf_contour(a,wks,z_plane,opts_z)

	; Plotting options for Td
        opts = res         
        opts@cnFillOn = True 
        opts@cnLinesOn = False
        opts@cnLineLabelsOn = False
        opts@ContourParameters = (/ 2.0 /) 
        opts@cnLineLabelBackgroundColor = -1
	opts@gsnSpreadColors   = True
        ;opts@gsnSpreadColorEnd = -3  ; End third from the last color in color map
        contour_td = wrf_contour(a,wks,td_f,opts)
        delete(opts)
  
      ; Overlay contours on a map
        ;pltres@NoTitles = True
        pltres@CommonTitle = True
        pltres@PlotTitle =  times(itime)
        if ( iplot .eq. 0 ) then 
        plots(iplot) = wrf_map_overlays(a,wks,(/contour_slp, contour_thicksfc5/),pltres,mpres)
        ;delete(contour)
        end if
        
        if ( iplot .eq. 1 ) then
        plots(iplot) = wrf_map_overlays(a,wks,(/contour_height/),pltres,mpres)
        ;delete(contour)
        end if

	if ( iplot .eq. 2 ) then
        plots(iplot) = wrf_map_overlays(a,wks,(/contour_tc/),pltres,mpres)
        ;delete(contour)
        end if

	if ( iplot .eq. 3 ) then
        plots(iplot) = wrf_map_overlays(a,wks,(/contour_td/),pltres,mpres)
        ;delete(contour)
        end if

      iplot = iplot + 1
  
    end do
  
  ; Panel the WRF plots.
    pnlres                            = True
    pnlres@txString                   = "WRF-ARW"
    pnlres@gsnPanelYWhiteSpacePercent = 13       ; Add white space b/w plots.
    pnlres@gsnPanelLabelBar           = True    ; Turn on common labelbar
    pnlres@lbLabelAutoStride          = True    ; Spacing of lbar labels.
    pnlres@lbBoxMinorExtentF          = 0.13

    gsn_panel(wks,(/plots/),(/2,2/),pnlres)

  end do
delete(wks)

; #############################################################################################################################
;                                                      UPPER SUITE

; We generate plots, but what kind do we prefer?
;  type = "x11"
 type = "pdf"
; type = "ps"
; type = "ncgm"
  wks = gsn_open_wks(type,"UpperAirPlot")


; Set some Basic Plot options
  res = True
  
  ;res@Footer = False
  res@NoHeaderFooter           = True            ; Switch headers and footers off
  pltres = True
  pltres@PanelPlot = True      ; Indicate these plots are to be paneled.

  mpres = True
  mpres@mpGeophysicalLineColor      = "chocolate3"
  mpres@mpNationalLineColor         = "chocolate3"
  mpres@mpUSStateLineColor          = "chocolate3"
  mpres@mpLimbLineColor             = "chocolate3"
  mpres@mpPerimLineColor            = "chocolate3"
  mpres@mpGeophysicalLineThicknessF = 2.0
  mpres@mpLimbLineThicknessF        = 2.0
  mpres@mpNationalLineThicknessF    = 2.0
  mpres@mpUSStateLineThicknessF     = 2.0

  times = wrf_user_getvar(a,"times",-1)  ; get all times in the file
  plots = new ( 4, graphic )


  



; SET TIMES FOR THE LOOP

  times = wrf_user_getvar(a,"times",-1)  ; get all times in the file
  ntimes = dimsizes(times)         ; number of times in the file
  
  pressure_levels = (/ 850., 700., 500., 300./)   ; pressure levels to plot
  nlevels         = dimsizes(pressure_levels)     ; number of pressure levels



  do itime = 0,ntimes-1,6
    iplot = 0
    do while (iplot.lt.4)
    
  
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; First get the variables we will need        

    tc = wrf_user_getvar(a,"tc",itime)        ; T in C
    u  = wrf_user_getvar(a,"ua",itime)        ; u averaged to mass points
    v  = wrf_user_getvar(a,"va",itime)        ; v averaged to mass points
    p  = wrf_user_getvar(a, "pressure",itime) ; pressure is our vertical coordinate
    z  = wrf_user_getvar(a, "z",itime)        ; grid point height
    rh = wrf_user_getvar(a,"rh",itime)        ; relative humidity

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                

      pressure = pressure_levels(iplot)

      tc_plane = wrf_user_intrp3d(tc,p,"h",pressure,0.,False)
      z_plane  = wrf_user_intrp3d( z,p,"h",pressure,0.,False)
      rh_plane = wrf_user_intrp3d(rh,p,"h",pressure,0.,False)
      u_plane  = wrf_user_intrp3d( u,p,"h",pressure,0.,False)
      v_plane  = wrf_user_intrp3d( v,p,"h",pressure,0.,False)

      spd     = (u_plane*u_plane + v_plane*v_plane)^(0.5) ; m/sec
      spd@description = "Wind Speed"
      spd@units = "m/s"
      u_plane = u_plane*1.94386     ; kts
      v_plane = v_plane*1.94386     ; kts
      u_plane@units = "kts"
      v_plane@units = "kts"


      ; Plotting options for T                
        opts = res                          
        opts@cnLineColor = "Red"
        opts@ContourParameters = (/ 5.0 /)
        opts@cnInfoLabelOrthogonalPosF = 0.07  ; offset second label information
        opts@gsnContourLineThicknessesScale = 2.0
        contour_tc = wrf_contour(a,wks,tc_plane,opts)
        delete(opts)


      ; Plotting options for RH                
        opts = res                          
        opts@cnFillOn = True  
        opts@pmLabelBarOrthogonalPosF = -0.1
        opts@ContourParameters = (/ 10., 90., 10./)
        opts@cnFillColors = (/"White","White","White", \
                              "White","Chartreuse","Green",\
                              "Green3","Green4", \
                              "ForestGreen","PaleGreen4"/)
        contour_rh = wrf_contour(a,wks,rh_plane,opts)
        delete(opts)


      ; Plotting options for Wind Speed                
        opts = res                          
        opts@cnLineColor = "MediumSeaGreen"
        opts@ContourParameters = (/ 10. /)
        opts@cnInfoLabelOrthogonalPosF = 0.07  ; offset second label information
        opts@gsnContourLineThicknessesScale = 3.0
        contour_spd = wrf_contour(a,wks,spd,opts)
        delete(opts)


      ; Plotting options for Wind Vectors                 
        opts = res          
        opts@FieldTitle = "Wind"   ; overwrite Field Title
        opts@NumVectors = 47       ; wind barb density
        vector = wrf_vector(a,wks,u_plane,v_plane,opts)
        delete(opts)


      ; Plotting options for Geopotential Height
        opts_z = res                          
        opts_z@cnLineColor = "Blue"
        opts_z@gsnContourLineThicknessesScale = 3.0


  
      ; Overlay contours on a map
        ;pltres@NoTitles = True
        pltres@CommonTitle = True
        pltres@PlotTitle =  times(itime)
        if ( iplot .eq. 0 ) then 
		  opts_z@cnInfoLabelString = "850mb Heights/RH"
		  opts_z@ContourParameters = (/ 20.0 /)
		  contour_height = wrf_contour(a,wks,z_plane,opts_z)
		  plots(iplot) = wrf_map_overlays(a,wks,(/contour_rh,contour_tc,contour_height, \
		                            vector/),pltres,mpres)
		
        delete(opts_z)
        ;delete(contour)
        end if
        
        if ( iplot .eq. 1 ) then
		  opts_z@cnInfoLabelString = "700mb Heights"
		  opts_z@ContourParameters = (/ 30.0 /)
		  contour_height = wrf_contour(a,wks, z_plane,opts_z)
		  plots(iplot) = wrf_map_overlays(a,wks,(/contour_tc,contour_height, \
		                            vector/),pltres,mpres)
		
		
        delete(opts_z)
        ;delete(contour)
        end if

	if ( iplot .eq. 2 ) then
		
		  opts_z@cnInfoLabelString = "500mb Heights"
		  opts_z@ContourParameters = (/ 60.0 /)
		  contour_height = wrf_contour(a,wks, z_plane,opts_z)
		  plots(iplot) = wrf_map_overlays(a,wks,(/contour_tc,contour_height, \
		                            vector/),pltres,mpres)
		
        delete(opts_z)
        ;delete(contour)
        end if

	if ( iplot .eq. 3 ) then
		  opts_z@cnInfoLabelString = "300mb Heights"
		  opts_z@ContourParameters = (/ 60.0 /)
		  contour_height = wrf_contour(a,wks, z_plane,opts_z)
		  plots(iplot) = wrf_map_overlays(a,wks,(/contour_spd,contour_height, \
		                            vector/),pltres,mpres)
		
        delete(opts_z)
        ;delete(contour)
        end if

        iplot=iplot+1
  
    end do
  
  ; Panel the WRF plots.
    pnlres                            = True
    pnlres@txString                   = "WRF-ARW: Upper Air Plots"
    pnlres@gsnPanelYWhiteSpacePercent = 13       ; Add white space b/w plots.
    pnlres@gsnPanelLabelBar           = False    ; Turn on common labelbar
    pnlres@gsnAttachBorderOn          = False
    pnlres@lbLabelAutoStride          = True    ; Spacing of lbar labels.
    pnlres@lbBoxMinorExtentF          = 0.13

    gsn_panel(wks,(/plots/),(/2,2/),pnlres)

  end do

delete(wks)


; #############################################################################################################################
;                                                     BASIC PRECIP PLOTS
; We generate plots, but what kind do we prefer?
;  type = "x11"
 type = "pdf"
; type = "ps"
; type = "ncgm"
  wks = gsn_open_wks(type,"PrecipPlot")

; Set some Basic Plot options
  res = True
  
  ;res@Footer = False
  res@NoHeaderFooter           = False            ; Switch headers and footers off
  pltres = True

  mpres = True
  mpres@mpOutlineBoundarySets = "GeophysicalAndUSStates"
  mpres@mpGeophysicalLineColor      = "chocolate3"
  mpres@mpNationalLineColor         = "chocolate3"
  mpres@mpUSStateLineColor          = "chocolate3"
  mpres@mpLimbLineColor             = "chocolate3"
  mpres@mpPerimLineColor            = "chocolate3"
  mpres@mpGeophysicalLineThicknessF = 2.0
  mpres@mpLimbLineThicknessF        = 2.0
  mpres@mpNationalLineThicknessF    = 2.0
  mpres@mpUSStateLineThicknessF     = 2.0

  times = wrf_user_getvar(a,"times",-1)  ; get all times in the file

; SET TIMES FOR THE LOOP
  FirstTime = True
  times = wrf_user_getvar(a,"times",-1)  ; get all times in the file
  ntimes = dimsizes(times)         ; number of times in the file

  do it = 0,ntimes-1,3
    
  
            print("Working on time: " + times(it) )
    if (FirstTime) then            ; Save some times for tracking tendencies
      times_sav = times(it)
    end if
    res@TimeLabel = times(it)   ; Set Valid time to use on plots

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; First get the variables we will need        

    slp = wrf_user_getvar(a,"slp",it)  ; slp
      wrf_smooth_2d( slp, 3 )            ; smooth slp

  ; Get non-convective, convective and total precipitation
  ; Calculate tendency values                               
    rain_exp = wrf_user_getvar(a,"RAINNC",it)
    rain_con = wrf_user_getvar(a,"RAINC",it)
    T2       = wrf_user_getvar(a,"T2",it)
    	T2 = 1.8*(T2-273.15)+32
	T2@description = "Surface Temperature"
	T2@units = "F"
    rain_exp = rain_exp*0.0393701
    rain_con = rain_con*0.0393701
    rain_tot = rain_exp + rain_con
    rain_tot@description = "Total Precipitation"
    rain_tot@units = "in"

    if( FirstTime ) then
      if ( it .eq. 0 ) then

        rain_exp_save = rain_exp
        rain_con_save = rain_con
        rain_tot_save = rain_tot

      else

        rain_exp_save = wrf_user_getvar(a,"RAINNC",it-1)
		rain_exp_save = rain_exp_save*0.0393701

        rain_con_save = wrf_user_getvar(a,"RAINC",it-1) 
		rain_con_save = rain_con_save*0.0393701
        rain_tot_save = rain_exp_save + rain_con_save
        FirstTime = False
        times_sav = times(it-1)

      end if
    end if

    	

    rain_exp_tend = rain_exp - rain_exp_save
    rain_con_tend = rain_con - rain_con_save
    rain_tot_tend = rain_tot - rain_tot_save
    rain_exp_tend@description = "3hr Non-Convective Precipitation"
	rain_exp_tend@units = "in"
    rain_con_tend@description = "3hr Convective Precipitation"
	rain_con_tend@units = "in"
    rain_tot_tend@description = "3hr Precip Total"
	rain_tot_tend@units = "in"

  ; Bookkeeping, just to allow the tendency at the next time step
    rain_exp_save = rain_exp
    rain_con_save = rain_con
    rain_tot_save = rain_tot

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    if( .not. FirstTime ) then     ; We will skip the first time

      ; Plotting options for Sea Level Pressure
        opts_psl = res          
        opts_psl@ContourParameters = (/ 900., 1100., 2. /)
        opts_psl@cnLineColor       = "grey40"
        opts_psl@cnInfoLabelOn     = False
        opts_psl@cnLineLabelFontHeightF = 0.01
        opts_psl@cnLineLabelPerimOn = False
        opts_psl@gsnContourLineThicknessesScale = 1.5
        contour_psl = wrf_contour(a,wks,slp,opts_psl)
        delete(opts_psl)
	
	opts_t = res                          
        opts_t@cnLineColor = "blue"
	opts_t@gsnContourLineThicknessesScale = 2.0
	opts_t@ContourParameters = (/ 32 , 33, 1 /)
	opts_t@cnInfoLabelOn = "false"
        opts_t@cnInfoLabelString = "Freezing Line"
	opts_t@cnInfoLabelFont = 21
        opts_t@cnInfoLabelOrthogonalPosF = 0.07

        ;opts_t@cnLineLabelBackgroundColor = "background"
        ;opts_t@cnLineLabelFontThicknessF = 5
        ;opts_t@cnLineLabelPerimOn = "false"
        ;opts_t@cnLineLabelPlacementMode = "Randomized"
	;opts_t@cnLineLabelDensityF = 0.5

	contour_t = wrf_contour(a,wks, T2 ,opts_t)
	delete(opts_t)
    

      ; Plotting options for Precipitation
        opts_r = res                        
        opts_r@cnLevelSelectionMode = "ExplicitLevels"
        opts_r@cnLevels             = (/ .05, .1, .25, .5, .75, 1, 1.25, 1.5, \
                                        1.75, 2, 2.5, 3/)
        opts_r@cnFillColors         = (/"white","DarkOliveGreen2","DarkOliveGreen3","Chartreuse", \
                                        "Chartreuse3","Green", \
                                        "ForestGreen","Yellow","Orange", \
                                        "Red","Orangered4","violetred","Violet"/)
        opts_r@cnInfoLabelOn        = False
        opts_r@cnConstFLabelOn      = False
        opts_r@cnFillOn             = True
    

      ; Total Precipitation (color fill)
        contour_tot = wrf_contour(a,wks, rain_tot, opts_r)
    
      ; Precipitation Tendencies 
        opts_r@SubFieldTitle = "from " + times_sav + " to " + times(it)
    
        contour_tend = wrf_contour(a,wks, rain_tot_tend,opts_r) ; total (color)
        contour_res = wrf_contour(a,wks,rain_exp_tend,opts_r)   ; exp (color)
        opts_r@cnFillOn = False
        opts_r@cnLineColor = "Red4"
        contour_prm = wrf_contour(a,wks,rain_con_tend,opts_r)   ; con (red lines)
        delete(opts_r)



      ; MAKE PLOTS                                       

        ; Total Precipitation 
          plot = wrf_map_overlays(a,wks,contour_tot,pltres,mpres)

        ; 3hr Precip Total
          plot = wrf_map_overlays(a,wks,(/contour_tend,contour_psl,contour_t/),pltres,mpres)

        ; Non-Convective and Convective Precipiation Tendencies 
        ;  plot = wrf_map_overlays(a,wks,(/contour_res,contour_prm/),pltres,mpres)
	end if




  end do

delete(wks)
;####################################################################################################################################

;                                                 RADAR PLOT

; We generate plots, but what kind do we prefer?
; type = "x11"
; type = "pdf"
 type = "ps"
; type = "ncgm"
  wks = gsn_open_wks(type,"animate")
  
; Set some Basic Plot options
  res = True
  
  res@Footer = False
  res@MainTitle                   = "WRF-ARW Simulated Radar"

  pltres = True

  mpres = True
  mpres@mpOutlineBoundarySets = "GeophysicalAndUSStates"
  mpres@mpGeophysicalLineColor      = "chocolate3"
  mpres@mpNationalLineColor         = "chocolate3"
  mpres@mpUSStateLineColor          = "chocolate3"
  mpres@mpLimbLineColor             = "chocolate3"
  mpres@mpPerimLineColor            = "chocolate3"
  mpres@mpGeophysicalLineThicknessF = 2.0
  mpres@mpLimbLineThicknessF        = 2.0
  mpres@mpNationalLineThicknessF    = 2.0
  mpres@mpUSStateLineThicknessF     = 2.0
  ;gsn_define_colormap(wks,"radar")

  times = wrf_user_getvar(a,"times",-1)  ; get all times in the file

; SET TIMES FOR THE LOOP
  FirstTime = True
  times = wrf_user_getvar(a,"times",-1)  ; get all times in the file
  ntimes = dimsizes(times)         ; number of times in the file

  do it = 0,ntimes-1,1
    
  
            print("Working on time: " + times(it) )
    if (FirstTime) then            ; Save some times for tracking tendencies
      times_sav = times(it)
    end if
    res@TimeLabel = times(it)   ; Set Valid time to use on plots

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; First get the variables we will need   
	if( .not. FirstTime ) then	
	slp = wrf_user_getvar(a,"slp",it)  ; slp
      		wrf_smooth_2d( slp, 3 )            ; smooth slp
	dbz = wrf_user_getvar(a,"mdbz",it)
		wrf_smooth_2d( dbz, 2 )    ; smooth dbz


	opts = res
	;opts@cnLevelSelectionMode = "ExplicitLevels"
        ;opts@cnLevels             = (/ .05, .1, .25, .5, .75, 1, 1.25, 1.5, \
        ;                                1.75, 2, 2.5, 3/)
        opts@cnFillColors         = (/"white","paleturquoise","deepskyblue","deepskyblue2", \
                                        "green","green3","forestgreen", \
                                        "yellow","yellow3","orange", \
                                        "red","red3","red4","plum","plum4","purple","white"/)
        opts@cnInfoLabelOn        = False
        opts@cnConstFLabelOn      = False
	opts@cnFillOn        = True
	opts@cnLinesOn       = False
	opts@cnLineLabelsOn  = False
	opts@gsnSpreadColors = True
	;opts@gsnSpreadColorEnd = -5
	opts@ContourParameters = (/ -25 , 50, 5 /)
	contour_dbz = wrf_contour(a,wks,dbz,opts)
	delete(opts)

	opts_psl = res          
        opts_psl@ContourParameters = (/ 900., 1100., 2. /)
        opts_psl@cnLineColor       = "grey40"
        opts_psl@cnInfoLabelOn     = False
        opts_psl@cnLineLabelFontHeightF = 0.01
        opts_psl@cnLineLabelPerimOn = False
        opts_psl@gsnContourLineThicknessesScale = 1.5
        contour_psl = wrf_contour(a,wks,slp,opts_psl)
        delete(opts_psl)

	plot = wrf_map_overlays(a,wks,(/contour_dbz,contour_psl/),pltres,mpres)
	end if
	
	FirstTime=False
  end do
delete(wks)

cmd = "convert -rotate -0 -delay 75 animate.ps radar.gif"
system(cmd)

; ###########################################################################################################################
;                                                 Sounding Suite

; We generate plots, but what kind do we prefer?
;  type = "x11"
 type = "pdf"
; type = "ps"
; type = "ncgm"
  wks = gsn_open_wks(type,"SoundingPlot")

  gsn_define_colormap(wks,"WhViBlGrYeOrReWh")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; What times and how many time steps are in the data set?
  FirstTime = True
  times  = wrf_user_list_times(a)  ; get times in the file
  ntimes = dimsizes(times)         ; number of times in the file

; Get some dimension info - so we can later check to make sure 
; the sounding locations are inside the model domain
  mdims = getfilevardimsizes(a,"P")
  nd = dimsizes(mdims)
  dimX = mdims(nd-1)
  dimY = mdims(nd-2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  do it = 0,ntimes-1        ; TIME LOOP

    print("Working on time: " + times(it) )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; First get the variables we will need        

    tc  = wrf_user_getvar(a,"tc",it)         ; T in C
    td  = wrf_user_getvar(a,"td",it)         ; dew point temperature
    p   = wrf_user_getvar(a, "pressure",it)  ; grid point pressure
    z   = wrf_user_getvar(a, "z",it)         ; grid point height
    uvm = wrf_user_getvar(a,"uvmet",it)      ; umet and vmet averaged to mass points
					     ; This is a 4D array where
					     ; uvm(0,:,:,:) is umet, and
					     ; uvm(1,:,:,:) is vmet, and
					     ; This function rotate winds to earth coord.

    ; extract u and v from uvm array, and turn wind into kts
      u   = uvm(0,:,:,:)*1.94386 
      v   = uvm(1,:,:,:)*1.94386

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 ; Stations, and their lat/lon locations

      ip_locs = (/ "UNC Charlotte (NC,USA)", "Charlotte-Douglas Intl Airport (NC,USA)", \
                   "Greensboro Intl Airport (NC,USA)", "Raleigh-Durham Intl Airport (NC,USA)", "Wilmington Intl Airport (NC,USA)", \
                   "Asheville Regional Airport (NC,USA)", "Greer/Spartanburg Intl Airport (SC,USA)", "Columbia Metro Airport (SC,USA)", \
                   "Cape Hatteras (NC,USA)", "Danville Regional Airport (VA,USA)", \
                   "Cape Town (RSA)", "London / Heathrow (UKI)", \
                   "Dublin Airport (IRL)", "Amsterdam Airport (NED)", \
                   "Osaka Airport (JPN)", "Cairo Airport (EGY)", \
                   "Nairobi Airport (KEN)", "Victoria Airport (CAN)", \
                   "Auckland Airport (NZL)", "Fort Knox (KY,USA)" /)

      ip_lats = (/   35.31,   35.21,   41.18,   35.13,   37.14,   35.13,   43.34, \
                     38.56,   35.16,  -37.40,  -33.59,   51.29,   53.26,   52.18, \
                     34.47,   30.08,   -1.19,   48.39,  -37.01,   37.54 /)

      ip_lons = (/  -80.73,  -80.95,  -95.53,  -97.27,  -93.23, -101.43, -116.14, \
                    -77.26,  -75.33,  144.50,   18.36,    0.27,   -6.15,    4.46, \
                    135.27,   31.24,   36.55, -123.26,  174.48,  -85.58 /)


   do ip = 0, 19   ; LOOP through above 20 station locations and
                   ; plot a skewT if location is inside model domain


      ; Get ij point in model domain for location "ip"
      ; loc(1) is south-north (y) and loc(0) is west-east (x)
        loc = wrf_user_ll_to_ij(a, ip_lons(ip), ip_lats(ip), True)
        locX = loc(0)
        locY = loc(1)

      if ( locX .lt. 1 .or. locX .gt. dimX .or. locY .lt. 1 .or. locY .gt. dimY )
         if ( FirstTime)
           print("Attempting to plot: " + "Station - " + ip_locs(ip) )
           print("                    " + "at location: "+ ip_lats(ip) +" ; "+ ip_lons(ip) )
           print("                    " + "SKIP: Sounding outside model domain" )
         end if
      else

       ; We need array points in NCL space 
         locX = locX - 1
         locY = locY - 1

  ;      Define a few skew-T plotting options
         skewtOpts          = True
         skewtOpts@DrawHeightScale   = True    ; plot height scale on side
         skewtOpts@DrawHeightScaleFt = False   ; plot height scale in km
         skewtOpts@DrawStandardAtm   = True    ; draw standard atm on plot
         skewtOpts@vpXF              = 0.12    ; controls off-set from left
         skewtOpts@vpYF              = 0.87    ; controls off-set from top
         skewtOpts@vpWidthF          = 0.75    ; controls size of plot
         skewtOpts@vpHeightF         = 0.75    ; controls size of plot
         skewtOpts@DrawFahrenheit    = False   ; use deg C scale
         skewtOpts@tiMainFontHeightF = 0.015   ; change height of main title
        ;skewtOpts@DrawColLine       = False   ; draw lines in black
         skewtOpts@DrawColAreaFill   = True    ; color on background plot
        ;skewtOpts@DrawColAreaColor  = "Green" ; final color may depend on the color table used
         skewtOpts@DrawColAreaColor  = 53      ; Light Green for WhViBlGrYeOrReWh color table
         skewtOpts@PrintOpts         = False   ; do not print options out


  ;      Get the skew-T background
         skewtOpts@tiMainString = ip_locs(ip)  + " at " + times(it)
         skewt_bkgd             = skewT_BackGround (wks, skewtOpts)
         draw (skewt_bkgd)


  ;      Draw the skew-T plot
         dataOpts           = True
         dataOpts@Parcel    = 1
         dataOpts@WspdWdir  = False  ; wind speed and dir [else: u,v]
         dataOpts@HspdHdir  = True   ; wind speed and dir [else: u,v]
         dataOpts@PlotWindH = False  ; plot wind barbs at h lvls [pibal; special]
         skewT_data = skewT_PlotData(wks, skewt_bkgd, p(:,locY,locX), \
                                                     tc(:,locY,locX), \
                                                     td(:,locY,locX), \
                                                      z(:,locY,locX), \
                                                      u(:,locY,locX), \
                                                      v(:,locY,locX), \
                                                     dataOpts)

  ;      Close the frame
         frame(wks)

         delete(skewtOpts)
         delete(dataOpts)
         delete(skewT_data)
         delete(skewt_bkgd)

      end if

   end do     ; END OF LOCATIONS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    FirstTime = False

  end do        ; END OF TIME LOOP

delete(wks)

;################################################################################################################################
;                                           SEVERE WEATHER SUITE

; We generate plots, but what kind do we prefer?
;  type = "x11"
 type = "pdf"
; type = "ps"
; type = "ncgm"
  wks = gsn_open_wks(type,"capeplt")


; Set some Basic Plot options
  res = True
  res@MainTitle                   = "WRF-ARW: CAPE/CIN"
  res@Footer = False

  pltres = True
  mpres = True
  mpres@mpGeophysicalLineColor      = "chocolate3"
  mpres@mpNationalLineColor         = "chocolate3"
  mpres@mpUSStateLineColor          = "chocolate3"
  mpres@mpLimbLineColor             = "chocolate3"
  mpres@mpPerimLineColor            = "chocolate3"
  mpres@mpGeophysicalLineThicknessF = 2.0
  mpres@mpLimbLineThicknessF        = 2.0
  mpres@mpNationalLineThicknessF    = 2.0
  mpres@mpUSStateLineThicknessF     = 2.0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  times = wrf_user_getvar(a,"times",-1)  ; get all times in the file
  ntimes = dimsizes(times)         ; number of times in the file
  do it = 0,ntimes-1,6             ; TIME LOOP

    print("Working on time: " + times(it) )
    res@TimeLabel = times(it)   ; Set Valid time to use on plots

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; First get the variables we will need        

    tc = wrf_user_getvar(a,"tc",it)        ; T in C
    T2 = wrf_user_getvar(a,"T2",it)
    u  = wrf_user_getvar(a,"ua",it)        ; u averaged to mass points
    v  = wrf_user_getvar(a,"va",it)        ; v averaged to mass points
    p  = wrf_user_getvar(a, "pressure",it) ; pressure is our vertical coordinate
    z  = wrf_user_getvar(a, "z",it)        ; grid point height
    rh = wrf_user_getvar(a,"rh",it)        ; relative humidity
    q  = wrf_user_getvar(a,"QVAPOR",it)
    slp = wrf_user_getvar(a,"slp",it)  ; calculate SLP
    td2 =  wrf_user_getvar(a,"td2",it)   ; Td2 in C
    zsfc = wrf_user_getvar(a, "HGT", it)
    psfc = wrf_user_getvar(a, "PSFC", it)
    cape3d  = wrf_user_getvar(a, "cape_3d",it)
    cape2d  = wrf_user_getvar(a, "cape_2d",it)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

      
; SETUP ADDITIONAL VARIABLES/UNIT CONVERSIONS

      tc_plane = wrf_user_intrp3d(tc,p,"h",500,0.,False)
      z_plane  = wrf_user_intrp3d( z,p,"h",500,0.,False)
      rh_plane = wrf_user_intrp3d(rh,p,"h",500,0.,False)
      u_plane  = wrf_user_intrp3d( u,p,"h",500,0.,False)
      v_plane  = wrf_user_intrp3d( v,p,"h",500,0.,False)
      
      
      T2 = T2-273.15
      T2 = T2*(9/5)+32
      T2@units = "F"

      spd     = (u_plane*u_plane + v_plane*v_plane)^(0.5) ; m/sec
      spd@description = "Wind Speed"
      spd@units = "m/s"

      u_plane = u_plane*1.94386     ; kts
      v_plane = v_plane*1.94386     ; kts
      u_plane@units = "kts"
      v_plane@units = "kts"

      z_plane = z_plane/10
      z_plane@units = "dm"

      slp@units = "mb"

      td_f = 1.8*td2+32.                   ; Turn temperature into Fahrenheit
      td_f@description = "Surface Dew Point Temp" 
      td_f@units = "F"

      cape  = cape3d(0,:,:,:)
      cin   = cape3d(1,:,:,:)
      mcape = cape2d(0,:,:)
      mcin  = cape2d(1,:,:)
      lcl   = cape2d(2,:,:)
      lfc   = cape2d(3,:,:)  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; BEGIN SETTING UP PLOT RESOURCES

opts = res                         
  opts@cnFillOn = True  
  opts@cnLineLabelsOn = False
 

  opts@FieldTitle = "mcape"
  opts@ContourParameters = (/ 500., 3000., 250./)
  contour = wrf_contour(a,wks,mcape,opts)
  plot = wrf_map_overlays(a,wks,(/contour/),pltres,mpres)


  opts@FieldTitle = "mcin"
  opts@ContourParameters = (/ 0., 125., 25./)
  contour = wrf_contour(a,wks,mcin,opts)
  plot = wrf_map_overlays(a,wks,(/contour/),pltres,mpres)


  opts@FieldTitle = "lfc"
  opts@ContourParameters = (/ 200., 3800., 400./)
  contour = wrf_contour(a,wks,lfc,opts)
  plot = wrf_map_overlays(a,wks,(/contour/),pltres,mpres)


  opts@FieldTitle = "lcl"
  opts@ContourParameters = (/ 200., 3800., 400./)
  contour = wrf_contour(a,wks,lcl,opts)
  plot = wrf_map_overlays(a,wks,(/contour/),pltres,mpres)
      opts@FieldTitle = "cape"
	  opts@ContourParameters = (/ 250., 3250., 250./)
	  do il = 0,9                                   ; only interested in the first 10 levels
	    ilev = il + 1
	    opts@PlotLevelID = "level " + ilev
	    contour = wrf_contour(a,wks,cape(il,:,:),opts)
	    plot = wrf_map_overlays(a,wks,(/contour/),pltres,mpres)
	  end do


  opts@FieldTitle = "cin"
	  opts@ContourParameters = (/ 0., 300., 25./)
	  do il = 0,9                                   ; only interested in the first 10 levels
	    ilev = il + 1
	    opts@PlotLevelID = "level " + ilev
	    contour = wrf_contour(a,wks,cin(il,:,:),opts)
	    plot = wrf_map_overlays(a,wks,(/contour/),pltres,mpres)
	  end do
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  end do        ; END OF TIME LOOP
delete(wks)

end
