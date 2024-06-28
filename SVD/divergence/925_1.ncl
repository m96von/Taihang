begin

wksname = "925_1_a"
;---------------------------------地形高度-----------------------------
lat1 = 5
lat2 = 70
lon1 = 90
lon2 = 150

        ff2 = addfile("/data/home/liyan/wangqy/topo/topo.nc","r")

topo = ff2->htopo({lat1:lat2},{lon1:lon2})
;topo&lat = lat
topo&lat@long_name = "Latitude"
topo&lat@units = "degrees_north"
;topo&lon = lona
topo&lon@long_name = "Longitude"
topo&lon@units = "degrees_east"
topo@long_name = "  "
topo@units = "  " 
;printVarSummary(topo)


;-------------------------------read-var------------------------------
lon = fspan(70.75,150.75,321)

ff = addfile("../data/svd11_6.nc","r")

;printVarSummary(ff)
;level = (/100,200,300,500,700,750,800,850,875,900,925,950,1000/)
d = ff->d(:,10,:,:)                            
delete(ff)
;printVarSummary(d)	                          

d_avg = dim_avg_n_Wrap(d, 0)
dd = d_avg * 100000
copy_VarMeta(d_avg, dd)
wrf_smooth_2d(dd,3)
dd = smth9_Wrap(dd,0.50,0.25,False)
;printVarSummary(dd)

		ff = addfile("/data/home/liyan/wangqy/ccr/data/climate/climate19912020.nc","r")

printVarSummary(ff)
;level = (/200,300,500,700,850,925,950/)
d_clm = short2flt(ff->d(:,5,::-1,:))                        
delete(ff)
printVarSummary(d_clm)
d_clm_avg = dim_avg_n_Wrap(d_clm,0)
printVarSummary(d_clm_avg)
d_ano = d_avg - d_clm_avg
dd_clm = d_clm_avg * 100000
dd_ano = d_ano * 100000
copy_VarMeta(d_avg, dd_ano)
copy_VarMeta(d_avg, dd_clm)
wrf_smooth_2d(dd_clm,3)

printVarSummary(dd_ano)

;-------------------------------------
ff = addfile("../data/svd11_6.nc","r")

;printVarSummary(ff)
u = ff->u(:,10,:,:)                            
delete(ff)
;printVarSummary(u)	                          

u_avg = dim_avg_n_Wrap(u, 0)
printVarSummary(u_avg)

		ff = addfile("/data/home/liyan/wangqy/ccr/data/climate/climate19912020.nc","r")

printVarSummary(ff)
;level = (/200,300,500,700,850,925,950/)
u_clm = short2flt(ff->u(:,5,::-1,:))                        
delete(ff)
;printVarSummary(u_clm)
u_clm_avg = dim_avg_n_Wrap(u_clm,0)
;printVarSummary(u_clm_avg)
u_ano = u_avg - u_clm_avg
copy_VarMeta(u_avg, u_ano)

;---------------------------------------
ff = addfile("../data/svd11_6.nc","r")

printVarSummary(ff)
v = ff->v(:,10,:,:)                            
delete(ff)
printVarSummary(v)	                          

v_avg = dim_avg_n_Wrap(v, 0)
printVarSummary(v_avg)

wind = sqrt((u_avg^2)+(v_avg^2))
copy_VarMeta(v_avg, wind)
;print(wind(0,100:120))

		ff = addfile("/data/home/liyan/wangqy/ccr/data/climate/climate19912020.nc","r")

printVarSummary(ff)
;level = (/200,300,500,700,850,925,950/)
v_clm = short2flt(ff->v(:,5,::-1,:))                        
delete(ff)
;printVarSummary(v_clm)
v_clm_avg = dim_avg_n_Wrap(v_clm,0)
;printVarSummary(v_clm_avg)
v_ano = v_avg - v_clm_avg
copy_VarMeta(v_avg, v_ano)
printVarSummary(v_ano)
wind_ano = wind - sqrt((u_clm_avg^2)+(v_clm_avg^2))
copy_VarMeta(u_avg, wind_ano)
wind_clm = sqrt((u_clm_avg^2)+(v_clm_avg^2))
copy_VarMeta(u_avg, wind_clm)
;printMinMax(wind_ano,0)
;

