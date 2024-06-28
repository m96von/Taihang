begin

wksname = "700_1"
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
;topo&lon = lon
topo&lon@long_name = "Longitude"
topo&lon@units = "degrees_east"
topo@long_name = "  "
topo@units = "  " 
printVarSummary(topo)
;topo = runave(topo,10,0)
;topo = smth9_Wrap(topo,0.25,-0.25,False)
;wrf_smooth_2d(topo,1)

;-------------------------------read-var------------------------------

ff = addfile("../data/svd11_6.nc","r")

;printVarSummary(ff)
;level = (/100,200,300,500,700,750,800,850,875,900,925,950,1000/)
z = ff->z(:,4,:,:)         
delete(ff)
;printVarSummary(z)	    

z_avg = dim_avg_n_Wrap(z, 0)
zz = z_avg / 98
;printVarSummary(z_avg)
copy_VarMeta(z_avg, zz)
;printVarSummary(zz)
wrf_smooth_2d(zz,3)
zz = smth9_Wrap(zz,0.50,0.25,False)

		ff = addfile("/data/home/liyan/wangqy/ccr/data/climate/climate19912020.nc","r")

;printVarSummary(ff)
;level = (/200,300,500,700,850,925,950/)
z_clm = short2flt(ff->z(:,3,::-1,:))                        
delete(ff)
;printVarSummary(z_clm)
z_clm_avg = dim_avg_n_Wrap(z_clm,0)
;printVarSummary(z_clm_avg)
z_ano = z_avg - z_clm_avg

zz_ano = z_ano/98 
copy_VarMeta(z_avg, zz_ano)
zz_clm = z_clm_avg/98
copy_VarMeta(z_avg, zz_clm)
wrf_smooth_2d(zz_ano,2)
;printVarSummary(zz_ano)
;printMinMax(zz_ano,0)

;--------------------------------


ff = addfile("../data/svd11_6.nc","r")

;printVarSummary(ff)
q = ff->q(:,4,:,:)                            
delete(ff)
;printVarSummary(rh)	                          

q_avg = dim_avg_n_Wrap(q, 0)
qq = q_avg * 1000
copy_VarMeta(q_avg, qq)
wrf_smooth_2d(qq,3)
qq= smth9_Wrap(qq,0.50,0.25,False)
;printMinMax(qq,0)

		ff = addfile("/data/home/liyan/wangqy/ccr/data/climate/climate19912020.nc","r")

printVarSummary(ff)
;level = (/200,300,500,700,850,925,950/)
q_clm = short2flt(ff->q(:,3,::-1,:))                        
delete(ff)
printVarSummary(q_clm)
q_clm_avg = dim_avg_n_Wrap(q_clm,0)
printVarSummary(q_clm_avg)
q_ano = q_avg - q_clm_avg
qq_ano = q_ano * 1000
copy_VarMeta(q_avg, qq_ano)

wrf_smooth_2d(qq_ano,3)
printVarSummary(qq_ano)

;-------------------------------------
ff = addfile("../data/svd11_6.nc","r")

;printVarSummary(ff)
u = ff->u(:,4,:,:)                            
delete(ff)
;printVarSummary(u)	                          

u_avg = dim_avg_n_Wrap(u, 0)
printVarSummary(u_avg)

		ff = addfile("/data/home/liyan/wangqy/ccr/data/climate/climate19912020.nc","r")

printVarSummary(ff)
;level = (/200,300,500,700,850,925,950/)
u_clm = short2flt(ff->u(:,3,::-1,:))                        
delete(ff)
;printVarSummary(u_clm)
u_clm_avg = dim_avg_n_Wrap(u_clm,0)
;printVarSummary(u_clm_avg)
u_ano = u_avg - u_clm_avg
copy_VarMeta(u_avg, u_ano)

;---------------------------------------
ff = addfile("../data/svd11_6.nc","r")

printVarSummary(ff)
v = ff->v(:,4,:,:)                            
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
v_clm = short2flt(ff->v(:,3,::-1,:))                        
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

;------------------------------------------------------
ff = addfile("../data/svd11_6.nc","r")

;printVarSummary(ff)
w = ff->w(:,4,:,:)                              
delete(ff)
;printVarSummary(d)	                          

w_avg = dim_avg_n_Wrap(w, 0)
ww = w_avg 
copy_VarMeta(w_avg, ww)
wrf_smooth_2d(ww,3)
ww = smth9_Wrap(ww,0.50,0.25,False)
;printVarSummary(dd)

;------------------------------------------------

ff = addfile("../data/svd11_6.nc","r")

;printVarSummary(ff)
vo = ff->vo(:,4,:,:)                              
delete(ff)
;printVarSummary(d)	                          

vo_avg = dim_avg_n_Wrap(vo, 0)
vvo = vo_avg * 100000
copy_VarMeta(vo_avg, vvo)

