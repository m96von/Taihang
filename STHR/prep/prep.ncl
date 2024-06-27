begin

;------------------------------------------------------------------------------------------
wksname = "prep"

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

nlat = 101
nlon = 121
ntime = 1115
dims = (/1115,101,121/)

	    f = addfile("/data/home/liyan/wangqy/ccr/data/prep/rain1115.nc","r")

;printVarSummary(f)	

lat = fspan(34,44,101)
lon = fspan(109,121,121 )
time = fspan(1,1115,1115)

f1 = f->prep
;printVarSummary(f1)
f2 = where(ismissing(f1),0,f1)
printVarSummary(f2)
f2!0 = "time"
f2!1 = "lat"
f2!2 = "lon"
f2&time = time
f2&lat = lat
f2&lat@long_name = "Latitude"
f2&lat@units = "degrees_north"
f2&lon = lon
f2&lon@long_name = "Longitude"
f2&lon@units = "degrees_east"
f2@long_name = "prep"
f2@units = "mm" 
f2@_FillValue = 9999
;printVarSummary(f2)

; test = dim_sum_n_Wrap(f2(:,{35:38.5},{113:115}),0)
; printMinMax(test,0)

;-------------------------------------------------------
rain = f2(:,{34.5:39},{112.5:115.5})                                ;研究区域
printVarSummary(rain)
rain_s = dim_sum_n_Wrap(rain,(/1,2/))
printVarSummary(rain_s)
; print(rain_s)

;-----------------------------------------------
f4 = dim_sum_n_Wrap(rain,0)
printMinMax(f4,0)

p_lat = dim_avg_n_Wrap(f4({35:38.5},{113:115}),0)
p_lon = dim_avg_n_Wrap(f4({35:38.5},{113:115}),1)
print(p_lon)
print(p_lat)
delete([/f,f2,f1/])
;---------------------------------
numm = where(rain(:,:,:).gt.0,1,0)
;print(fnum_2(0,:,:))
rnum = dim_sum_n_Wrap(numm,0)
printVarSummary(rnum)
num_t = tofloat(rnum)
copy_VarCoords(rain(0,:,:), num_t(:,:))
printVarSummary(num_t)
printMinMax(num_t,0)

n_lat = dim_avg_n_Wrap(num_t({35:38.5},{113:115}),0)
n_lon = dim_avg_n_Wrap(num_t({35:38.5},{113:115}),1)
print(n_lon)
print(n_lat)
;---------------------------------------------------
rate=new((/46,31/),"double")
rate=0                                              ;雨强=降水量/频次
do i=1,45
	do j=1,30
		if(num_t(i,j).ne.0) then
			rate(i,j)=f4(i,j)/num_t(i,j)
		end if 
	end do
end do
printVarSummary(rate)
printMinMax(rate,0)
copy_VarCoords(rain(0,:,:),rate)

r_lat = dim_avg_n_Wrap(rate({35:38.5},{113:115}),0)
r_lon = dim_avg_n_Wrap(rate({35:38.5},{113:115}),1)
; printVarSummary(r_lon)
print(r_lon)
print(r_lat)
;----------------------贡献----------------------------


	    f = addfile("/data/home/liyan/wangqy/ccr/data/prep/rain1115_all.nc","r")


f1 = f->prep
;printVarSummary(f1)
f2 = where(ismissing(f1),0,f1)
printVarSummary(f2)
f2!0 = "time"
f2!1 = "lat"
f2!2 = "lon"
f2&time = time
f2&lat = lat
f2&lat@long_name = "Latitude"
f2&lat@units = "degrees_north"
f2&lon = lon
f2&lon@long_name = "Longitude"
f2&lon@units = "degrees_east"
f2@long_name = "prep"
f2@units = "mm" 
f2@_FillValue = 9999


raina = f2(:,{34.5:39},{112.5:115.5})                                ;研究区域
printVarSummary(raina)
f4a = dim_sum_n_Wrap(raina,0)

numma = where(raina(:,:,:).gt.0,1,0)
;print(fnum_2(0,:,:))
rnuma = dim_sum_n_Wrap(numma,0)
printVarSummary(rnuma)
num_ta = tofloat(rnuma)
copy_VarCoords(raina(0,:,:), num_ta(:,:))
printVarSummary(num_ta)
printMinMax(num_ta,0)

;---------------------------------------------------
ratea=new((/46,31/),"double")
ratea=0                                              ;雨强=降水量/频次
do i=1,45
	do j=1,30
		if(num_ta(i,j).ne.0) then
			ratea(i,j)=f4a(i,j)/num_ta(i,j)
		end if 
	end do
end do
printVarSummary(ratea)
printMinMax(ratea,0)
copy_VarCoords(raina(0,:,:),ratea)


fa=new((/46,31/),"double")
fa=0                                              ;贡献=短时强降水/总降水
do i=1,45
	do j=1,30
		if(f4(i,j).ne.0) then
			fa(i,j)=f4(i,j)/f4a(i,j)
		end if 
	end do
