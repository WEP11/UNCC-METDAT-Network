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
  a = addfile("wrfoutd03.nc","r")

    lat2d = wrf_user_getvar(a,"XLAT",18)
    lon2d = wrf_user_getvar(a,"XLONG",18) 

;####################################################################################################################################

;                                                 RADAR PLOT

; We generate plots, but what kind do we prefer?
; type = "x11"
; type = "pdf"
 type = "ps"
; type = "ncgm"
  wks = gsn_open_wks(type,"radar")
  
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
;---      Southeast/ NC
  ;mpres@mpLeftCornerLatF  =  30.
  ;mpres@mpRightCornerLatF =  40.
  ;mpres@mpLeftCornerLonF  = -90.
  ;mpres@mpRightCornerLonF = -70.
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
	opts@ContourParameters = (/ -25 , 50, 5 /)
	contour_dbz = wrf_contour(a,wks,dbz,opts)
	delete(opts)

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

	plot = wrf_map_overlays(a,wks,(/contour_dbz,contour_psl/),pltres,mpres)
	end if
	
	FirstTime=False
  end do
delete(wks)

end