ff = addfile("/data/home/liyan/wangqy/ccr/data/climate/climate.nc","r")
;level = (/100,200,300,500,700,750,850,925,950/)
printVarSummary(ff)
;level = (/200,300,500,700,850,925,950/)
vo_clm = short2flt(ff->vo(:,3,::-1,:))                        
delete(ff)
;printVarSummary(u_clm)
vo_clm_avg = dim_avg_n_Wrap(vo_clm,0)
vvo_clm = vo_clm_avg * 100000
;printVarSummary(u_clm_avg)
vo_ano = vvo - vvo_clm
copy_VarMeta(vo_avg, vo_ano)


wrf_smooth_2d(vvo,3)
vvo = smth9_Wrap(vvo,0.50,0.25,False)
;printVarSummary(dd)

;-

ff = addfile("../data/svd11_6.nc","r")

;printVarSummary(ff)
d = ff->d(:,7,:,:)                              
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
d_clm = short2flt(ff->d(:,4,::-1,:))                        
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
wrf_smooth_2d(dd_ano,3)
printVarSummary(dd_ano)

;---------------------------------------
;---------------------------
ff = addfile("../data/svd11_6.nc","r")

;printVarSummary(ff)
t = ff->t(:,4,:,:)                            
delete(ff)
;printVarSummary(t)	                          

t_avg = dim_avg_n_Wrap(t, 0)


		ff = addfile("/data/home/liyan/wangqy/ccr/data/climate/climate19912020.nc","r")

;printVarSummary(ff)
;level = (/200,300,500,700,850,925,950/)
t_clm = short2flt(ff->t(:,3,::-1,:))                        
delete(ff)
;printVarSummary(t_clm)
t_clm_avg = dim_avg_n_Wrap(t_clm,0)
;printVarSummary(u_clm_avg)
t_ano = t_avg - t_clm_avg
copy_VarMeta(t_avg, t_ano)


printVarSummary(t_ano)
wrf_smooth_2d(t_ano,3)
printMinMax(t_ano, 0)
;-----------------------plot--------------------------------------
wks_type = "pdf"
;wks_type@wkWidth = 2500
;wks_type@wkHeight = 2500 
wks=gsn_open_wks(wks_type,wksname)
;------------------------------------------------------------------
  res                                           = True          ; plot mods desired
  res@gsnDraw                                   = False
  res@gsnFrame                                  = False
  res@cnFillOn                                  = True          ; turn on color
  res@vpWidthF                                  = 0.5           ; change aspect ratio of plot
  res@vpHeightF                                 = 0.3
  res@gsnMaximize                               = True          ; maximize plot size
  res@cnLinesOn					                = False
  res@cnLineLabelsOn                            = False
  res@cnLineLabelFontHeightF                    = 0.01 
  res@trLineInterpolationOn		                = True
  ;--------坐标
  res@tmXBTickSpacingF			                = 10                       
  res@tmYLTickSpacingF			                = 10             
  res@tmXUseBottom				                = False
  res@tmYUseLeft				                = False
  res@tmXTOn					                = True
  res@tmYROn					                = True
  res@tmXBLabelFontHeightF		                = 0.014              
  res@tmYLLabelFontHeightF		                = 0.014
  res@tmXBLabelDeltaF   = -0.5
  res@tmYLLabelDeltaF   = -0.5
  res@tmXTLabelDaltaF   = -0.5
  res@tmYRLabelDeltaF   = -0.5   

  res@gsnAddCyclic 				                = False 
  ;--------色标
  res@lbOrientation				                = "vertical"        
  res@lbLabelFontHeightF		                = 0.015                      
  res@lbLabelStride                             = 1                 
  res@pmLabelBarOrthogonalPosF	                = 0.05                     
  res@pmLabelBarKeepAspect                      = True

  ;---------地图
  res@mpMaxLatF	= 50                          
  res@mpMinLatF	= 20 
  res@mpMaxLonF	= 135
  res@mpMinLonF	= 95  
  res@tmXBMode = "Explicit"
  res@tmXBValues = (/100,110,120,130,140/)
  res@tmXBLabels = (/"100E","110E","120E","130E","140E"/)
  res@tmYLMode = "Explicit"
  res@tmYLValues = (/20,30,40,50/)
  res@tmYLLabels = (/"20N","30N","40N","50N"/)
  res@gsnMinorLonSpacing = 10
  res@gsnMinorLatSpacing = 10


res@mpDataSetName              = "/data/home/liyan/wangqy/ccr/SVD/177/circulation/NCL-Chinamap/database/Earth..4"
res@mpDataBaseVersion          = "MediumRes" ; or "Ncarg4_1"
res@mpAreaMaskingOn            = True
res@mpMaskAreaSpecifiers       = (/"China"/)
res@mpOutlineSpecifiers        = (/"China","China:Provinces"/)
res@mpNationalLineColor        = "gray27"
res@mpCountyLineColor          = "gray27"
res@mpGeophysicalLineColor     = "gray27"
res@mpProvincialLineColor      = "gray27"
  ;----------等值线、阴影                   
  gsn_define_colormap(wks,"MPL_bwr") 
  res@cnLevelSelectionMode 		                = "ExplicitLevels"


  res@cnLevels					                  =(/-2.5,-2.2,-1.9,-1.6,-1.3,-1/)
  res@cnFillColors				                = (/20,27,35,43,51,59,0/)   
  res@lbLabelStride                       = 1             
  res@gsnLeftString				                = "(c) Type1  700 hPa"  
  res@gsnLeftStringOrthogonalPosF            =  0.04
  res@gsnLeftStringFontHeightF            = 0.014
  res@gsnRightString				            = "  "  
 
  plot1 = gsn_csm_contour_map(wks,dd_ano,res)       ;avgrain ,avgnum ,rate

