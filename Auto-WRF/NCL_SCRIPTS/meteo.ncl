
;15-Jul-2014
;Here we plot a 2D Vert/Timeseries and Several lineplots


;***********************************************
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
;load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "/home/wxdisplay/Models/DOMAINS/NCL_SCRIPTS/Modified_Libs/WRFUserARW.ncl"
;***********************************************
begin
;***********************************************

a = addfile("wrfoutd03.nc","r")

;-----------------------------------------------------------------------

; Convert from lat/long to i/j (user interface?)

  lat = 35.3073
  lon = -80.7301
  llres = True
  llres@ReturnInt = True   ; Return integer values
  locij = wrf_user_ll_to_ij(a, lon, lat, llres)
  locij = locij - 1        ; swap to a fortran style reference (dont ask)
  locX = locij(0)
  locY = locij(1)

; get time information and strip out the day and hour
  times_in_file = a->Times
  dims = dimsizes(times_in_file)
  taus = ispan(1,dims(0),1)       ; integer
  taus_mark = ispan(1,dims(0),24) ; integer
  times = new(dims(0),string)

; here we grab labels... This can be tricky, so the print statement might be useful

  j=0                                      ; since the loop index goes by 24 to grab the right times, we use j to allocate the array.
  do i=0,dims(0)-1,24                      ; Times come out twice, so 24 is necessary. The loop index is only factor in picking time labels
    times(j) = chartostring(times_in_file(i,8:12))   ; starting at digit 8 ending at digit 12. Full format is: yyyy-dd-mm_hh:mm:ss
    ;print(times(j)) ; my debug line
    j=j+1
  end do

; open workstation and get plotting

  wks = gsn_open_wks("pdf","meteo")    ; open a workstation
  gsn_define_colormap(wks,"testcmap")      ; choose colormap

;-----------------------------------------------------------------------
;Grab Variables

  t2         = wrf_user_getvar(a,"T2",-1)    ; get t2 for all times
  snow       = wrf_user_getvar(a,"SNOWNC",-1)   ; get slp for all times
  tc         = wrf_user_getvar(a,"tc",-1)    ; get tc for all times
  uvmet      = wrf_user_getvar(a,"uvmet",-1) ; get rotated u and v comp of wind
  rainnc     = wrf_user_getvar(a,"RAINNC",-1)   ; get slp for all times
  rainc      = wrf_user_getvar(a,"RAINC",-1)
  rainsh     = wrf_user_getvar(a,"RAINSH",-1)
  ;qsnow      = wrf_user_getvar(a,"QSNOW",-1)
  rain_total = rainnc+rainc+rainsh

;-----------------------------------------------------------------------
;Conversions

  raintot = rain_total*0.0393701
  	raintot@description = "Total Precipitation (in)"
  	raintot@units = "in"

  

  ;tc = tc-273.16
  tc = 1.8*tc+32.                    ; Turn temperature into Fahrenheit
  	tc@description = "Temperature"
	tc@units = "F"
  t2 = t2-273.16
  t2 = 1.8*t2+32.                    ; Turn temperature into Fahrenheit
  	t2@description = "Surface Temperature"
	t2@units = "F"
  ;snow = snow*0.0393701
  ;snow = snow*39.3701
	;snow = snow*qsnow
        ;snow = snow*12
	;snow@description = "Total Snow (in)"
	;snow@units = "in"

  umet = uvmet(0,:,:,:,:)
  vmet = uvmet(1,:,:,:,:)

;-----------------------------------------------------------------------
;Extract point time-series

  t2_point  = t2(:,locY,locX)           ; extract a time series at a point
  ;snow_point = snow(:,locY,locX)
  tc_point  = tc(:,:,locY,locX)
  rn_point  = raintot(:,locY,locX)               ; extract a time series at a point
  ;sr_point  = qsnow(:,:,locY,locX)
  u_point   = umet(:,:,locY,locX)
  v_point   = vmet(:,:,locY,locX)

; Swap the dimensions as we want to plot time on the X axis later
  tt        = tc_point(bottom_top|:,Time|:)
  ugrid     = u_point(bottom_top|:,Time|:)
  vgrid     = v_point(bottom_top|:,Time|:)

