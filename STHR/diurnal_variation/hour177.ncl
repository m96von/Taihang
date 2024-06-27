begin

;------------------------------------------------------------------------------------------


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

	    f = addfile("/data/home/liyan/wangqy/ccr/data/prep/rain1115_all.nc","r")

;printVarSummary(f)	

lat = fspan(34,44,101)
lon = fspan(109,121,121 )
time = fspan(0,1114,1115)

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
delete(f)
;--------------------------------------------------------
ff = f2
; ff = where(f2.ge.20,f2,0)


;--------------------------------------------------
t1 = asciiread("t1.txt/",-1, "integer")
; printVarSummary(t1)
times = 1115

var1 = new((/dimsizes(t1),101,121/),"float")             
          
do x=0,1114
	do j=0,dimsizes(t1)-1
		if(t1(j).eq.x) then
			var1(j,:,:)=ff(x,:,:)
		end if
	end do
end do
; printVarSummary(var1)
; printMinMax(var1(17,:,:),0)
hour1=dim_sum_n_Wrap(var1(:,:,:),0)
; printVarSummary(hour1)

;
t2 = asciiread("t2.txt/",-1, "integer")
; printVarSummary(t2)

var2 = new((/dimsizes(t2),101,121/),"float")             
          
do x=0,1114
	do j=0,dimsizes(t2)-1
		if(t2(j).eq.x) then
			var2(j,:,:)=ff(x,:,:)
		end if
	end do
end do
; printVarSummary(var2)
; printMinMax(var1(17,:,:),0)
hour2=dim_sum_n_Wrap(var2(:,:,:),0)
; printVarSummary(hour2)

;
t3 = asciiread("t3.txt/",-1, "integer")
; printVarSummary(t3)

var3 = new((/dimsizes(t3),101,121/),"float")             
          
do x=0,1114
	do j=0,dimsizes(t3)-1
		if(t3(j).eq.x) then
			var3(j,:,:)=ff(x,:,:)
		end if
	end do
end do
; printVarSummary(var3)
; printMinMax(var1(17,:,:),0)
hour3=dim_sum_n_Wrap(var3(:,:,:),0)
; printVarSummary(hour3)

;
t4 = asciiread("t4.txt/",-1, "integer")
; printVarSummary(t4)

var4 = new((/dimsizes(t4),101,121/),"float")             
          
do x=0,1114
	do j=0,dimsizes(t4)-1
		if(t4(j).eq.x) then
			var4(j,:,:)=ff(x,:,:)
		end if
	end do
end do
; printVarSummary(var4)
; printMinMax(var1(17,:,:),0)
hour4=dim_sum_n_Wrap(var4(:,:,:),0)
; printVarSummary(hour4)

;
t5 = asciiread("t5.txt/",-1, "integer")
; printVarSummary(t5)

var5 = new((/dimsizes(t5),101,121/),"float")             
          
do x=0,1114
	do j=0,dimsizes(t5)-1
		if(t5(j).eq.x) then
			var5(j,:,:)=ff(x,:,:)
		end if
	end do
end do
; printVarSummary(var5)
; printMinMax(var1(17,:,:),0)
hour5=dim_sum_n_Wrap(var5(:,:,:),0)
; printVarSummary(hour5)

;
t6 = asciiread("t6.txt/",-1, "integer")
; printVarSummary(t6)

var6 = new((/dimsizes(t6),101,121/),"float")             
          
do x=0,1114
	do j=0,dimsizes(t6)-1
		if(t6(j).eq.x) then
			var6(j,:,:)=ff(x,:,:)
		end if
	end do
end do
; printVarSummary(var6)
printMinMax(var6(0,:,:),0)
hour6=dim_sum_n_Wrap(var6(:,:,:),0)
; printVarSummary(hour6)

;
t7 = asciiread("t7.txt/",-1, "integer")

var7 = new((/dimsizes(t7),101,121/),"float")             
          
do x=0,1114
	do j=0,dimsizes(t7)-1
		if(t7(j).eq.x) then
			var7(j,:,:)=ff(x,:,:)
		end if
	end do
end do
hour7=dim_sum_n_Wrap(var7(:,:,:),0)

;
t8 = asciiread("t8.txt/",-1, "integer")

var8 = new((/dimsizes(t8),101,121/),"float")             
          
do x=0,1114
	do j=0,dimsizes(t8)-1
		if(t8(j).eq.x) then
			var8(j,:,:)=ff(x,:,:)
		end if
	end do
end do

hour8=dim_sum_n_Wrap(var8(:,:,:),0)

;
t9 = asciiread("t9.txt/",-1, "integer")

var9 = new((/dimsizes(t9),101,121/),"float")             
          
do x=0,1114
	do j=0,dimsizes(t9)-1
		if(t9(j).eq.x) then
			var9(j,:,:)=ff(x,:,:)
		end if
	end do
