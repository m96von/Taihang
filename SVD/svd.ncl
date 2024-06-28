begin


  y1      = 1                    ; 
  y2      = 177                  ; 
  nsvd    = 3                    ;


  infile1 = "/data/home/liyan/wangqy/ccr/data/177/T300_6.nc"    
  infile2 = "/data/home/liyan/wangqy/ccr/data/177/topo_data/U925_6_800.nc"    
  out     = "pdf"                   ; 
  ;----------------------------------------------------------------------------

        ff2 = addfile("/data/home/liyan/wangqy/topo/topo.nc","r")

  topo = ff2->htopo(:,:)
  ;topo&lat = lat
  topo&lat@long_name = "Latitude"
  topo&lat@units = "degrees_north"
  ;topo&lon = lon
  topo&lon@long_name = "Longitude"    
  topo&lon@units = "degrees_east"
  topo@long_name = "  "
  topo@units = "  " 
  printVarSummary(topo)
  ;--------------------------------------------------------------------------------
  in1     = addfile(infile1,"r")                                    
  t     = in1->t(:,:,:) 
  ;                                           
  t     = dtrend_msg_n(ispan(y1,y2,1),t,True,False,0)
                                          
  lat1    = in1->latitude                    
  lon1    = in1->longitude                   
  t!0   = "time"                           
  t!1   = "lat"
  t!2   = "lon"
  ;delete([/time,YYYYMM/])                  
                                           
  delete(in1)                                           

 ;----------------------------------------------------------------------------------
  in2     = addfile(infile2,"r")
 
  ;
  ;u     = in2->u(t1:t2:12,:,:)
  u     = in2->u(:,:,:)
  ;
  u     = dtrend_msg_n(ispan(y1,y2,1),u,True,False,0)
  lat2    = in2->latitude
  lon2    = in2->longitude
  u!0   = "time"
  u!1   = "lat"
  u!2   = "lon"
  ;delete([/time,YYYYMM/])
  delete(in2)  
  

  LAT1  = ind(lat1.ge.20.and.lat1.le.50)      ; 
  LON1  = ind(lon1.ge.100.and.lon1.le.130)    ;              
  var1  = t(lat|LAT1,lon|LON1,time|:)      
                                              
  dim1  = dimsizes(var1)                    
  print(dim1)
  NY1   = dim1(0)
  NX1   = dim1(1)
  NT1   = dim1(2)

  wgt1  = sqrt(cos(lat1(LAT1)*atan(1.)/45.))  
  NW1   = dimsizes(wgt1)
  do j = 0, NW1-1
    var1(j,:,:) = var1(j,:,:) * wgt1(j)
  end do
 
  var1 := reshape(var1,(/NY1*NX1,NT1/))              ;reshape 
  NMS1  = ind(.not.ismissing(var1(:,0)))      
  var1 := var1(NMS1,:)                                                              

;---------------------------------------------------------------------
  LAT2  = ind(lat2.ge.20.and.lat2.le.50)
  LON2  = ind(lon2.ge.100.and.lon2.le.130)
  var2  = u(lat|LAT2,lon|LON2,time|:)
  dim2  = dimsizes(var2)
  NY2   = dim2(0)
  NX2   = dim2(1)
  NT2   = dim2(2)                         
  wgt2  = sqrt(cos(lat2(LAT2)*atan(1.)/45.))
  NW2   = dimsizes(wgt2)
  do j = 0, NW2-1
    var2(j,:,:) = var2(j,:,:) * wgt2(j)
  end do
  var2 := reshape(var2,(/NY2*NX2,NT2/))
  NMS2  = ind(.not.ismissing(var2(:,0)))
  var2 := var2(NMS2,:)
 
  delete([/t,u,dim1,dim2/])
