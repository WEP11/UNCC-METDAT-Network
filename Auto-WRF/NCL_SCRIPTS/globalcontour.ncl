load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "/home/wxdisplay/Models/DOMAINS/NCL_SCRIPTS/Modified_Libs/WRFUserARW.ncl"
;load "./WRFUserARW.ncl"

begin
;
; The WRF ARW input file.  
; This needs to have a ".nc" appended, so just do it.
a = addfile("wrfoutd03.nc","r")

lat2d = wrf_user_getvar(a,"XLAT",18)
lon2d = wrf_user_getvar(a,"XLONG",18) 

; We generate plots, but what kind do we prefer?
; type = "x11"
 type = "pdf"
; type = "ps"
; type = "ncgm"
 
  wks = gsn_open_wks(type,"surface2")

; Set some basic resources
  res = True
  res@MainTitle                   = "1/3° WRF-ARW"

  pltres = True
  mpres = True


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; What times and how many time steps are in the data set?
  times = wrf_user_getvar(a,"times",-1)  ; get all times in the file
  ntimes = dimsizes(times)         ; number of times in the file

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  do it = 0,ntimes-1,6             ; TIME LOOP 6hrs

    print("Working on time: " + times(it) )
    res@TimeLabel = times(it)   ; Set Valid time to use on plots


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; First get the variables we will need    
    
    lat2d = wrf_user_getvar(a,"XLAT",it)
    lon2d = wrf_user_getvar(a,"XLONG",it)    
    
    dbz = wrf_user_getvar(a,"dbz",it)    ; Reflectivity [dBZ]
    slp = wrf_user_getvar(a,"slp",it)    ; slp
      wrf_smooth_2d( slp, 3 )            ; smooth slp
    prpA = wrf_user_getvar(a,"RAINNC",it)      ; Rainfall (mm)
    snowT = wrf_user_getvar(a,"SNOWNC",it)      ; Snowfall (mm)
    td = wrf_user_getvar(a,"td",it)      ; 3D td 
    u  = wrf_user_getvar(a,"ua",it)      ; 3D U at mass points
    v  = wrf_user_getvar(a,"va",it)      ; 3D V at mass points
    td2 =  wrf_user_getvar(a,"td2",it)   ; Td2 in C
    tc2 = wrf_user_getvar(a,"T2",it)     ; T2 in Kelvin
       tc2 = tc2-273.16                  ; T2 in C
    u10 = wrf_user_getvar(a,"U10",it)    ; u at 10 m, mass point
    v10 = wrf_user_getvar(a,"V10",it)    ; v at 10 m, mass point

