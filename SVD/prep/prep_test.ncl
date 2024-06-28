begin

;------------------------------------------------------------------------------------------
wksname = "test_rate"


lat1 = 10
lat2 = 70
lon1 = 90
lon2 = 150

        ff2 = addfile("/data/home/liyan/wangqy/topo/topo.nc","r")

topo = ff2->htopo({lat1:lat2},{lon1:lon2})
;topo&lat = lat
topo&lat@long_name = "Latitude"
topo&lat@units = "degrees_north"
;topo&lon = lon
topo&lon@long_name = "Longitude"
topo&lon@units = "degrees_east"
topo@long_name = "  "
topo@units = "  " 
printVarSummary(topo)
wrf_smooth_2d(topo,3)
; topo = smth9_Wrap(topo,0.25,-0.25,False)
; topo = runave(topo,1,0)
;-----------------------------------------------177-------------------------------------------

	    f1 = addfile("svd11.nc","r")

prep1 = f1->prep
printVarSummary(prep1)	

rain1 = prep1(:,{34.5:39},{112.5:115.5})                            
printVarSummary(rain1)
rain_s1 = dim_sum_n_Wrap(rain1,(/1,2/))
printVarSummary(rain_s1)
; print(rain_s1)

rain11 = where(rain1.ge.20,rain1,0)

f41 = dim_sum_n_Wrap(rain1,0)                 
printMinMax(f41,0)

f411 = dim_sum_n_Wrap(rain11,0)                
copy_VarCoords(f41,f411)

f4111 = dim_avg_n_Wrap(rain11,0)                               
copy_VarCoords(f41,f4111)

f41111 = dim_avg_n_Wrap(rain1,0)                                 
copy_VarCoords(f41,f41111)
;----------------------------------------------------

f41a=new((/46,31/),"double")
f41a=0                                            
do i=1,45
	do j=1,30
		if(f41(i,j).ne.0) then
			f41a(i,j)=(f411(i,j)/f41(i,j))*100
		end if 
	end do
end do

copy_VarCoords(f41,f41a)

;-----------------------
n1 = where(rain1(:,:,:).gt.0,1,0)
;print(fnum_2(0,:,:))
n11 = dim_sum_n_Wrap(n1,0)
printVarSummary(n1)
n11_t = tofloat(n11)
copy_VarCoords(rain1(0,:,:), n11_t(:,:))

rate1=new((/46,31/),"double")
rate1=0                                             
do i=1,45
	do j=1,30
		if(n11_t(i,j).ne.0) then
			rate1(i,j)=f41(i,j)/n11_t(i,j)
		end if 
	end do
end do
printVarSummary(rate1)
printMinMax(rate1,0)
copy_VarCoords(rain1(0,:,:),rate1)


;------------------------------------------------------------------------
f2 = addfile("svd22.nc","r")

prep2 = f2->prep
printVarSummary(prep2)	

rain2 = prep2(:,{34.5:39},{112.5:115.5})                           
printVarSummary(rain2)
rain_s2 = dim_sum_n_Wrap(rain2,(/1,2/))
printVarSummary(rain_s2)
; print(rain_s2)
rain22 = where(rain2.ge.20,rain2,0)

f42 = dim_sum_n_Wrap(rain2,0)
printMinMax(f42,0)

f422 = dim_sum_n_Wrap(rain22,0)
copy_VarCoords(f42,f422)

f4222 = dim_avg_n_Wrap(rain22,0)
copy_VarCoords(f42,f4222)

f42222 = dim_avg_n_Wrap(rain2,0)
copy_VarCoords(f42,f42222)
;--------------------------------------------------

f42a=new((/46,31/),"double")
f42a=0                                             
do i=1,45
	do j=1,30
		if(f42(i,j).ne.0) then
			f42a(i,j)=(f422(i,j)/f42(i,j))*100
		end if 
	end do
end do

copy_VarCoords(f42,f42a)


;--------------------------
n2 = where(rain2(:,:,:).gt.0,1,0)
n22 = dim_sum_n_Wrap(n2,0)
printVarSummary(n2)
n22_t = tofloat(n22)
copy_VarCoords(rain2(0,:,:), n22_t(:,:))

