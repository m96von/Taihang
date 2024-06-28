begin

wksname = "300_1"
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
z = ff->z(:,2,:,:)        
t = ff->t(:,2,:,:)    
u = ff->u(:,1,:,:)   
u200 = ff->u(:,1,:,:)  
d = ff->d(:,2,:,:)     
delete(ff)
;printVarSummary(z)	    

z_avg = dim_avg_n_Wrap(z, 0) 
zz = z_avg / 98 
;printVarSummary(z_avg)
copy_VarMeta(z_avg, zz)
;printVarSummary(zz)


		ff = addfile("/data/home/liyan/wangqy/ccr/data/climate/climate19912020.nc","r")

;printVarSummary(ff)
;level = (/200,300,500,700,850,925,950/)
z_clm = short2flt(ff->z(:,1,::-1,:))         
t_clm = short2flt(ff->t(:,1,::-1,:))      
u_clm = short2flt(ff->u(:,0,::-1,:))      
d_clm = short2flt(ff->d(:,1,::-1,:))          
delete(ff)
;printVarSummary(z_clm)
z_clm_avg = dim_avg_n_Wrap(z_clm,0)
;printVarSummary(z_clm_avg)
z_ano = z_avg - z_clm_avg
zz_ano = z_ano/98 
zz_clm = z_clm_avg/98
copy_VarMeta(z_avg, zz_clm)
copy_VarMeta(z_avg, zz_ano)
wrf_smooth_2d(zz_ano,2)
wrf_smooth_2d(zz,2)
zz= smth9_Wrap(zz,0.50,0.25,False)
;printVarSummary(zz_ano)

;-------------------------------------ttest----------

z_var = dim_variance_n_Wrap(z,0)
z_clm_var = dim_variance_n_Wrap(z_clm,0)
m = tofloat(dimsizes(z_clm(:,0,0)))
n = tofloat(dimsizes(z(:,0,0)))

iflag = True           ; population variance similar
tval_opt= False            ; p-value only
confi_zz = ttest(z_clm_avg,z_clm_var,m,z_avg,z_var,n, iflag, tval_opt)
printVarSummary(confi_zz)
copy_VarMeta(zz, confi_zz)

;---------------------------                        

t_avg = dim_avg_n_Wrap(t, 0)

;printVarSummary(t_clm)
t_clm_avg = dim_avg_n_Wrap(t_clm,0)
;printVarSummary(u_clm_avg)
t_ano = t_avg - t_clm_avg
copy_VarMeta(t_avg, t_ano)


t_var = dim_variance_n_Wrap(t,0)
t_clm_var = dim_variance_n_Wrap(t_clm,0)
m = tofloat(dimsizes(t_clm(:,0,0)))
n = tofloat(dimsizes(t(:,0,0)))

iflag = True           ; population variance similar
tval_opt= False            ; p-value only
confi_tt = ttest(t_clm_avg,t_clm_var,m,t_avg,t_var,n, iflag, tval_opt)
printVarSummary(confi_tt)
copy_VarMeta(t_avg, confi_tt)


printVarSummary(t_ano)
wrf_smooth_2d(t_ano,3)
printMinMax(t_ano, 0)


;-------------------------------------
;printVarSummary(u)	                          

u_avg = dim_avg_n_Wrap(u, 0)
u200_avg = dim_avg_n_Wrap(u200, 0)


;printVarSummary(u_clm)
u_clm_avg = dim_avg_n_Wrap(u_clm,0)
;printVarSummary(u_clm_avg)
u_ano = u_avg - u_clm_avg
copy_VarMeta(u_avg, u_ano)

wrf_smooth_2d(u_ano,2)
;-------------------------                         

d_avg = dim_avg_n_Wrap(d, 0)
dd = d_avg * 100000
copy_VarMeta(d_avg, dd)


wrf_smooth_2d(dd,3)
dd = smth9_Wrap(dd,0.50,0.25,False)
;printVarSummary(dd)


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
  res@lbLabelStride                             = 2                
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
  gsn_define_colormap(wks,"BlueWhiteOrangeRed") 
  res@cnLevelSelectionMode 		                = "ExplicitLevels"

  res@cnLevels					                  =(/-5,-4,-3,-2,-1,0,1,2,3,4,5/)
  res@cnFillColors				                = (/40,50,60,70,80,93,145,152,165,178,194,205/)     
  res@lbLabelStride                       = 2            
  res@gsnLeftString				                = "(a) Type1  300 hPa"  
  res@gsnLeftStringOrthogonalPosF            =  0.04
  res@gsnLeftStringFontHeightF            = 0.014
  res@gsnRightString				            = "  "  

  plot1 = gsn_csm_contour_map(wks,t_ano,res)       ;avgrain ,avgnum ,rate

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
mres@cnLevels					            = (/-8,-6,-4,-2,0,2,4,6,8,10,12,14,16,18,20/)            ;ano
mres@cnMonoLineThickness                     = False
mres@cnLineThicknesses                       = (/5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5/) 


mres@gsnLeftString                            = " "
mres@gsnRightString                           = " "
mres@gsnDraw			                         = False
mres@gsnFrame			                     = False

plot2 = gsn_csm_contour(wks,zz_ano,mres)            ;t_ano tt tt_clm
;----------------------------------------------------------
   cres                                         = True
   cres@gsnDraw                                 = False
   cres@gsnAddCyclic                            = False
   cres@gsnFrame                                = False
   cres@cnLinesOn                               = True
   cres@cnLineColor						                  = "red"
   cres@cnLineLabelsOn                          = True
   cres@cnLabelMasking                          = True
   cres@cnLineLabelFontHeightF                  = 0.018           
   cres@cnLineLabelInterval                     = 1
   cres@cnLineLabelDensityF                     = 0.60
   cres@cnLineLabelBackgroundColor              = "Transparent"
   cres@cnLineLabelFontColor                    = "red"
   cres@cnInfoLabelOn                           = False
   cres@lbLabelBarOn                            = False
   cres@cnFillOn                                = False
   cres@gsnContourNegLineDashPattern            = 2

   cres@cnLevelSelectionMode                    = "ExplicitLevels"
  ;  cres@cnLevels					            = (/560,562,564,566,568,570,572,574,576,578,580,582,584,586,588,590,592/)
   cres@cnLevels					            = (/-7,-5,-3,-1,1,3,5,7,9/)
   cres@cnMonoLineThickness                     = False
   cres@cnLineThicknesses                       = (/5,5,5,5,5,5,5,5,5,5,5,5,5,5,8,5,5,5,5,6/) 
  
   cres@gsnLeftString                           = "  "
   cres@gsnRightString                          = " "

   plot3 = gsn_csm_contour(wks,t_ano,cres)            ;zz zz_ano  zz_clm
   
;--------------------------------------------------------------------


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
  rest@cnLevels = (/0.01/)        ;; set to significance level
  rest@cnFillPatterns = (/17,-1/)
  rest@cnFillDotSizeF = 0.004
  rest@cnFillColors = colors
  rest@cnFillScaleF = 2.5
  rest@gsnLeftString = ""
  rest@gsnRightString = ""
  plot_prob =gsn_csm_contour(wks,confi_tt,rest)


  overlay(plot1,plot2) 
   
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