end do
hour9=dim_sum_n_Wrap(var9(:,:,:),0)
; printVarSummary(hour5)

;
t10 = asciiread("t10.txt/",-1, "integer")

var10 = new((/dimsizes(t10),101,121/),"float")             
          
do x=0,1114
	do j=0,dimsizes(t10)-1
		if(t10(j).eq.x) then
			var10(j,:,:)=ff(x,:,:)
		end if
	end do
end do
hour10=dim_sum_n_Wrap(var10(:,:,:),0)

;
t11 = asciiread("t11.txt/",-1, "integer")

var11 = new((/dimsizes(t11),101,121/),"float")             
          
do x=0,1114
	do j=0,dimsizes(t11)-1
		if(t11(j).eq.x) then
			var11(j,:,:)=ff(x,:,:)
		end if
	end do
end do

hour11=dim_sum_n_Wrap(var11(:,:,:),0)

;
t12 = asciiread("t12.txt/",-1, "integer")

var12 = new((/dimsizes(t12),101,121/),"float")             
          
do x=0,1114
	do j=0,dimsizes(t12)-1
		if(t12(j).eq.x) then
			var12(j,:,:)=ff(x,:,:)
		end if
	end do
end do
hour12=dim_sum_n_Wrap(var12(:,:,:),0)
; printVarSummary(hour5)

;
t13 = asciiread("t13.txt/",-1, "integer")
var13 = new((/dimsizes(t13),101,121/),"float")             
          
do x=0,1114
	do j=0,dimsizes(t13)-1
		if(t13(j).eq.x) then
			var13(j,:,:)=ff(x,:,:)
		end if
	end do
end do
hour13=dim_sum_n_Wrap(var13(:,:,:),0)
; printVarSummary(hour5)

;
t14 = asciiread("t14.txt/",-1, "integer")

var14 = new((/dimsizes(t14),101,121/),"float")             
          
do x=0,1114
	do j=0,dimsizes(t14)-1
		if(t14(j).eq.x) then
			var14(j,:,:)=ff(x,:,:)
		end if
	end do
end do
hour14=dim_sum_n_Wrap(var14(:,:,:),0)
; printVarSummary(hour5)

;
t15 = asciiread("t15.txt/",-1, "integer")


var15 = new((/dimsizes(t15),101,121/),"float")             
          
do x=0,1114
	do j=0,dimsizes(t15)-1
		if(t15(j).eq.x) then
			var15(j,:,:)=ff(x,:,:)
		end if
	end do
end do
hour15=dim_sum_n_Wrap(var15(:,:,:),0)
; printVarSummary(hour5)

;
t16 = asciiread("t16.txt/",-1, "integer")

var16 = new((/dimsizes(t16),101,121/),"float")             
          
do x=0,1114
	do j=0,dimsizes(t16)-1
		if(t16(j).eq.x) then
			var16(j,:,:)=ff(x,:,:)
		end if
	end do
end do
hour16=dim_sum_n_Wrap(var16(:,:,:),0)
; printVarSummary(hour5)

;
t17 = asciiread("t17.txt/",-1, "integer")

var17 = new((/dimsizes(t17),101,121/),"float")             
          
do x=0,1114
	do j=0,dimsizes(t17)-1
		if(t17(j).eq.x) then
			var17(j,:,:)=ff(x,:,:)
		end if
	end do
end do

hour17=dim_sum_n_Wrap(var17(:,:,:),0)
; printVarSummary(hour5)

;
t18 = asciiread("t18.txt/",-1, "integer")

var18 = new((/dimsizes(t18),101,121/),"float")             
          
do x=0,1114
	do j=0,dimsizes(t18)-1
		if(t18(j).eq.x) then
			var18(j,:,:)=ff(x,:,:)
		end if
	end do
end do

hour18=dim_sum_n_Wrap(var18(:,:,:),0)
; printVarSummary(hour5)

;
t19 = asciiread("t19.txt/",-1, "integer")

var19 = new((/dimsizes(t19),101,121/),"float")             
          
do x=0,1114
	do j=0,dimsizes(t19)-1
		if(t19(j).eq.x) then
			var19(j,:,:)=ff(x,:,:)
		end if
	end do
end do
hour19=dim_sum_n_Wrap(var19(:,:,:),0)
; printVarSummary(hour5)

;
t20 = asciiread("t20.txt/",-1, "integer")

var20 = new((/dimsizes(t20),101,121/),"float")             
          
do x=0,1114
	do j=0,dimsizes(t20)-1
		if(t20(j).eq.x) then
			var20(j,:,:)=ff(x,:,:)
		end if
	end do
end do
hour20=dim_sum_n_Wrap(var20(:,:,:),0)
; printVarSummary(hour5)

;
t21 = asciiread("t21.txt/",-1, "integer")

var21 = new((/dimsizes(t21),101,121/),"float")             
          