;----------------------------------svd------------------------------------
  var1_svc = new((/nsvd,dimsizes(NMS1)/),float)             ; 
  var2_svc = new((/nsvd,dimsizes(NMS2)/),float)             ; 
  pcvar_a  = svdstd_sv(var1,var2,nsvd,var1_svc,var2_svc)    ; SVD!            ;std cov
  var1_hom = new((/nsvd,dimsizes(NMS1)/),float)             ; hom
  var1_het = new((/nsvd,dimsizes(NMS1)/),float)             ; het
  var2_hom = new((/nsvd,dimsizes(NMS2)/),float)            
  var2_het = new((/nsvd,dimsizes(NMS2)/),float)             
  pcvar_b  = svdstd(var1,var2,nsvd,var1_hom,var1_het,var2_hom,var2_het)  ; SVD!              ;svdcov 不标准化，svdstd svd前标准化处理

  delete([/var1,var2/])
  ;;; pcvar_a = pcvar_b
  ;;; pcvar_b

  t_pc   = reshape(pcvar_b@ak,(/nsvd,NT1/))               ; 
  u_pc   = reshape(pcvar_b@bk,(/nsvd,NT2/))             

  ;;;    t_pc   = var1_svc#var1
  ;;;    u_pc   = var2_svc#var2


  t_pc@pcvar = pcvar_b                        
  u_pc@pcvar = pcvar_b
  t_svc  = new((/nsvd,NY1*NX1/),float)       

  t_svc(:,NMS1) = var1_svc                      
  t_svc := reshape(t_svc,(/nsvd,NY1,NX1/))    
  u_svc  = new((/nsvd,NY2*NX2/),float)         
  u_svc(:,NMS2) = var2_svc
  u_svc := reshape(u_svc,(/nsvd,NY2,NX2/))
  t_hom  = new((/nsvd,NY1*NX1/),float)         
  t_hom(:,NMS1) = var1_hom
  t_hom := reshape(t_hom,(/nsvd,NY1,NX1/))
  u_hom  = new((/nsvd,NY2*NX2/),float)        
  u_hom(:,NMS2) = var2_hom
  u_hom := reshape(u_hom,(/nsvd,NY2,NX2/))
  t_het  = new((/nsvd,NY1*NX1/),float)         
  t_het(:,NMS1) = var1_het
  t_het := reshape(t_het,(/nsvd,NY1,NX1/))
  u_het  = new((/nsvd,NY2*NX2/),float)   
  u_het(:,NMS2) = var2_het
  u_het := reshape(u_het,(/nsvd,NY2,NX2/))
  delete([/var1_svc,var2_svc,var1_hom,var1_het,var2_hom,var2_het/])

  
  do j = 0, NW1-1
    t_svc(:,j,:) = t_svc(:,j,:) / wgt1(j)
  end do
  do j = 0, NW2-1
    u_svc(:,j,:) = u_svc(:,j,:) / wgt2(j)
  end do