end do
printMinMax(fa,0)
copy_VarCoords(rain(0,:,:),fa)
fa = fa * 100
printVarSummary(fa)
;--------------------------------------------
wrf_smooth_2d(f4,2)
f4=smth9_Wrap(f4,0.25,-0.1,False)
f4=runave(f4,2,1)

wrf_smooth_2d(num_t,2)
num_t=smth9_Wrap(num_t,0.25,-0.1,False)
num_t=runave(num_t,2,1)

wrf_smooth_2d(rate,2)                                    ;mrate
rate=smth9_Wrap(rate,0.25,-0.1,False)
rate=runave(rate,2,1)

wrf_smooth_2d(fa,2)                                    ;mrate
fa=smth9_Wrap(fa,0.25,-0.1,False)
fa=runave(fa,2,1)

wrf_smooth_2d(f4a,2)
f4a=smth9_Wrap(f4a,0.20,-0.1,False)
f4a=runave(f4a,1,1)

wrf_smooth_2d(ratea,2)                                    ;mrate
ratea=smth9_Wrap(ratea,0.25,-0.1,False)
ratea=runave(ratea,2,1)

;------------------------------------------------------------------------------------
wks_type = "pdf"
;wks_type@wkWidth = 2500
;wks_type@wkHeight = 2500 
wks=gsn_open_wks(wks_type,wksname)
plot = new(1,graphic)

res                                 = True          ; plot mods desired
res@gsnDraw			                  = False
res@gsnFrame			               = False
res@gsnPaperOrientation	         	= "Portrait"
res@cnLinesOn                       = False
res@cnFillOn                        = True          ; turn on color
;res@cnFillPalette                   = "gui_default" ; set color map
res@vpWidthF                        = 0.5           ; change aspect ratio of plot
res@vpHeightF                       = 0.3
res@gsnMaximize                     = True          ; maximize plot size
res@trLineInterpolationOn		      = True
res@tmXBTickSpacingF			         = 1              ;坐标间隔           
res@tmYLTickSpacingF			         = 1
res@tmXBMinorOn                     = True

res@tmXTOn				            	= True
res@tmYROn					            = True
res@tmXBLabelFontHeightF			   = 0.015                  ;
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

res@lbOrientation				         = "vertical"        ;色标/horizontal/vertical
res@lbLabelFontHeightF				   = 0.015                              ;色标字号
res@lbLabelStride				         = 2                       ;标记的间隔
res@pmLabelBarOrthogonalPosF			= 0.1                          ;色标位置
;res@pmLabelBarOrthogonalPosF			= 0.07                          ;色标位置  ;ratea
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



gsn_define_colormap(wks,"BlueDarkRed18")                  ;BlueDarkRed18                                
res@cnLevelSelectionMode 			   = "ExplicitLevels"
res@cnSmoothingOn				         = True
res@cnSmoothingDistanceF            = 0.03            ;
res@cnSmoothingTensionF		         = 0.25

res@cnFillColors                     = (/0,12,13,14,15,16,17,18/)

res@cnLevels					          = (/200,250,300,350,400,450,500/)     ;prep
res@lbLabelStrings                   = (/200,250,300,350,400,450,500/)

res@cnLineLabelFormat               = "00@;*.2f"                       ;小数位数 
res@gsnLeftString				         = " (b)  "        ;precipitation frequency intensity
res@gsnRightString				      = " "
res@gsnLeftStringOrthogonalPosF     = 0.02
res@gsnRightStringOrthogonalPosF    = 0.03
res@gsnLeftStringFontHeightF            = 0.015

f4_annual = f4 / 11        ;11 years
copy_VarCoords(f4,f4_annual)


plot(0)=gsn_csm_contour_map(wks,f4,res)       ;f4-FHR   f4a-all  num_t rate

  ;-----------------------------overlay--------------------------pi


  cres                                    = True
  cres@gsnDraw                            = False
  cres@gsnFrame                           = False
  cres@cnLinesOn                          = True
  cres@cnLineColor						  = "dim grey"
  cres@cnLineLabelFontHeightF             = 0.032          ;area
  cres@cnLineLabelDensityF                = 0.4
  cres@cnLineLabelsOn                     = True
  cres@cnInfoLabelOn                      = False
  cres@lbLabelBarOn                       = False
  cres@cnLabelMasking                     = True
  cres@cnLineLabelBackgroundColor         = -1
  cres@cnLineLabelFontColor               = "dim grey"
  cres@cnLevelSelectionMode               = "ExplicitLevels"
  cres@gsnAddCyclic                       = False
  cres@cnFillOn                           = False
  cres@cnSmoothingOn					       = True            
  cres@cnSmoothingDistanceF      		    = 0.001
  cres@cnSmoothingTensionF				    = -0.25
  cres@cnLevels					             = (/200,400,600,800,1000,1200,1400/)
  cres@cnMonoLineThickness                = False
  cres@cnLineThicknesses                  = (/7, 1, 1, 1, 1, 1, 1/)
   
   plotlay = gsn_csm_contour(wks,topo,cres)
   overlay(plot(0),plotlay) 
;-------------

   draw(plot(0))
   delete(plotlay)
   frame(wks)



end