f1 = addfile("../prep/svd11.nc","r")

prep1 = f1->prep
printVarSummary(prep1)	

rain1 = prep1(:,{34.5:39},{112.5:115.5})                                ;
printVarSummary(rain1)
rain_s1 = dim_sum_n_Wrap(rain1,(/1,2/))
printVarSummary(rain_s1)
; print(rain_s1)

rain11 = where(rain1.ge.20,rain1,0)

f41 = dim_sum_n_Wrap(rain1,0)                    ;
printMinMax(f41,0)

wrf_smooth_2d(f41,2)
f41=smth9_Wrap(f41,0.25,-0.1,False)
f41=runave(f41,2,1)



dd_ano&longitude = lon
dd&longitude = lon
u_avg&longitude = lon
u_ano&longitude = lon
v_avg&longitude = lon
v_ano&longitude = lon
;-----------------------plot--------------------------------------

wks_type = "pdf"
wks=gsn_open_wks(wks_type,wksname)

  res = True        
  res@gsnDraw = False
  res@gsnFrame = False
  res@cnFillOn = True        
  res@vpWidthF = 0.5          
  res@vpHeightF = 0.3
  res@gsnMaximize = True          ; maximize plot size
  res@cnLinesOn	= False
  res@cnLineLabelsOn = False
  res@cnLineLabelFontHeightF = 0.01 
  res@trLineInterpolationOn	= True
  res@gsnAddCyclic                            = False 
  ;--------坐标
  res@tmXBTickSpacingF = 10              ;标注间隔           
  res@tmYLTickSpacingF = 10             
  res@tmXUseBottom = True
  res@tmYUseLeft = True
  res@tmXTOn = True
  res@tmYROn = True
  res@tmXBLabelFontHeightF = 0.013                   ; 0.019,0.014
  res@tmYLLabelFontHeightF = 0.013
  res@tmXBLabelDeltaF   = -0.5
  res@tmYLLabelDeltaF   = -0.5
  res@tmXTLabelDaltaF   = -0.5
  res@tmYRLabelDeltaF   = -0.5  

res@mpMaxLatF	= 41                          
res@mpMinLatF	= 33 
res@mpMaxLonF	= 119
res@mpMinLonF	= 111
res@tmXBMode = "Explicit"
res@tmXBValues = (/108,110,112,114,116,118,120,122/)
res@tmXBLabels = (/"108E","110E","112E","114E","116E","118E","120E","122E"/)
res@tmYLMode = "Explicit"
res@tmYLValues = (/28,30,32,34,36,38,40,42/)
res@tmYLLabels = (/"28N","30N","32N","34N","36N","38N","40N","42N"/)
res@gsnMinorLonSpacing = 1
res@gsnMinorLatSpacing = 1
  ;--------色标
  res@lbOrientation	= "vertical"        ;horizontal/vertical
  res@lbLabelFontHeightF = 0.013                              ;
  res@lbLabelStride = 2                       ;
  res@pmLabelBarOrthogonalPosF	= 0.05                          ;
  ;res@lbLabelBarOn	= False
  ;---------地图
  res@mpDataSetName              = "/data/home/liyan/wangqy/ccr/SVD/177/circulation/NCL-Chinamap/database/Earth..4"
  res@mpDataBaseVersion          = "MediumRes" ; or "Ncarg4_1"
  res@mpAreaMaskingOn            = True
  res@mpMaskAreaSpecifiers       = (/"China"/)
  res@mpOutlineSpecifiers        = (/"China","China:Provinces"/)
  ;----------等值线、阴影
  gsn_define_colormap(wks,"BlueDarkRed18")                      ;
  res@cnLevelSelectionMode = "ExplicitLevels"
  res@cnSmoothingOn	= True
  res@cnSmoothingDistanceF = 0.01     ;0.01  2.5
  res@cnSmoothingTensionF	= 2.5
  res@cnLevels = (/-3,-2.5,-2,-1.5,-1,-0.5,0,0.5,1,1.5,2,2.5,3/)
  res@cnFillColors = (/4,5,6,7,8,9,0,0,12,13,14,15,16,17/)

  
  res@cnLineLabelFormat = "00@;*.2f"                       ;小数位数 
  ;----------标题、图注
  res@gsnLeftString = "(a) Type1 925 hPa"   
  res@gsnLeftStringOrthogonalPosF = 0.03
  res@gsnLeftStringFontHeightF    = 0.014
  res@gsnRightString = "  "  
 

  wrf_smooth_2d(dd_ano,2)
  plot1 = gsn_csm_contour_map(wks,dd_ano,res)       