do x=0,1114
	do j=0,dimsizes(t21)-1
		if(t21(j).eq.x) then
			var21(j,:,:)=ff(x,:,:)
		end if
	end do
end do
hour21=dim_sum_n_Wrap(var21(:,:,:),0)
; printVarSummary(hour5)

;
t22 = asciiread("t22.txt/",-1, "integer")

var22 = new((/dimsizes(t22),101,121/),"float")             
          
do x=0,1114
	do j=0,dimsizes(t22)-1
		if(t22(j).eq.x) then
			var22(j,:,:)=ff(x,:,:)
		end if
	end do
end do
hour22=dim_sum_n_Wrap(var22(:,:,:),0)
; printVarSummary(hour5)

;
t23 = asciiread("t23.txt/",-1, "integer")

var23 = new((/dimsizes(t23),101,121/),"float")             
          
do x=0,1114
	do j=0,dimsizes(t23)-1
		if(t23(j).eq.x) then
			var23(j,:,:)=ff(x,:,:)
		end if
	end do
end do

hour23=dim_sum_n_Wrap(var23(:,:,:),0)
; printVarSummary(hour5)

;
t24= asciiread("t24.txt/",-1, "integer")

var24 = new((/dimsizes(t24),101,121/),"float")             
          
do x=0,1114
	do j=0,dimsizes(t24)-1
		if(t24(j).eq.x) then
			var24(j,:,:)=ff(x,:,:)
		end if
	end do
end do
hour24=dim_sum_n_Wrap(var24(:,:,:),0)


;------------------------------------4h-----------------------------------

hour4_1 = hour1 + hour2 + hour3 + hour4
hour4_2 = hour5 + hour6 + hour7 + hour8
hour4_3 = hour9 + hour10 + hour11 + hour12
hour4_4 = hour13 + hour14 + hour15 + hour16
hour4_5 = hour17 + hour18 + hour19 + hour20
hour4_6 = hour21 + hour22 + hour23 + hour24 

copy_VarMeta(hour1,hour4_1)
copy_VarMeta(hour1,hour4_2)
copy_VarMeta(hour1,hour4_3)
copy_VarMeta(hour1,hour4_4)
copy_VarMeta(hour1,hour4_5)
copy_VarMeta(hour1,hour4_6)

wrf_smooth_2d(hour4_1,2)
hour4_1=smth9_Wrap(hour4_1,0.25,-0.1,False)
hour4_1=runave(hour4_1,2,1)

wrf_smooth_2d(hour4_2,2)
hour4_2=smth9_Wrap(hour4_2,0.25,-0.1,False)
hour4_2=runave(hour4_2,2,1)

wrf_smooth_2d(hour4_3,2)
hour4_3=smth9_Wrap(hour4_3,0.25,-0.1,False)
hour4_3=runave(hour4_3,2,1)

wrf_smooth_2d(hour4_4,2)
hour4_4=smth9_Wrap(hour4_4,0.25,-0.1,False)
hour4_4=runave(hour4_4,2,1)

wrf_smooth_2d(hour4_5,2)
hour4_5=smth9_Wrap(hour4_5,0.25,-0.1,False)
hour4_5=runave(hour4_5,2,1)

wrf_smooth_2d(hour4_6,2)
hour4_6=smth9_Wrap(hour4_6,0.25,-0.1,False)
hour4_6=runave(hour4_6,2,1)



;---------------------------------------------------
wksname = "hour4_1"
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
res@tmXBLabelFontHeightF			   = 0.015                  ;坐标轴字号 0.019,0.014
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
res@lbLabelFontHeightF				   = 0.015                              ;
res@lbLabelStride				         = 2                       ;
res@pmLabelBarOrthogonalPosF			= 0.2                          ;
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

gsn_define_colormap(wks,"BlueDarkRed18")                ;BlueDarkRed18                          
res@cnLevelSelectionMode 			   = "ExplicitLevels"
res@cnSmoothingOn				         = True
res@cnSmoothingDistanceF            = 0.03            ;
res@cnSmoothingTensionF		         = 0.25


res@cnLevels					          = (/100,135,170,205,240,275,310/) ; 4h

res@cnFillColors                 = (/0,12,13,14,15,16,17,18/)



res@cnLineLabelFormat               = "00@;*.2f"                       ;小数位数 
res@gsnLeftString				         = " (a) 00-04 LST"  
res@gsnLeftStringOrthogonalPosF     = 0.02 
res@gsnLeftStringFontHeightF            = 0.0135    
;09-12 LST    13-16 LST   17-20 LST   21-24 LST   01-04 LST   05-08 LST

res@gsnRightString				         =  "           "       
res@gsnRightStringFontHeightF            = 0.0135

res@gsnRightStringOrthogonalPosF    = 0.03

plot(0)=gsn_csm_contour_map(wks,hour4_1,res)       ;f4 num_t rate

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