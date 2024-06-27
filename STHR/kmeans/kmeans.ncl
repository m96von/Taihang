begin

;------------------------------------------------------------------------------------------

wksname = "kmeans1_a"

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

	    f = addfile("/data/home/liyan/wangqy/ccr/data/prep/rain177_all.nc","r")

;printVarSummary(f)	

lat = fspan(34,44,101)
lon = fspan(109,121,121 )
time = fspan(1,177,177)

f1 = f->prep
;printVarSummary(f1)
f2 = where(ismissing(f1),0,f1)
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
printVarSummary(f2)


xr = f2(lat|:,lon|:,time|:)            ; make 'time' (observations; M) the rightmost dimension
xrr = xr({35:38.5},{113:115},:)
printVarSummary(xrr)

k  = 2                                ; # clusters (user specified)

opt       = True
opt@iseed = 1
clcntr    = kmeans_as136(xrr, k, opt)   ; input the reordered array    

printVarSummary(clcntr)
copy_VarCoords(xrr(:,:,0),clcntr(0,:,:))
printVarSummary(clcntr(0,:,:))
; print(clcntr@id)


clcntr(0,:,:) = clcntr(0,:,:) * 98
clcntr(1,:,:) = clcntr(1,:,:) * 79
copy_VarCoords(xrr(:,:,0),clcntr(0,:,:))


wrf_smooth_2d(clcntr,1)                                    
clcntr=smth9_Wrap(clcntr,0.25,-0.1,False)
clcntr=runave(clcntr,2,1)
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
res@tmXBTickSpacingF			         = 1              ;坐标间隔           
res@tmYLTickSpacingF			         = 1
res@tmXBMinorOn                     = True
res@tmXTOn				            	= True
res@tmYROn					            = True
res@tmXBLabelFontHeightF			   = 0.017                  ;坐标轴字号 0.019,0.014
res@tmYLLabelFontHeightF		       = 0.017
res@mpMaxLatF					         = 38.5   ;40                          ;35-38.5,113-115
res@mpMinLatF					         = 35 
res@mpMaxLonF					         = 115
res@mpMinLonF					         = 113                     
res@tmXBMode                        = "Explicit"
res@tmXBValues                      = (/113,114,115/)
res@tmXBLabels                      = (/"113E","114E","115E"/)
res@tmYLMode                        = "Explicit"
res@tmYLValues                      = (/35,36,37,38/)
res@tmYLLabels                      = (/"35N","36N","37N","38N"/)

res@gsnAddCyclic 				         = False 

res@lbOrientation				         = "vertical"        ;色标/horizontal/vertical
res@lbLabelFontHeightF				   = 0.017                              ;色标字号
res@lbLabelStride				         = 2                       ;标记的间隔
res@pmLabelBarOrthogonalPosF			= 0.10                          ;色标位置
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
res@cnSmoothingDistanceF            = 0.01            ;越小越平滑
res@cnSmoothingTensionF		         = 2.5
; res@cnFillColors				         = (/0,35,60,100,130,146,175,205/)
res@cnFillColors                 = (/0,11,12,13,14,15,16,17/)
res@cnLineLabelsOn               = False
res@cnLineLabelFormat               = "00@;*.2f"                       ;小数位数
res@gsnRightString				      = " "
res@gsnLeftStringOrthogonalPosF     = 0.03
res@gsnRightStringOrthogonalPosF    = 0.02
res@gsnLeftStringFontHeightF       = 0.014
res@gsnRightStringFontHeightF       = 0.013


; res@cnLevels					          = (/2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7/)    ;prep    
res@cnLevels					          = (/200,275,350,425,500,575,650/)    ;prep 
; res@cnLevels					          = (/100,150,200,250,300,350,400/)    ;prep 

res@lbLabelBarOn                    = False
res@gsnLeftString				       = "(a) Cluster1 num=98"     
; res@gsnRightString				       = "(55.37%)"      
plot(0)=gsn_csm_contour_map(wks,clcntr(0,:,:),res)       ;


res@lbLabelBarOn                    = True
res@gsnLeftString				       = "(b) Cluster2 num=79"   
; res@gsnRightString				       = "(44.63%)" 
plot(1)=gsn_csm_contour_map(wks,clcntr(1,:,:),res)       ;

  ;-----------------------------overlay--------------------------

  cres                                    = True
  cres@gsnDraw                            = False
  cres@gsnFrame                           = False
  cres@cnLinesOn                          = True
  cres@cnLineColor						  = "dim grey"
  cres@cnLineLabelFontHeightF             = 0.032          ;area
  cres@cnLineLabelDensityF                = 1
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