;-------------------------------------------------------
  t_svc!0    = "svd"
  t_svc!1    = "lat_t"
  t_svc!2    = "lon_t"
  t_svc&svd  = ispan(1,nsvd,1)
  t_svc&lat_t = lat1(LAT1)
  t_svc&lon_t = lon1(LON1)
  copy_VarCoords(t_svc,t_hom)
  copy_VarCoords(t_svc,t_het)
  t_pc!0     = "svd"
  t_pc!1     = "year"
  t_pc&svd   = ispan(1,nsvd,1)
  t_pc&year  = ispan(y1,y2,1)
  u_svc!0    = "svd"
  u_svc!1    = "lat_u"
  u_svc!2    = "lon_u"
  u_svc&svd  = ispan(1,nsvd,1)
  u_svc&lat_u = lat2(LAT2)
  u_svc&lon_u = lon2(LON2)
  copy_VarCoords(u_svc,u_hom)
  copy_VarCoords(u_svc,u_het)
  u_pc!0    = "svd"
  u_pc!1    = "year"
  u_pc&svd  = ispan(1,nsvd,1)
  u_pc&year = ispan(y1,y2,1)
 


  asciiwrite("t_pc_nostd.txt",t_pc)
  asciiwrite("u_pc_nostd.txt",u_pc)

  do i = 0, nsvd - 1
    t_svc(i,:,:) = t_svc(i,:,:)*stddev(t_pc(i,:))
    u_svc(i,:,:) = u_svc(i,:,:)*stddev(u_pc(i,:))
    t_pc(i,:)    = t_pc(i,:)/stddev(t_pc(i,:))
    u_pc(i,:)    = u_pc(i,:)/stddev(u_pc(i,:))

  end do

  printVarSummary(u_het)
  printVarSummary(t_het)
  printVarSummary(u_pc)
  printVarSummary(t_pc)
 
  ccr = new((/3/),float)
  do i = 0,nsvd - 1
    ccr(i) = escorc(t_pc(i,:), u_pc(i,:))
  end do
  print(ccr)


  asciiwrite("t_pc.txt",t_pc)
  asciiwrite("u_pc.txt",u_pc)
  
  fout=addfile("out_svd.nc","c")
  fout@creation_date:= systemfunc("date")
  fout->t_het=t_het       ;{15:55},{95:135}
  fout->u_het=u_het 
  fout->t_hom=t_hom      ;{15:55},{95:135}
  fout->u_hom=u_hom 
  
  b=fout
  printVarSummary(b)
  
  wrf_smooth_2d(t_het,2)
  t_het=smth9_Wrap(t_het,0.25,-0.1,False)
  t_het=runave(t_het,2,1)

  wrf_smooth_2d(u_het,2)
  u_het=smth9_Wrap(u_het,0.25,-0.1,False)
  u_het=runave(u_het,2,1)
  
  ;----------------------------plot-------------------------------------------
  
  res1 = True                                  ;
  res1@gsnDraw          = False               
  res1@gsnFrame         = False              
  res1@cnFillOn         = True                  
  res1@cnLinesOn        = False                
  res1@cnLineLabelsOn   = False                
  res1@cnInfoLabelOn    = False                
  res1@lbLabelBarOn     = True               
                                             
  res1@lbTitleOn        = True                 
  res1@lbTitlePosition  = "Right"             
  res1@lbTitleDirection = "Across"            
  res1@pmLabelBarOrthogonalPosF     = 0.3      
  res1@mpDataBaseVersion			      = "Ncarg4_1"                   ;;;地图
  res1@mpDataSetName			          = "Earth..4"
  res1@mpAreaMaskingOn			        = True
  res1@mpOutlineSpecifiers		      = (/"China:states","Taiwan"/)  
  res1@mpOceanFillColor			        = 0
  res1@mpInlandWaterFillColor	                = 0
  res1@mpLandFillColor			        = 0
  res1@mpOutlineOn				= True
  res1@gsnAddCyclic     = False              
  res1@tmXTOn           = False                
  res1@cnLevelSelectionMode = "ManualLevels"  
 

  res3 = res1                         

  res1@mpMinLatF                = 20.         
  res1@mpMaxLatF                = 50.         
  res1@mpMinLonF                = 100.        
  res1@mpMaxLonF                = 130.        
  res1@mpCenterLonF             = 180.        
  res1@tmXBMode                 = "Explicit"
  res1@tmXBValues               = (/100,110,120,130/)
  res1@tmXBLabels               = (/"100E","110E","120E","130E"/)
  res1@tmYLMode                 = "Explicit"
  res1@tmYLValues               = (/20,30,40,50/)
  res1@tmYLLabels               = (/"20N","30N","40N","50N"/)
  res1@gsnMinorLonSpacing       = 5
  res1@gsnMinorLatSpacing       = 5     
  res1@cnMinLevelValF           = -75.       
  res1@cnMaxLevelValF           =  75.         
  res1@cnLevelSpacingF          =  15.
  res1@lbTitleString            = "m"         
  res1@lbTitleFontHeightF       = 0.021        
  res1@lbLabelFontHeightF       = 0.021        
  res1@gsnLeftString            = "(a) T300"       
  res1@gsnLeftStringFontColor   = "black"        
  res1@gsnLeftStringFontHeightF = 0.04 
  res1@gsnLeftStringOrthogonalPosF  = 0.03      
  res1@tmYLOn                   = True       
  res1@tmYLLabelsOn             = True       
  res1@tmYROn                   = False       
  res1@tmYRLabelsOn             = False       
  res1@tmXBLabelFontHeightF     = 0.04       
  res1@tmYLLabelFontHeightF     = 0.04       


  res3@mpMinLatF                = 20.
  res3@mpMaxLatF                = 50.
  res3@mpMinLonF                = 100.
  res3@mpMaxLonF                = 130.
  res3@mpCenterLonF             = 180.
  res3@tmYLOn                   = True    
  res3@tmYLLabelsOn             = True
  res3@tmYROn                   = False      
  res3@tmYRLabelsOn             = False
  res3@tmXBMode                 = "Explicit"
  res3@tmXBValues               = (/100,110,120,130/)
  res3@tmXBLabels               = (/"100E","110E","120E","130E"/)
  res3@tmYLMode                 = "Explicit"
  res3@tmYLValues               = (/20,30,40,50/)
  res3@tmYLLabels               = (/"20N","30N","40N","50N"/)
  res3@gsnMinorLonSpacing       = 5
  res3@gsnMinorLatSpacing       = 5  
  res3@cnMinLevelValF           = -0.6
  res3@cnMaxLevelValF           =  0.6
  res3@cnLevelSpacingF          =  0.1
  res3@lbTitleString            = "~S~o~N~C"
  res3@lbTitleFontHeightF       = 0.008
  res3@lbLabelFontHeightF       = 0.008
  res3@gsnLeftString            = "(b) U925"
  res3@gsnLeftStringFontColor   = "black"
  res3@gsnLeftStringFontHeightF = 0.04
  res3@gsnLeftStringOrthogonalPosF  = 0.03
  res3@tmYRTickSpacingF         = 10
  res3@tmXBLabelFontHeightF     = 0.04
  res3@tmYRLabelFontHeightF     = 0.04
  res3@mpShapeMode              = "FreeAspect"
  ;res3@vpWidthF                 = 0.3         

  res2                          = True         
  res2@gsnDraw                  = False        
  res2@gsnFrame                 = False 
  res2@vpWidthF                 = 0.73   
  res2@vpHeightF                = 0.3   
  res2@trXMinF                  = 0           
  res2@trXMaxF                  = 178           
  res2@trYMinF                  = -5          
  res2@trYMaxF                  =  5  
  res2@tmYLLabelFontHeightF     = 0.025
  res2@tmXBLabelFontHeightF     = 0.025
  res2@tiYAxisString            = "Time coef"
  res2@tiYAxisFontHeightF       = 0.025
  res2@tmXTOn                   = False       
  res2@vpHeightF                = 0.3
  res2@tmYRLabelsOn             = False        
  res2@xyLineColors             = (/"red","blue"/)      
  res2@xyDashPattern            = 0            
  res2@gsnYRefLine              = 0                   
  res2@gsnLeftStringFontHeightF      = 0.025
  res2@gsnLeftStringOrthogonalPosF   = 0.03 
  res2@gsnRightStringFontHeightF      = 0.025
  res2@gsnRightStringOrthogonalPosF   = 0.03 
  res2@gsnCenterStringFontHeightF    = 0.028
  res2@gsnCenterStringOrthogonalPosF = 0.185
  res2@xyExplicitLegendLabels        = (/"T300","U925"/) 
  res2@pmLegendDisplayMode           = "Always"
  res2@pmLegendOrthogonalPosF        = -0.52         ;
  res2@pmLegendParallelPosF          = 1.275            ;
  res2@pmLegendWidthF                = 0.11 
  res2@pmLegendHeightF               = 0.066

 
  pres                            = True      
  pres@gsnPanelTop                = 0.9        
  pres@gsnPanelBottom             = 0.1       
  pres@gsnPanelYWhiteSpacePercent = 5         
  pres@gsnPanelLabelBar           = False      
                                              
  pres@pmLabelBarWidthF           = 0.6        
  pres@pmLabelBarHeightF          = 0.05       
  pres@lbLabelFontHeightF         = 0.012     
  
  p2res                            = True      
  p2res@gsnPanelTop                = 0.9        
  p2res@gsnPanelBottom             = 0.1       
  p2res@gsnPanelYWhiteSpacePercent = 5         
  p2res@gsnPanelLabelBar           = False      
                                              
  p2res@pmLabelBarWidthF           = 0.6        
  p2res@pmLabelBarHeightF          = 0.05       
  p2res@lbLabelFontHeightF         = 0.012  


  attach_res1 = True
  attach_res2 = True
  attach_res3 = True


  wks   = gsn_open_wks(out,"1")
  gsn_define_colormap(wks,"BlueWhiteOrangeRed")
  plot1 = new(nsvd,graphic)
  plot2 = new(nsvd,graphic)
  plot3 = new(nsvd,graphic)
  dum   = new(nsvd,graphic)

  do i = 0, nsvd-1
    
    if (i.eq.nsvd-1) then
      res1@lbLabelBarOn  = True
      res3@lbLabelBarOn  = True
    end if
  
    res2@gsnCenterString = "SVD "+sprinti("%1.1i",t_svc&svd(i)) + " : "+sprintf("%3.1f",t_pc@pcvar(i)) + "%   "
    res2@gsnLeftString = "(c) " 
    res2@gsnRightString = "ccr = " + sprintf("%4.2f",ccr(i))
    plot1(i) = gsn_csm_contour_map_ce(wks,t_svc(i,:,:),res1)
   
    plot2(i) = gsn_csm_xy(wks,t_pc&year,(/t_pc(i,:),u_pc(i,:)/),res2)
   
    plot3(i) = gsn_csm_contour_map_ce(wks,u_svc(i,:,:),res3)
    
    dum(i)   = gsn_attach_plots(plot2(i),plot3(i),attach_res2,attach_res3)
    
    dum(i)   = gsn_attach_plots(plot1(i),plot2(i),attach_res1,attach_res2)
  end do
  gsn_panel(wks,plot1,(/nsvd,1/),pres)     
  delete([/wks,plot1,plot2,plot3,dum/])     

 
  res1@lbLabelBarOn     = False            
  res3@lbLabelBarOn     = False             
  pres@gsnPanelLabelBar = True             
 
  wks   = gsn_open_wks(out,"2")
  gsn_define_colormap(wks,"BlueWhiteOrangeRed")
  plot1 = new(nsvd,graphic)
  plot2 = new(nsvd,graphic)
  plot3 = new(nsvd,graphic)
  dum   = new(nsvd,graphic)
  res1@cnMinLevelValF   = -0.9              
  res1@cnMaxLevelValF   =  0.9              
  res1@cnLevelSpacingF  =  0.1
  ;res1@cnFillColors	    = (/10,20,30,40,50,60,70,78,86,94,128,128,150,160,170,180,190,200,210,220,230,240,250/)
  res3@cnMinLevelValF   = -0.9
  res3@cnMaxLevelValF   =  0.9
  res3@cnLevelSpacingF  =  0.1
  ;res3@cnFillColors	    = (/10,20,30,40,50,60,70,78,86,94,128,128,150,160,170,180,190,200,210,220,230,240,250/)
  do i = 0, nsvd-1
    res2@gsnCenterString = "SVD "+sprinti("%1.1i",t_hom&svd(i)) + " : "+sprintf("%3.1f",t_pc@pcvar(i)) + "%   "
    res2@gsnLeftString = "(c) " 
    res2@gsnRightString = "ccr = " + sprintf("%4.2f",ccr(i))
    plot1(i) = gsn_csm_contour_map_ce(wks,t_hom(i,:,:),res1)
    plot2(i) = gsn_csm_xy(wks,t_pc&year,(/t_pc(i,:),u_pc(i,:)/),res2)
    plot3(i) = gsn_csm_contour_map_ce(wks,u_hom(i,:,:),res3)
    dum(i)   = gsn_attach_plots(plot2(i),plot3(i),attach_res2,attach_res3)
    dum(i)   = gsn_attach_plots(plot1(i),plot2(i),attach_res1,attach_res2)
  end do
  gsn_panel(wks,plot1,(/nsvd,1/),pres) 
  delete([/wks,plot1,plot2,plot3,dum/])

 
  wks   = gsn_open_wks(out,"3")
  gsn_define_colormap(wks,"BlueWhiteOrangeRed")
  plot1 = new(nsvd,graphic)
  plot2 = new(nsvd,graphic)
  plot3 = new(nsvd,graphic)
  dum   = new(nsvd,graphic)

  res1@cnLevelSelectionMode="ExplicitLevels" 
  res1@cnLevels=(/-0.6,-0.55,-0.5,-0.45,-0.4,-0.35,-0.3,-0.25,-0.2,-0.15,-0.1,-0.05,0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6/)
  res1@cnFillColors=(/10,19,27,34,41,48,54,62,70,78,86,94,0,0,150,158,167,176,185,194,203,212,221,230,240,250/)
 
  res3@cnLevelSelectionMode="ExplicitLevels" 
  res3@cnLevels=(/-0.6,-0.55,-0.5,-0.45,-0.4,-0.35,-0.3,-0.25,-0.2,-0.15,-0.1,-0.05,0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6/)
  res3@cnFillColors=(/10,19,27,34,41,48,54,62,70,78,86,94,0,0,150,158,167,176,185,194,203,212,221,230,240,250/)
  
  
  do i = 0, nsvd-1
    res2@gsnCenterString = "SVD "+sprinti("%1.1i",t_het&svd(i)-1) + " : "+sprintf("%3.1f",t_pc@pcvar(i)) + "%   -6h"
    res2@gsnLeftString = "(c) " 
    res2@gsnRightString = "ccr = " + sprintf("%4.2f",ccr(i))
    plot1(i) = gsn_csm_contour_map_ce(wks,t_het(i,:,:),res1)

    plot2(i) = gsn_csm_xy(wks,t_pc&year,(/t_pc(i,:),u_pc(i,:)/),res2)

    plot3(i) = gsn_csm_contour_map_ce(wks,u_het(i,:,:),res3)
    ; dum(i)   = gsn_attach_plots(plot2(i),plot3(i),attach_res2,attach_res3)
    ; dum(i)   = gsn_attach_plots(plot1(i),plot2(i),attach_res1,attach_res2)
  end do