;-------------------------------------------------------------
mres=True
mres@gsnAddCyclic                            = False                ;The range of your longitude data is not 360.

mres@cnLinesOn                               = True
mres@cnLineColor			    	            = "gray35"
mres@cnLineLabelsOn                          = True
mres@cnLabelMasking                          = True
mres@cnLineLabelFontHeightF                  = 0.018             
mres@cnLineLabelInterval                     = 1
mres@cnLineLabelDensityF                     = 0.65
mres@cnLineLabelBackgroundColor              = "Transparent"
mres@cnLineLabelFontColor                    = "gray35"
mres@cnInfoLabelOn                           = False
mres@lbLabelBarOn                            = False
mres@gsnAddCyclic                            = False
mres@cnFillOn                                = False
mres@gsnContourNegLineDashPattern            = 2             

mres@cnSmoothingOn					        = True            
mres@cnSmoothingDistanceF                    = 0.005               
mres@cnSmoothingTensionF				     = -0.25
mres@cnLevelSelectionMode                    = "ExplicitLevels"
mres@cnLevels					            = (/-5,-4,-3,-2,-1,0,1,2,3,4,5/)            ;ano
mres@lbLabelStrings                      = (/-5,-4,-3,-2,-1,1,2,3,4,5/) 
mres@cnMonoLineThickness                     = False
mres@cnLineThicknesses                       = (/5,5,5,5,5,5,5,5,5,5,5,5,5,5/) 


mres@gsnLeftString                            = " "
mres@gsnRightString                           = " "
mres@gsnDraw			                         = False
mres@gsnFrame			                     = False

plot2 = gsn_csm_contour(wks,zz_ano,mres)            ;t_ano tt tt_clm
;----------------------------------------------------------
sres                                         =True
sres@gsnAddCyclic                            = False                ;The range of your longitude data is not 360.

sres@vcLineArrowThicknessF                   = 3.5
sres@vcMinDistanceF                          = 0.05        ;箭头之间距离
sres@vcLineArrowColor                        = "gray15"
sres@vcRefLengthF                            = 0.035        ;参考箭头长度
sres@vcRefAnnoOn                             = True        ;绘制参考箭头
sres@vcRefMagnitudeF                         = 6            ;参考箭头所表示的物理量的大小              ; 850-5 700-5 
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

   
;--------------------------------------------------------------------
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
tres@cnLevels					            =(/3000/)               ;3000-700,
tres@cnFillColors=  colorsm                 

tres@gsnLeftString                            = " "
tres@gsnRightString                           = " "
tres@gsnDraw			                         = False
tres@gsnFrame			                     = False
plot5 = gsn_csm_contour(wks,topo,tres)

  ;------------------------------------------------------------------
  colors = (/"gray50","white"/) 
  rest = True
  rest@gsnDraw = False
  rest@gsnFrame = False
  rest@cnFillOn = True
  rest@cnLinesOn = False
  rest@cnLineLabelsOn = False
  rest@cnInfoLabelOn = False
  rest@lbLabelBarOn = False
  rest@cnMonoFillPattern = False
  rest@cnLevelSelectionMode = "ExplicitLevels"
 ;  rest@cnLevels = (/0.05,0.01/)        ;; set to significance level
 ;  rest@cnFillPatterns = (/17,17,-1/)
  rest@cnLevels = (/0.01/)        ;; set to significance level
  rest@cnFillPatterns = (/17,-1/)
  rest@cnFillDotSizeF = 0.004
  rest@cnFillColors = colors
  rest@cnFillScaleF = 2.5
  rest@gsnLeftString = ""
  rest@gsnRightString = ""
;   plot_prob =gsn_csm_contour(wks,confi_tt,rest)


  overlay(plot1,plot2) 
  overlay(plot1,plot3)
  overlay(plot1,plot5)

   
;------------------------------------------------------
draw(plot1)
  xlon = (/113,115,115,113,113/)
  ylat = (/35,35,38.5,38.5,35/)
  reg                             = True
  reg@gsFillColor                 = "Transparent"
  ;reg@gsEdgeDashPattern           = 0
  reg@gsEdgesOn                   = True 
  reg@gsEdgeColor                 = "blue"
  reg@gsEdgeThicknessF            = 5
  reg@gsEdgeDashPattern           = 0                 ; 0-实线 1-虚线
  reg@gsEdgeDashSegLenF           = 0.2
  gsn_polygon(wks,plot1,xlon,ylat,reg)


frame(wks)
   




end


