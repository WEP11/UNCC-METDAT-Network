load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"  
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/skewt_func.ncl"   
;load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "/home/wxdisplay/Models/DOMAINS/NCL_SCRIPTS/Modified_Libs/WRFUserARW.ncl" ; THIS FILE FIXES LOW/HIGH COLOR LABELING
;load "./WRFUserARW_FIX.ncl"

begin
; 
; The WRF ARW input file.  
; This needs to have a ".nc" appended, so just do it.
  a = addfile("pwrfoutd03.nc","r")

    lat2d = wrf_user_getvar(a,"XLAT",18)
    lon2d = wrf_user_getvar(a,"XLONG",18) 

; #######################################################################################################################
                                       ; SURFACE SUITE

; We generate plots, but what kind do we prefer?
;  type = "x11"
 type = "pdf"
; type = "ps"
; type = "ncgm"
  wks = gsn_open_wks(type,"animate")


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

	lat2d = wrf_user_getvar(a,"XLAT",itime)
    lon2d = wrf_user_getvar(a,"XLONG",itime)    
  
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
	opts_p@sfXArray = lon2d
        opts_p@sfYArray = lat2d                               
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
	opts_thk@sfXArray = lon2d
        opts_thk@sfYArray = lat2d                              
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
	optsT@sfXArray = lon2d
        optsT@sfYArray = lat2d                               
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
	opts@sfXArray = lon2d
        opts@sfYArray = lat2d                            
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
       ; opts = res                          
       ; opts@cnLineColor = "MediumSeaGreen"
       ; opts@ContourParameters = (/ 10. /)
       ; opts@cnInfoLabelOrthogonalPosF = 0.07  ; offset second label information
       ; opts@gsnContourLineThicknessesScale = 3.0
       ; contour_spd = wrf_contour(a,wks,spd,opts)
       ; delete(opts)


      ; Plotting options for Wind Vectors                 
        ;opts = res          
        ;opts@FieldTitle = "Wind"   ; overwrite Field Title
        ;opts@NumVectors = 47       ; wind barb density
        ;vector = wrf_vector(a,wks,u_plane,v_plane,opts)
        ;delete(opts)


      ; Plotting options for Geopotential Heigh
        opts_z = res
	opts_z@sfXArray = lon2d
        opts_z@sfYArray = lat2d                               
	opts_z@cnInfoLabelFont = 21
        opts_z@cnInfoLabelString = "500mb Heights"
        opts_z@cnLineColor = "Blue"
        opts_z@gsnContourLineThicknessesScale = 3.0

        contour_height = wrf_contour(a,wks,z_plane,opts_z)

	; Plotting options for Td
        opts = res
	opts@sfXArray = lon2d
        opts@sfYArray = lat2d              
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
cmd = "convert animate.pdf 12kmsfc.jpg"
system(cmd)

; #############################################################################################################################
;                                                      UPPER SUITE

; We generate plots, but what kind do we prefer?
;  type = "x11"
 type = "pdf"
; type = "ps"
; type = "ncgm"
  wks = gsn_open_wks(type,"animate")


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
    lat2d = wrf_user_getvar(a,"XLAT",itime)
    lon2d = wrf_user_getvar(a,"XLONG",itime)    
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
	opts@sfXArray = lon2d
        opts@sfYArray = lat2d                               
        opts@cnLineColor = "Red"
        opts@ContourParameters = (/ 5.0 /)
        opts@cnInfoLabelOrthogonalPosF = 0.07  ; offset second label information
        opts@gsnContourLineThicknessesScale = 2.0
        contour_tc = wrf_contour(a,wks,tc_plane,opts)
        delete(opts)


      ; Plotting options for RH                
        opts = res
	opts@sfXArray = lon2d
        opts@sfYArray = lat2d                               
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
	opts@sfXArray = lon2d
        opts@sfYArray = lat2d                               
        opts@cnLineColor = "MediumSeaGreen"
        opts@ContourParameters = (/ 10. /)
        opts@cnInfoLabelOrthogonalPosF = 0.07  ; offset second label information
        opts@gsnContourLineThicknessesScale = 3.0
        contour_spd = wrf_contour(a,wks,spd,opts)
        delete(opts)


      ; Plotting options for Wind Vectors                 
      ;  opts = res          
      ;  opts@FieldTitle = "Wind"   ; overwrite Field Title
      ;  opts@NumVectors = 47       ; wind barb density
      ;  vector = wrf_vector(a,wks,u_plane,v_plane,opts)
      ;  delete(opts)


      ; Plotting options for Geopotential Height
        opts_z = res
	opts_z@sfXArray = lon2d
        opts_z@sfYArray = lat2d                               
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
		  plots(iplot) = wrf_map_overlays(a,wks,(/contour_rh,contour_tc,contour_height/),pltres,mpres)
		
        delete(opts_z)
        ;delete(contour)
        end if
        
        if ( iplot .eq. 1 ) then
		  opts_z@cnInfoLabelString = "700mb Heights"
		  opts_z@ContourParameters = (/ 30.0 /)
		  contour_height = wrf_contour(a,wks, z_plane,opts_z)
		  plots(iplot) = wrf_map_overlays(a,wks,(/contour_tc,contour_height/),pltres,mpres)
		
		
        delete(opts_z)
        ;delete(contour)
        end if

	if ( iplot .eq. 2 ) then
		
		  opts_z@cnInfoLabelString = "500mb Heights"
		  opts_z@ContourParameters = (/ 60.0 /)
		  contour_height = wrf_contour(a,wks, z_plane,opts_z)
		  plots(iplot) = wrf_map_overlays(a,wks,(/contour_tc,contour_height/),pltres,mpres)
		
        delete(opts_z)
        ;delete(contour)
        end if

	if ( iplot .eq. 3 ) then
		  opts_z@cnInfoLabelString = "300mb Heights"
		  opts_z@ContourParameters = (/ 60.0 /)
		  contour_height = wrf_contour(a,wks, z_plane,opts_z)
		  plots(iplot) = wrf_map_overlays(a,wks,(/contour_spd,contour_height/),pltres,mpres)
		
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
cmd = "convert animate.pdf 12kmupperair.jpg"
system(cmd)