;============================================================================
;                             ***CONVERSIONS***

    tf2 = 1.8*tc2+32.                    ; Turn temperature into Fahrenheit
      tf2@description = "Surface Temperature"
      tf2@units = "F"
    td_f = 1.8*td2+32.                   ; Turn temperature into Fahrenheit
      td_f@description = "Surface Dew Point Temp" 
      td_f@units = "F"
    u10 = u10*1.94386                    ; Turn wind into knots
    v10 = v10*1.94386
      u10@units = "kts"
      v10@units = "kts"

    snowT = snowT*0.0393701
      snowT@description = "Total Snowfall"
      snowT@units       = "in"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	 
      gsn_define_colormap(wks,"BlueYellowRed");
    ; Plotting options for T                
      opts_t = res
      opts_t@sfXArray = lon2d
      opts_t@sfYArray = lat2d                         
      opts_t@cnFillOn = True  
      opts_t@ContourParameters = (/ 0., 100., 2./)
      ;opts_t@gsnSpreadColors   = True
      ;opts_t@gsnSpreadColorEnd = -3  ; End third from the last color in color map
      contour_tc = wrf_contour(a,wks,tf2,opts_t)
      delete(opts_t)


    ; Plotting options for Td
      opts = res         
      opts@cnFillOn = True 
      opts@cnLinesOn = True
      opts@cnLineLabelsOn = True
      opts@ContourParameters = (/ -20., 90., 2./) 
      opts@cnLineLabelBackgroundColor = -1
      opts@gsnSpreadColorEnd = -3  ; End third from the last color in color map
      contour_td = wrf_contour(a,wks,td_f,opts)
      delete(opts)


    ; Plotting options for SLP                     
      opts = res
      opts@sfXArray = lon2d
      opts@sfYArray = lat2d         
      opts@cnLineColor = "black"
      opts@cnLowLabelsOn = True
      opts@cnHighLabelsOn = True
      opts@cnLowLabelFontColor = "red"
      opts@cnHighLabelFontColor = "blue"

      opts@cnHighLabelFontHeightF = 0.018

      opts@cnLowLabelFontHeightF = 0.018
      opts@ContourParameters = (/ 900., 1100., 2. /)
      opts@cnLineLabelsOn    = False
      ;opts@cnLineLabelBackgroundColor = -1
      opts@gsnContourLineThicknessesScale = 1.5
      contour_psl = wrf_contour(a,wks,slp,opts)
      delete(opts)

    ; Plotting Options for dBZ
      opts = res 
      opts@sfXArray = lon2d
      opts@sfYArray = lat2d        
      opts@cnFillOn = True 
      opts@cnLinesOn = False
      opts@cnLineLabelsOn = False
      ;opts@ContourParameters = (/ -20., 90., 2./) 
      ;opts@cnLineLabelBackgroundColor = -1
      opts@gsnSpreadColorEnd = -3  ; End third from the last color in color map
      contour_dbz = wrf_contour(a,wks,dbz(1,:,:),opts)
      delete(opts)

      opts = res 
      opts@sfXArray = lon2d
      opts@sfYArray = lat2d        
      opts@cnFillOn = True 
      opts@cnLinesOn = False
      opts@cnLineLabelsOn = False
      opts@ContourParameters = (/ 1., 90., 2./) 
      ;opts@cnLineLabelBackgroundColor = -1
      ;opts@gsnSpreadColorEnd = -3  ; End third from the last color in color map
      contour_rnfl = wrf_contour(a,wks,prpA,opts)
      delete(opts)

      opts = res 
      opts@sfXArray = lon2d
      opts@sfYArray = lat2d        
      opts@cnFillOn = True 
      opts@cnLinesOn = False
      opts@cnLineLabelsOn = False
      opts@ContourParameters = (/ 1., 90., 2./) 
      ;opts@cnLineLabelBackgroundColor = -1
      ;opts@gsnSpreadColorEnd = -3  ; End third from the last color in color map
      contour_snownc = wrf_contour(a,wks,snowT,opts)
      delete(opts)

;XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXx
;        NCL DOES NOT SUPPORT THE REQUIRED GRID CONVERSION FOR VECTORS ON LAT/LON GRID
    ; Plotting options for Wind Vectors                 
      ;opts = res
      ;opts@sfXArray = lon2d
      ;opts@sfYArray = lat2d         
      ;opts@FieldTitle = "Wind"       ; overwrite Field Title
      ;opts@NumVectors = 30           ; density of wind barbs
      ;vector = wrf_vector(a,wks,u10,v10,opts)
      ;delete(opts)

;XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX





;---Set special resource to indicate we are using XLAT/XLONG coordinates.
  ;pltres@LatLonOverlay = True

;---Zoom in on map, which we can do because we're using lat/lon coordinates.
;---       North America
  ;mpres@mpLeftCornerLatF  =  90.
  ;mpres@mpRightCornerLatF =   0.
  ;mpres@mpLeftCornerLonF  = 180.
  ;mpres@mpRightCornerLonF = -30.
;---       Contiguous US
  ;mpres@mpLeftCornerLatF  =   15.
  ;mpres@mpRightCornerLatF =   55.
  ;mpres@mpLeftCornerLonF  = -135.
  ;mpres@mpRightCornerLonF =  -60.
;---      Southeast/ NC
  ;mpres@mpLeftCornerLatF  =  30.
  ;mpres@mpRightCornerLatF =  40.
  ;mpres@mpLeftCornerLonF  = -90.
  ;mpres@mpRightCornerLonF = -70.

  mpres@mpGeophysicalLineColor = "gray25"
  ;mpres@mpOutlineBoundarySets = "AllBoundaries"
  ;mpres@mpUSStateLineColor = "Black"
  mpres@mpNationalLineColor = "Black"
  ;mpres@mpCountyLineColor = "grey50" 

  plot = wrf_map_overlays(a,wks,(/contour_psl /),pltres,mpres)
  plot = wrf_map_overlays(a,wks,(/contour_rnfl /),pltres,mpres)
  plot = wrf_map_overlays(a,wks,(/contour_tc /),pltres,mpres)
  ;plot = wrf_map_overlays(a,wks,(/contour_snownc /),pltres,mpres)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 end do        ; END OF TIME LOOP
 ; CONVERT TO ANIMATED GIF (OUTPUT AS PS)
 delete(wks)   ; Make sure PS file is closed
 ;cmd = "convert -rotate -0 -delay 75 animate.ps ../../../Dropbox/animate_1104USDBZ.gif"
 ;system(cmd)