;-----------------------------------------------------------------------
;Set plot resources

  res2D = True                            ; Set basic resources 
  res2D@gsnDraw              = False      ; Don't draw individual plot.
  res2D@gsnFrame             = False      ; Don't advance frame.
  res2D@vpXF                 = 0.15       ; x location
  res2D@vpYF                 = 0.90       ; y location
  res2D@vpWidthF             = 0.70       ; width
  res2D@vpHeightF            = 0.40       ; height
  ;res2D@tiXAxisString        = "Day_Time"
  res2D@tmLabelAutoStride    = True
  res2D@tiXAxisFontHeightF   = 0.016
  res2D@tmXBMode             = "Explicit"
  res2D@tmXBValues           = taus_mark
  ;res2D@tmXBMinorValues      = taus
  res2D@tmXBLabels           = times
  res2D@tmXBLabelJust        = "CenterCenter"
  res2D@tmXBLabelFontHeightF = .012
  res2D@tmXBLabelStride      = 1


  tt_res = res2D
  tt_res@sfXArray                 = taus
  tt_res@gsnSpreadColors          = True             ; use full range of colors
  tt_res@cnFillOn                 = True             ; turns on color fill
  tt_res@cnLevelSelectionMode     = "ManualLevels"   ; set levels manually
  tt_res@cnMinLevelValF           = -20.
  tt_res@cnMaxLevelValF           = 100.
  tt_res@cnLevelSpacingF          = 2
  ;tt_res@cnLevels             = (/ 60, 58, 56, 54, 52, 50, 48, 46, 44, 42, 40, 38, 36, 34, 32, \
;				   30, 28, 26, 24, 22, 20, 18, 16, 14, 12, 10, 8, 6, 4, 2, 0, -2, -4/)
  ;tt_res@cnFillColors         = (/"yellow","yellow2","yellow4","darkorange","darkorange2","darkorange4", \       ;50s
;				  "chartreuse4","chartreuse2","chartreuse","darkseagreen2","darkseagreen4", \    ;40s
;				  "cyan","cyan2","cyan4","darkviolet","deepskyblue", \                           ;30s
;				  "deepskyblue2","deepskyblue4","firebrick2","firebrick4","mediumpurple1", \     ;20s
;				  "mediumpurple2","mediumpurple3","navajowhite","navajowhite2","navajowhite4", \ ;10s
;				  "springgreen4","springgreen2","springgreen","steelblue4","steelblue2","steelblue","white"/)
  tt_res@cnLinesOn                = False
  tt_res@cnLineLabelsOn           = True
  tt_res@cnLineLabelInterval      = 6
  tt_res@cnInfoLabelOn            = False
  tt_res@pmLabelBarDisplayMode    = "Always"         ; Add a label bar
  tt_res@pmLabelBarSide           = "Right"
  tt_res@pmLabelBarOrthogonalPosF = -0.10
  tt_res@pmLabelBarParallelPosF   = 0
  tt_res@lbAutoManage             = False
  tt_res@lbLabelAutoStride        = True
  tt_res@lbOrientation            = "Vertical"
  tt_res@lbPerimOn                = False
  tt_res@lbJustification          = "BottomLeft"
  tt_res@lbBoxMinorExtentF        = 0.13
  tt_res@lbLabelFontHeightF       = 0.012
  tt_res@lbBoxLinesOn             = False
  tt_res@tiMainFont               = 22
  tt_res@tiMainString             = "WRF-ARW " + lat + "N, " + lon + "W ~Z50~ UNC Charlotte"


  uv_res = res2D
  uv_res@vfXArray         = taus
  uv_res@vfXCStride       = 12
  uv_res@vfYCStride       = 5
  uv_res@vcRefAnnoOn      = False         ; turns off the ref vector
  uv_res@vcRefLengthF     = 0.040         ; set length of ref vector
  uv_res@vcGlyphStyle     = "WindBarb"    ; turn on wind barbs


;-----------------------------------------------------------------------

  res1D = True                            ; Set basic resources both will use
  res1D@vpXF              = 0.15          ; The left side of the box location
  res1D@vpWidthF          = 0.70          ; The Width of the plot box
  res1D@vpHeightF         = 0.10          ; The height of the plot box
  res1D@tmLabelAutoStride    = True
  res1D@tmXBMode          = "Explicit"    ; Define own tick mark labels.
  res1D@tmXBValues           = taus_mark
  ;res1D@tmXBMinorValues      = taus
  res1D@tmXBLabels        = times         ; labels are the locations
  res1D@tmXBLabelStride   = 1
  res1D@tmXTOn            = False         ; turn off the top tick marks
  res1D@xyLineThicknesses = 2             ; increase line thickness
  res1D@gsnDraw           = False         ; Don't draw individual plot.
  res1D@gsnFrame          = False         ; Don't advance frame.
  

  ;slp_res = res1D
  ;slp_res@vpYF            = 0.45          ; The top side of the plot box loc
  ;slp_res@xyLineColor     = "blue"         ; set line color
  ;slp_res@tiYAxisString   = "Snowfall (in)"        ; set y-axis string


  t2_res = res1D
  t2_res@vpYF             = 0.30          ; The top side of the plot box loc
  t2_res@xyLineColor      = "red"        ; set line color
  t2_res@tiYAxisString    = "Sfc Temp"
  t2_res@gsnYRefLine      = 32.0             ; create a reference line
  t2_res@gsnYRefLineColor = "lightsteelblue3"
  t2_res@gsnYRefLineDashPattern = 2

  rn_res = res1D
  rn_res@vpYF             = 0.15          ; The top side of the plot box loc
  rn_res@xyLineColor      = "green"        ; set line color
  rn_res@tiYAxisString    = "Precip (in)"
  
  sr_res = res1D
  sr_res@vpYF             = 0.75          ; The top side of the plot box loc
  sr_res@xyLineColor      = "black"        ; set line color
  sr_res@tiYAxisString    = "Snow MixRa (g/kg)"
  

;-----------------------------------------------------------------------
; plot

  ttfill    = gsn_contour(wks,tt,tt_res)
  windlayer = gsn_vector(wks,ugrid,vgrid,uv_res)
  overlay(ttfill,windlayer)

  ;slp_plot  = gsn_csm_xy(wks,taus,snow_point,slp_res)
  t2_plot  = gsn_csm_xy(wks,taus,t2_point,t2_res)
  rn_plot  = gsn_csm_xy(wks,taus,rn_point,rn_res)
  ;sr_plot  = gsn_csm_xy(wks,taus,sr_point,sr_res)

  draw(ttfill) 
  ;draw(slp_plot) 
  draw(t2_plot) 
  

  ;frame(wks)                            ; frame between drawings to put something on another page

  draw(rn_plot)
  ;draw(sr_plot)
  frame(wks)  

;-----------------------------------------------------------------------

end