;-----------------------------------------------
  xlon = (/113,115,115,113,113/)
  ylat = (/35,35,38.5,38.5,35/)
  reg                             = True
  reg@gsFillColor                 = "Transparent"
  ;reg@gsEdgeDashPattern           = 0
  reg@gsEdgesOn                   = True 
  reg@gsEdgeColor                 = "blue"
  reg@gsEdgeThicknessF            = 5
  reg@gsEdgeDashPattern           = 1                 ; 0-实线 1-虚线
  reg@gsEdgeDashSegLenF           = 0.2
  plot4 = gsn_add_polygon(wks,plot1(0),xlon, ylat,reg)
  plot5 = gsn_add_polygon(wks,plot1(1),xlon, ylat,reg)
  plot6 = gsn_add_polygon(wks,plot3(0),xlon, ylat,reg)
  plot7 = gsn_add_polygon(wks,plot3(1),xlon, ylat,reg)
  plot8 = gsn_add_polygon(wks,plot1(2),xlon, ylat,reg)
  plot9 = gsn_add_polygon(wks,plot3(2),xlon, ylat,reg)

;-----------------------------------------------------------
   mres=True
   mres@gsnAddCyclic                            = False                ;The range of your longitude data is not 360.

   mres@cnLinesOn                               = False
   mres@cnLineColor			    	               = "black"
   mres@cnLineLabelsOn                          = False
   mres@cnLabelMasking                          = True
   mres@cnLineLabelFontHeightF                  = 0.015                ;等值线标签大小  area
   mres@cnLineLabelInterval                     = 2
   mres@cnLineLabelBackgroundColor              = "Transparent"
   mres@cnLineLabelFontColor                    = "black"
   mres@cnInfoLabelOn                           = False
   mres@lbLabelBarOn                            = False
   mres@gsnAddCyclic                            = False
   mres@cnFillOn                                = True
   mres@gsnContourNegLineDashPattern            = 2                   ;负值用虚线

   mres@cnLevelSelectionMode                    = "ExplicitLevels"
   mres@cnMonoLineThickness                     = False
   mres@cnLevels					            =(/800/) 
   mres@cnFillColors=  (/(/-1,-1,-1/),(/86,86,86/)/)/255.0                     

   mres@gsnLeftString                            = " "
   mres@gsnRightString                           = " "
   mres@gsnDraw			                         = False
   mres@gsnFrame			                     = False
   plot10 = gsn_csm_contour(wks,topo,mres)
   plot11 = gsn_csm_contour(wks,topo,mres)
   plot12 = gsn_csm_contour(wks,topo,mres)

   overlay(plot3(0),plot10)
   overlay(plot3(1),plot11)
   overlay(plot3(2),plot12)
;----------------------------------------------------------------------

  gsn_panel(wks,plot1,(/nsvd,1/),pres)
  gsn_panel(wks,plot2,(/nsvd,1/),p2res)
  gsn_panel(wks,plot3,(/nsvd,1/),pres)
  delete([/wks,plot1,plot2,plot3,dum/])



end