;
; The WRF ARW input file.  
; This needs to have a ".nc" appended, so just do it.
a = addfile("wrfoutd03.nc","r")

lat2d = wrf_user_getvar(a,"XLAT",18)
lon2d = wrf_user_getvar(a,"XLONG",18) 

; We generate plots, but what kind do we prefer?
; type = "x11"
 type = "pdf"
; type = "ps"
; type = "ncgm"
 
  wks = gsn_open_wks(type,"surface3")

; Set some basic resources
  res = True
  res@MainTitle                   = "1/9° Pure WRF-ARW"

  pltres = True
  mpres = True


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; What times and how many time steps are in the data set?
  times = wrf_user_getvar(a,"times",-1)  ; get all times in the file
  ntimes = dimsizes(times)         ; number of times in the file

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  do it = 0,ntimes-1,6             ; TIME LOOP 6hrs

    print("Working on time: " + times(it) )
    res@TimeLabel = times(it)   ; Set Valid time to use on plots


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; First get the variables we will need    
    
    lat2d = wrf_user_getvar(a,"XLAT",it)
    lon2d = wrf_user_getvar(a,"XLONG",it)    
    
    dbz = wrf_user_getvar(a,"dbz",it)    ; Reflectivity [dBZ]
    slp = wrf_user_getvar(a,"slp",it)    ; slp
      wrf_smooth_2d( slp, 3 )            ; smooth slp
    prpA = wrf_user_getvar(a,"RAINNC",it)      ; Rainfall (mm)
    snowT = wrf_user_getvar(a,"SNOWNC",it)      ; Snowfall (mm)
    td = wrf_user_getvar(a,"td",it)      ; 3D td 
    u  = wrf_user_getvar(a,"ua",it)      ; 3D U at mass points
    v  = wrf_user_getvar(a,"va",it)      ; 3D V at mass points
    td2 =  wrf_user_getvar(a,"td2",it)   ; Td2 in C
    tc2 = wrf_user_getvar(a,"T2",it)     ; T2 in Kelvin
       tc2 = tc2-273.16                  ; T2 in C
    u10 = wrf_user_getvar(a,"U10",it)    ; u at 10 m, mass point
    v10 = wrf_user_getvar(a,"V10",it)    ; v at 10 m, mass point

;============================================================================
;                             ***CONVERSIONS***

    tf2 = 1.8*tc2+32.                    ; Turn temperature into Fahrenheit
      tf2@description = "Surface Temperature"
      tf2@units = "F"
    td_f = 1.8*td2+32.                   ; Turn temperature into Fahrenheit
      td_f@description = "Surface Dew Point Temp" 
      td_f@units = "F"
    u10 = u10*1.94386                    ; Turn wind into knots
    v10 = v10*1.94386
      u10@units = "kts"
      v10@units = "kts"

    snowT = snowT*0.0393701
      snowT@description = "Total Snowfall"
      snowT@units       = "in"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	 
      gsn_define_colormap(wks,"BlueYellowRed");
    ; Plotting options for T                
      opts_t = res
      opts_t@sfXArray = lon2d
      opts_t@sfYArray = lat2d                         
      opts_t@cnFillOn = True  
      opts_t@ContourParameters = (/ 0., 100., 2./)
      ;opts_t@gsnSpreadColors   = True
      ;opts_t@gsnSpreadColorEnd = -3  ; End third from the last color in color map
      contour_tc = wrf_contour(a,wks,tf2,opts_t)
      delete(opts_t)


    ; Plotting options for Td
      opts = res         
      opts@cnFillOn = True 
      opts@cnLinesOn = True
      opts@cnLineLabelsOn = True
      opts@ContourParameters = (/ -20., 90., 2./) 
      opts@cnLineLabelBackgroundColor = -1
      opts@gsnSpreadColorEnd = -3  ; End third from the last color in color map
      contour_td = wrf_contour(a,wks,td_f,opts)
      delete(opts)


    ; Plotting options for SLP                     
      opts = res
      opts@sfXArray = lon2d
      opts@sfYArray = lat2d         
      opts@cnLineColor = "black"
      opts@cnLowLabelsOn = True
      opts@cnHighLabelsOn = True
      opts@cnLowLabelFontColor = "red"
      opts@cnHighLabelFontColor = "blue"

      opts@cnHighLabelFontHeightF = 0.018

      opts@cnLowLabelFontHeightF = 0.018
      opts@ContourParameters = (/ 900., 1100., 2. /)
      opts@cnLineLabelsOn    = False
      ;opts@cnLineLabelBackgroundColor = -1
      opts@gsnContourLineThicknessesScale = 1.5
      contour_psl = wrf_contour(a,wks,slp,opts)
      delete(opts)

    ; Plotting Options for dBZ
      opts = res 
      opts@sfXArray = lon2d
      opts@sfYArray = lat2d        
      opts@cnFillOn = True 
      opts@cnLinesOn = False
      opts@cnLineLabelsOn = False
      ;opts@ContourParameters = (/ -20., 90., 2./) 
      ;opts@cnLineLabelBackgroundColor = -1
      opts@gsnSpreadColorEnd = -3  ; End third from the last color in color map
      contour_dbz = wrf_contour(a,wks,dbz(1,:,:),opts)
      delete(opts)

      opts = res 
      opts@sfXArray = lon2d
      opts@sfYArray = lat2d        
      opts@cnFillOn = True 
      opts@cnLinesOn = False
      opts@cnLineLabelsOn = False
      opts@ContourParameters = (/ 1., 90., 2./) 
      ;opts@cnLineLabelBackgroundColor = -1
      ;opts@gsnSpreadColorEnd = -3  ; End third from the last color in color map
      contour_rnfl = wrf_contour(a,wks,prpA,opts)
      delete(opts)

      opts = res 
      opts@sfXArray = lon2d
      opts@sfYArray = lat2d        
      opts@cnFillOn = True 
      opts@cnLinesOn = False
      opts@cnLineLabelsOn = False
      opts@ContourParameters = (/ 1., 90., 2./) 
      ;opts@cnLineLabelBackgroundColor = -1
      ;opts@gsnSpreadColorEnd = -3  ; End third from the last color in color map
      contour_snownc = wrf_contour(a,wks,snowT,opts)
      delete(opts)

;XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXx
;        NCL DOES NOT SUPPORT THE REQUIRED GRID CONVERSION FOR VECTORS ON LAT/LON GRID
    ; Plotting options for Wind Vectors                 
      ;opts = res
      ;opts@sfXArray = lon2d
      ;opts@sfYArray = lat2d         
      ;opts@FieldTitle = "Wind"       ; overwrite Field Title
      ;opts@NumVectors = 30           ; density of wind barbs
      ;vector = wrf_vector(a,wks,u10,v10,opts)
      ;delete(opts)

;XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX





;---Set special resource to indicate we are using XLAT/XLONG coordinates.
  ;pltres@LatLonOverlay = True

;---Zoom in on map, which we can do because we're using lat/lon coordinates.
;---       North America
  ;mpres@mpLeftCornerLatF  =  90.
  ;mpres@mpRightCornerLatF =   0.
  ;mpres@mpLeftCornerLonF  = 180.
  ;mpres@mpRightCornerLonF = -30.
;---       Contiguous US
  mpres@mpLeftCornerLatF  =   15.
  mpres@mpRightCornerLatF =   55.
  mpres@mpLeftCornerLonF  = -135.
  mpres@mpRightCornerLonF =  -60.
;---      Southeast/ NC
  ;mpres@mpLeftCornerLatF  =  30.
  ;mpres@mpRightCornerLatF =  40.
  ;mpres@mpLeftCornerLonF  = -90.
  ;mpres@mpRightCornerLonF = -70.

  mpres@mpGeophysicalLineColor = "gray25"
  ;mpres@mpOutlineBoundarySets = "AllBoundaries"
  ;mpres@mpUSStateLineColor = "Black"
  mpres@mpNationalLineColor = "Black"
  ;mpres@mpCountyLineColor = "grey50" 

  plot = wrf_map_overlays(a,wks,(/contour_psl /),pltres,mpres)
  plot = wrf_map_overlays(a,wks,(/contour_rnfl /),pltres,mpres)
  plot = wrf_map_overlays(a,wks,(/contour_tc /),pltres,mpres)
  ;plot = wrf_map_overlays(a,wks,(/contour_snownc /),pltres,mpres)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 end do        ; END OF TIME LOOP
 ; CONVERT TO ANIMATED GIF (OUTPUT AS PS)
 delete(wks)   ; Make sure PS file is closed
 ;cmd = "convert -rotate -0 -delay 75 animate.ps animate.gif"
 ;system(cmd)
end