rate2=new((/46,31/),"double")
rate2=0                                              
do i=1,45
	do j=1,30
		if(n22_t(i,j).ne.0) then
			rate2(i,j)=f42(i,j)/n22_t(i,j)
		end if 
	end do
end do
printVarSummary(rate2)
printMinMax(rate2,0)
copy_VarCoords(rain2(0,:,:),rate2)

; ;--------------------------------------------
wrf_smooth_2d(f41,2)
f41=smth9_Wrap(f41,0.25,-0.1,False)
f41=runave(f41,2,1)

wrf_smooth_2d(f42,2)
f42=smth9_Wrap(f42,0.25,-0.1,False)
f42=runave(f42,2,1)

wrf_smooth_2d(f411,2)
f411=smth9_Wrap(f411,0.25,-0.1,False)
f411=runave(f411,1,1)

wrf_smooth_2d(f422,2)
f422=smth9_Wrap(f422,0.25,-0.1,False)
f422=runave(f422,2,1)


wrf_smooth_2d(f41a,3)
f41a=smth9_Wrap(f41a,0.25,-0.1,False)
f41a=runave(f41a,2,1)

wrf_smooth_2d(f42a,3)
f42a=smth9_Wrap(f42a,0.25,-0.1,False)
f42a=runave(f42a,1,1)

wrf_smooth_2d(rate1,2)                                    ;mrate
rate1=smth9_Wrap(rate1,0.25,-0.1,False)
rate1=runave(rate1,2,1)

wrf_smooth_2d(rate2,2)                                    ;mrate
rate2=smth9_Wrap(rate2,0.25,-0.1,False)
rate2=runave(rate2,2,1)


wrf_smooth_2d(f4111,2)
f4111=smth9_Wrap(f4111,0.25,-0.1,False)
f4111=runave(f4111,1,1)

wrf_smooth_2d(f4222,2)
f4222=smth9_Wrap(f4222,0.25,-0.1,False)
f4222=runave(f4222,2,1)

wrf_smooth_2d(f41111,2)
f41111=smth9_Wrap(f41111,0.25,-0.1,False)
f41111=runave(f41111,1,1)

wrf_smooth_2d(f42222,2)
f42222=smth9_Wrap(f42222,0.25,-0.1,False)
f42222=runave(f42222,2,1)
; wrf_smooth_2d(fa,2)                                    ;mrate
; fa=smth9_Wrap(fa,0.25,-0.1,False)
; fa=runave(fa,2,1)
;------------------------------------------------------------------------------------

;------------------------------------------------------------------
wks_type = "pdf"
wks=gsn_open_wks(wks_type,wksname)
plot=new(2,graphic)

res                                 = True          ; plot mods desired
res@gsnDraw			                  = False
res@gsnFrame			               = False
res@gsnPaperOrientation	         	= "Portrait"
res@cnLinesOn                       = False
res@cnFillOn                        = True          ; turn on color
res@vpWidthF                        = 0.5           ; change aspect ratio of plot
res@vpHeightF                       = 0.3
res@gsnMaximize                     = True          ; maximize plot size
res@trLineInterpolationOn		      = True
res@tmXBTickSpacingF			         = 1              ;          
res@tmYLTickSpacingF			         = 1
res@tmXBMinorOn                     = True
res@tmXTOn				            	= True
res@tmYROn					            = True
res@tmXBLabelFontHeightF			   = 0.015                
res@tmYLLabelFontHeightF		      = 0.015
res@mpMaxLatF					         = 38.5   ;40                          ;35-38.5,113-115
res@mpMinLatF					         = 35 
res@mpMaxLonF					         = 115
res@mpMinLonF					         = 113      
res@tmXBLabelDeltaF   = -0.5
res@tmYLLabelDeltaF   = -0.5
res@tmXTLabelDaltaF   = -0.5
res@tmYRLabelDeltaF   = -0.5                      
res@tmXBMode                        = "Explicit"
res@tmXBValues                      = (/113,114,115/)
res@tmXBLabels                      = (/"113E","114E","115E"/)
res@tmYLMode                        = "Explicit"
res@tmYLValues                      = (/35,36,37,38/)
res@tmYLLabels                      = (/"35N","36N","37N","38N"/)