;----------------------------------------------------------------------
colorsm = (/"Transparent","gray33"/) 
tres=True
tres@gsnAddCyclic                            = False                ;The range of your longitude data is not 360.

tres@cnLinesOn                               = False
tres@cnLineColor			    	               = "black"
tres@cnLineLabelsOn                          = False
tres@cnLabelMasking                          = True
tres@cnLineLabelFontHeightF                  = 0.018                ;等值线标签大小  area
tres@cnLineLabelInterval                     = 1
tres@cnLineLabelBackgroundColor              = "Transparent"
tres@cnLineLabelFontColor                    = "black"
tres@cnInfoLabelOn                           = False
tres@lbLabelBarOn                            = False
tres@gsnAddCyclic                            = False
tres@cnFillOn                                = True
tres@gsnContourNegLineDashPattern            = 2                   ;负值用虚线


tres@cnLevelSelectionMode                    = "ExplicitLevels"
tres@cnMonoLineThickness                     = False
tres@cnLevels					            =(/800/)               ;700-3000  950-700  850-1400
tres@cnFillColors=  colorsm                 

tres@gsnLeftString                            = " "
tres@gsnRightString                           = " "
tres@gsnDraw			                         = False
tres@gsnFrame			                     = False
plot2 = gsn_csm_contour(wks,topo,tres)

;----------------------------------------------
sres                                         =True
sres@gsnAddCyclic                            = False                ;The range of your longitude data is not 360.

sres@vcLineArrowThicknessF                   = 3.5
sres@vcMinDistanceF                          = 0.05        ;箭头之间距离
sres@vcLineArrowColor                        = "gray15"
sres@vcRefLengthF                            = 0.035        ;参考箭头长度
sres@vcRefAnnoOn                             = True        ;绘制参考箭头
sres@vcRefMagnitudeF                         = 5            ;参考箭头所表示的物理量的大小              ; 850-5 700-5 
;sres@vcRefMagnitudeF                         = 5            ;ano
sres@vcRefAnnoSide                           = "Right"        ;位置
sres@vcRefAnnoOrthogonalPosF                 = -0.32        ;调整位置
sres@vcRefAnnoParallelPosF                   = 1.15
sres@vcRefAnnoBackgroundColor                = -1        ;参考箭头背景色设为透明  -1 透明 1 黑
sres@vcRefAnnoFontHeightF                    = 0.02
sres@vcRefAnnoPerimOn                        = False        ;参考箭头的边框
sres@vcRefAnnoString1On                      = True        ;参考箭头之上的字符串
sres@vcRefAnnoString2On                      = True        ;之下字符串
sres@vcRefAnnoString2                        = " "

sres@gsnDraw			                        = False
sres@gsnFrame			                        = False
sres@gsnLeftString                           = " "
sres@gsnRightString                          = " "

