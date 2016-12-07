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

    lat2d = wrf_user_getvar(a,"XLAT",18)
    lon2d = wrf_user_getvar(a,"XLONG",18) 

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

end