res@gsnAddCyclic 				         = False 

res@lbOrientation				         = "vertical"     
res@lbLabelFontHeightF				   = 0.015                           
res@lbLabelStride				         = 2                   
res@pmLabelBarOrthogonalPosF			= 0.20                
res@pmLabelBarParallelPosF          = 0.5
;res@lbLabelBarOn                    = False

res@mpDataSetName              = "/data/home/liyan/wangqy/ccr/SVD/177/circulation/NCL-Chinamap/database/Earth..4"
res@mpDataBaseVersion          = "MediumRes" ; or "Ncarg4_1"
res@mpAreaMaskingOn            = True
res@mpMaskAreaSpecifiers       = (/"China"/)
res@mpOutlineSpecifiers        = (/"China","China:Provinces"/)
res@mpNationalLineColor        = "gray27"
res@mpCountyLineColor          = "gray27"
res@mpGeophysicalLineColor     = "gray27"
res@mpProvincialLineColor      = "gray27"

gsn_define_colormap(wks,"BlueDarkRed18")                  ;BlueDarkRed18          WhiteBlueGreenYellowRed                          
res@cnLevelSelectionMode 			   = "ExplicitLevels"
res@cnSmoothingOn				         = True
res@cnSmoothingDistanceF            = 0.01          
res@cnSmoothingTensionF		         = 2.5
res@cnFillColors                 = (/0,12,13,14,15,16,17,18/)
res@cnLineLabelsOn               = False
res@cnLineLabelFormat               = "00@;*.2f"                       ;小数位数


res@cnLevels					          = (/5,7,9,11,13,15,18/)     ;rate
res@lbLabelStrings                = (/5,7,9,11,13,15,17/)



res@lbLabelBarOn                    = False
res@gsnLeftString				       = " (a) Type1 num=27"  
; res@gsnRightString				       = "(28.88%)"    
res@gsnRightString				      = " "
res@gsnLeftStringOrthogonalPosF     = 0.02
res@gsnRightStringOrthogonalPosF    = 0.02
res@gsnLeftStringFontHeightF        = 0.0135
res@gsnRightStringFontHeightF       = 0.0125

plot(0)=gsn_csm_contour_map(wks,rate1,res)  

res@lbLabelBarOn                    = True
res@gsnLeftString				       = " (b) Type2 num=25"   
; res@gsnRightString				       = "(20.34%)" 


plot(1)=gsn_csm_contour_map(wks,rate2,res)       ;

  ;-----------------------------overlay--------------------------

  cres                                    = True
  cres@gsnDraw                            = False
  cres@gsnFrame                           = False
  cres@cnLinesOn                          = True
  cres@cnLineColor						  = "gray33"
  cres@cnLineLabelFontHeightF             = 0.032          ;area
  cres@cnLineLabelDensityF                = 1
  cres@cnLineLabelsOn                     = True
  cres@cnInfoLabelOn                      = False
  cres@lbLabelBarOn                       = False
  cres@cnLabelMasking                     = True
  cres@cnLineLabelBackgroundColor         = -1
  cres@cnLineLabelFontColor               = "gray33"
  cres@cnLevelSelectionMode               = "ExplicitLevels"
  cres@gsnAddCyclic                       = False
  cres@cnFillOn                           = False
  cres@cnSmoothingOn					       = True            
  cres@cnSmoothingDistanceF      		    = 0.001
  cres@cnSmoothingTensionF				    = -0.25
  cres@cnLevels					             = (/200,400,600,800,1000,1200,1400/)
  cres@cnMonoLineThickness                = False
  cres@cnLineThicknesses                  = (/7, 1, 1, 1, 1, 1, 1/)
   
   
   plotlay0 = gsn_csm_contour(wks,topo,cres)
   plotlay1 = gsn_csm_contour(wks,topo,cres)

   overlay(plot(0),plotlay0) 
   overlay(plot(1),plotlay1)

;-------------
  ;  draw(plot)
   resP    = True
   resP@gsnPanelRowSpec = True              ; tell panel what order to plt
   resP@gsnMaximize = True
   gsn_panel(wks,plot,(/2,1/),resP)




end