; #############################################################################################################################
;                                                     BASIC PRECIP PLOTS
; We generate plots, but what kind do we prefer?
;  type = "x11"
 type = "pdf"
; type = "ps"
; type = "ncgm"
  wks = gsn_open_wks(type,"animate")

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
    lat2d = wrf_user_getvar(a,"XLAT",it)
    lon2d = wrf_user_getvar(a,"XLONG",it)                                  
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
	opts_psl@sfXArray = lon2d
        opts_psl@sfYArray = lat2d               
        opts_psl@ContourParameters = (/ 900., 1100., 2. /)
        opts_psl@cnLineColor       = "grey40"
        opts_psl@cnInfoLabelOn     = False
        opts_psl@cnLineLabelFontHeightF = 0.01
        opts_psl@cnLineLabelPerimOn = False
        opts_psl@gsnContourLineThicknessesScale = 1.5
        contour_psl = wrf_contour(a,wks,slp,opts_psl)
        delete(opts_psl)
	
	opts_t = res
	opts_t@sfXArray = lon2d
        opts_t@sfYArray = lat2d                               
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
	opts_r@sfXArray = lon2d
        opts_r@sfYArray = lat2d                             
        ;opts_r@cnLevelSelectionMode = "ExplicitLevels"
        ;opts_r@cnLevels             = (/ .05, .1, .25, .5, .75, 1, 1.25, 1.5, \
        ;                                1.75, 2, 2.5, 3/)
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
        ;  plot = wrf_map_overlays(a,wks,contour_tot,pltres,mpres)

        ; 3hr Precip Total
          plot = wrf_map_overlays(a,wks,(/contour_tend,contour_psl,contour_t/),pltres,mpres)

        ; Non-Convective and Convective Precipiation Tendencies 
        ;  plot = wrf_map_overlays(a,wks,(/contour_res,contour_prm/),pltres,mpres)
	end if




  end do

delete(wks)

cmd = "convert animate.pdf 12kmprecip.jpg"
system(cmd)
;####################################################################################################################################

;                                                 RADAR PLOT

; We generate plots, but what kind do we prefer?
; type = "x11"
 type = "pdf"
; type = "ps"
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
	lat2d = wrf_user_getvar(a,"XLAT",it)
   	lon2d = wrf_user_getvar(a,"XLONG",it)    	
	slp = wrf_user_getvar(a,"slp",it)  ; slp
      		wrf_smooth_2d( slp, 3 )            ; smooth slp
	dbz = wrf_user_getvar(a,"mdbz",it)
		wrf_smooth_2d( dbz, 2 )    ; smooth dbz


	opts = res
	opts@sfXArray = lon2d
        opts@sfYArray = lat2d     
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
	;opts@ContourParameters = (/ -25 , 50, 5 /)
	contour_dbz = wrf_contour(a,wks,dbz,opts)
	delete(opts)

	opts_psl = res 
	opts_psl@sfXArray = lon2d
        opts_psl@sfYArray = lat2d              
        ;opts_psl@ContourParameters = (/ 900., 1100., 2. /)
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

cmd = "convert animate.pdf 12kmradar.jpg"
system(cmd)


end