plot3 = gsn_csm_vector(wks,u_ano,v_ano,sres)            ;u_avg v_avg  u_ano v_ano  u_clm_avg
;----------------------------------------------------------------------
cres                                         = True
cres@gsnDraw                                 = False
cres@gsnAddCyclic                            = False
cres@gsnFrame                                = False
cres@cnLinesOn                               = True
cres@cnLineColor			    	                 = "firebrick4"
cres@cnLineLabelsOn                          = False
cres@cnLabelMasking                          = True
cres@cnLineLabelFontHeightF                  = 0.018                ;等值线标签大小  area
cres@cnLineLabelInterval                     = 1
cres@cnLineLabelDensityF                     = 0.60
cres@cnLineLabelBackgroundColor              = "Transparent"
cres@cnLineLabelFontColor                    = "red"
cres@cnInfoLabelOn                           = False
cres@lbLabelBarOn                            = False
cres@cnFillOn                                = False
cres@gsnContourNegLineDashPattern            = 2
cres@cnLevelSelectionMode                    = "ExplicitLevels"

cres@cnLevels					          = (/100/)     ;prep_all 

cres@cnMonoLineThickness                     = False
cres@lbLabelBarOn                        = True
cres@lbOrientation				                = "vertical" 
cres@lbLabelFontHeightF				   = 0.017                              ;色标字号
cres@lbLabelStride				         = 2                       ;标记的间隔
cres@pmLabelBarOrthogonalPosF			= 0.25                          ;色标位置
cres@pmLabelBarParallelPosF          = 0.5
cres@cnLineThicknesses                       = (/5/) 

cres@gsnLeftString                           = "  "
cres@gsnRightString                          = " "

plot4 = gsn_csm_contour(wks,f41({34:39},{113:115}),cres)            ;zz zz_ano  zz_clm


;-------------------------------------------------------------------
mres=True
mres@gsnAddCyclic                            = False                ;The range of your longitude data is not 360.

mres@cnLinesOn                               = True
mres@cnLineColor			    	                 = "green3"
mres@cnLineLabelsOn                          = False
mres@cnLabelMasking                          = True
mres@cnLineLabelFontHeightF                  = 0.022                ;等值线标签大小  area
mres@cnLineLabelInterval                     = 1
mres@cnLineLabelDensityF                     = 0.6
mres@cnLineLabelBackgroundColor              = "Transparent"
mres@cnLineLabelFontColor                    = "green3"
mres@cnInfoLabelOn                           = False
mres@lbLabelBarOn                            = False
mres@gsnAddCyclic                            = False
mres@cnFillOn                                = False
mres@gsnContourNegLineDashPattern            = 2                   ;负值用虚线

mres@cnSmoothingOn					        = True            
mres@cnSmoothingDistanceF                    = 0.005               
mres@cnSmoothingTensionF				     = -0.25
mres@cnLevelSelectionMode                    = "ExplicitLevels"
mres@cnLevels					            = (/3/)            ;ano
mres@cnMonoLineThickness                     = False
mres@cnLineThicknesses                       = (/7/) 


mres@gsnLeftString                            = " "
mres@gsnRightString                           = " "
mres@gsnDraw			                         = False
mres@gsnFrame			                     = False

wrf_smooth_2d(wind_ano,1)
plot5 = gsn_csm_contour(wks,wind_ano,mres)            ;t_ano tt tt_clm


  overlay(plot1,plot3)
  overlay(plot1,plot4)
  overlay(plot1,plot5)
  overlay(plot1,plot2)

  ;--------------------------------------------------
  draw(plot1)
  xlon = (/113,115,115,113,113/)
  ylat = (/35,35,38.5,38.5,35/)
  reg = True
  reg@gsFillColor = "Transparent"
  ;reg@gsEdgeDashPattern = 0
  reg@gsEdgesOn = True 
  reg@gsEdgeColor = "blue"
  reg@gsEdgeThicknessF = 5
  reg@gsEdgeDashPattern = 0                 ; 0-实线 1-虚线
  reg@gsEdgeDashSegLenF = 0.2
  gsn_polygon(wks,plot1,xlon,ylat,reg)

frame(wks)

   




end








