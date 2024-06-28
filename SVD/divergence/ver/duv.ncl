begin
 
 
 latc = 37.5
 lonc_1 = 113
 lonc_2 = 115.5

 latd = 36
 lond_1 = 113
 lond_2 = 115.5

 wks   = gsn_open_wks ("pdf", "duv1" )

 var= addfile("../../vertical/6h/svd11.nc","r")                                 ; open netcdf file
 var2= addfile("../../vertical/6h/svd22.nc","r")                                 ; open netcdf file
 var_d = addfile("../../vertical/6h/d11.nc","r")
 var2_d = addfile("../../vertical/6h/d22.nc","r")
;************************************************
   clm = addfile("/data/home/liyan/wangqy/ccr/SVD/427/vertical/123/climate.nc","r")                                 ; open netcdf file
   clm_drh = addfile("/data/home/liyan/wangqy/ccr/SVD/427/vertical/123/climate_drh.nc","r")
   d_temp = clm_drh->d(:,10:,::-1,:)
   u_temp = clm->u(:,10:,::-1,:)
   v_temp = clm->v(:,10:,::-1,:)
   w_temp = clm->w(:,10:,::-1,:)
   q_temp = clm->q(:,10:,::-1,:)
   
   d31= d_temp(:,:,{latc},{lonc_1:lonc_2})                                        
   d3=short2flt(d31)
   clmd3=dim_avg_n_Wrap(d3,0) * 100000
   copy_VarCoords(d3(0,:,:),clmd3)

   u31= u_temp(:,:,{latc},{lonc_1:lonc_2})                                         ; read in variable
   u3=short2flt(u31)
   clmu3=dim_avg_n_Wrap(u3,0)
   copy_VarCoords(d3(0,:,:),clmu3)

   v31= v_temp(:,:,{latc},{lonc_1:lonc_2})                                         ; read in variable
   v3=short2flt(v31)
   clmv3=dim_avg_n_Wrap(v3,0)
   copy_VarCoords(v3(0,:,:),clmv3)

   w31= w_temp(:,:,{latc},{lonc_1:lonc_2})                                         ; read in variable
   w3=short2flt(w31)
   printVarSummary(w3)
   clmw3=dim_avg_n_Wrap(w3,0) *-10
   copy_VarCoords(w3(0,:,:),clmw3)

   q31= q_temp(:,:,{latc},{lonc_1:lonc_2})                                         ; read in variable
   q3=short2flt(q31)
   clmq3=dim_avg_n_Wrap(q3,0)
   copy_VarCoords(q3(0,:,:),clmq3)
 ;--------------------------------------------------
   d41= d_temp(:,:,{latd},{lond_1:lond_2})                                         ; read in variable 38
   d4=short2flt(d41)
   clmd4=dim_avg_n_Wrap(d4,0) * 100000
   copy_VarCoords(d4(0,:,:),clmd4)

   u41= u_temp(:,:,{latd},{lond_1:lond_2})                                         ; read in variable
   u4=short2flt(u41)
   clmu4=dim_avg_n_Wrap(u4,0)
   copy_VarCoords(d4(0,:,:),clmu4)

   v41= v_temp(:,:,{latd},{lond_1:lond_2})                                         ; read in variable
   v4=short2flt(v41)
   clmv4=dim_avg_n_Wrap(v4,0)
   copy_VarCoords(v4(0,:,:),clmv4)

   w41= w_temp(:,:,{latd},{lond_1:lond_2})                                         ; read in variable
   w4=short2flt(w41)
   clmw4=dim_avg_n_Wrap(w4,0)*-10
   copy_VarCoords(w4(0,:,:),clmw4)

   q41= q_temp(:,:,{latd},{lond_1:lond_2})                                         ; read in variable
   q4=short2flt(q41)
   clmq4=dim_avg_n_Wrap(q4,0)
   copy_VarCoords(q4(0,:,:),clmq4)

   delete([/clm,clm_drh/])
   delete([/d_temp,u_temp,v_temp,q_temp/]) 
   delete([/d31,d41,d3,d4,v31,v41,v3,v4/])
   delete([/u31,u41,u3,u4,q31,q41,q3,q4,w31,w41,w3,w4/])
; ===========================t

   d = var_d->d                                                ; read in variable
   dd = var2_d->d
   d!0   = "time"
   d!1   = "lev"
   d!2   = "lat"
   d!3   = "lon"
   dd!0   = "time"
   dd!1   = "lev"
   dd!2   = "lat"
   dd!3   = "lon"
   d_n=d(time|:,lev|:,{lat|latc},{lon|lonc_1:lonc_2})
   d_s=dd(time|:,lev|:,{lat|latd},{lon|lond_1:lond_2})
   d1=dim_avg_n_Wrap(d_n,0)*100000
   d2=dim_avg_n_Wrap(d_s,0)*100000 
   anomd1=d1(:,:)-clmd3(:,:)
   anomd2=d2(:,:)-clmd4(:,:)
   copy_VarCoords(clmd3(:,:),anomd1)
   copy_VarCoords(clmd4(:,:),anomd2)

   ; wrf_smooth_2d(anomd1,2)
   ; wrf_smooth_2d(anomd2,2)

   delete([/d,dd,d1,d2/])
; ===========================2                              ; open netcdf file
   v = var->v(:,10:,:,:)                                                ; read in variable
   vv = var2->v(:,10:,:,:) 
   v!0   = "time"
   v!1   = "lev"
   v!2   = "lat"
   v!3   = "lon"
   vv!0   = "time"
   vv!1   = "lev"
   vv!2   = "lat"
   vv!3   = "lon"
   v_n=v(time|:,lev|:,{lat|latc},{lon|lonc_1:lonc_2})
   v_s=vv(time|:,lev|:,{lat|latd},{lon|lond_1:lond_2})
   v1=dim_avg_n_Wrap(v_n,0)
   v2=dim_avg_n_Wrap(v_s,0)
   anomv1=v1(:,:)-clmv3(:,:)
   anomv2=v2(:,:)-clmv4(:,:)
   copy_VarCoords(clmv3(:,:),anomv1)
   copy_VarCoords(clmv4(:,:),anomv2)
   delete([/v,vv,v1,v2/])
; ===========================3                              ; open netcdf file
   u = var->u(:,10:,:,:)                                                ; read in variable
   uu = var2->u(:,10:,:,:) 
   u!0   = "time"
   u!1   = "lev"
   u!2   = "lat"
   u!3   = "lon"
   uu!0   = "time"
   uu!1   = "lev"
   uu!2   = "lat"
   uu!3   = "lon"
   u_n=u(time|:,lev|:,{lat|latc},{lon|lonc_1:lonc_2})
   u_s=uu(time|:,lev|:,{lat|latd},{lon|lond_1:lond_2})
   u1=dim_avg_n_Wrap(u_n,0)
   u2=dim_avg_n_Wrap(u_s,0)
   anomu1=u1(:,:)-clmu3(:,:)
   anomu2=u2(:,:)-clmu4(:,:)
   copy_VarCoords(clmu3(:,:),anomu1)
   copy_VarCoords(clmu4(:,:),anomu2)
   delete([/u,uu,u1,u2/])

; ===========================5   
   w = var->w(:,10:,:,:)                                                 ; read in variable
   ww = var2->w(:,10:,:,:) 
   w!0   = "time"
   w!1   = "lev"
   w!2   = "lat"
   w!3   = "lon"
   ww!0   = "time"
   ww!1   = "lev"
   ww!2   = "lat"
   ww!3   = "lon"
   w_n=w(time|:,lev|:,{lat|latc},{lon|lonc_1:lonc_2})
   w_s=ww(time|:,lev|:,{lat|latd},{lon|lond_1:lond_2})
   w1=dim_avg_n_Wrap(w_n,0)*-10
   w2=dim_avg_n_Wrap(w_s,0)*-10
   anomw1=w1(:,:)-clmw3(:,:)
   anomw2=w2(:,:)-clmw4(:,:)
   copy_VarCoords(clmw3(:,:),anomw1)
   copy_VarCoords(clmw4(:,:),anomw2)
   delete([/w,ww,w1,w2/])
; ===========================5                               ; open netcdf file
   q = var->q(:,10:,:,:)                                               ; read in variable
   qq = var2->q(:,10:,:,:) 
   q!0   = "time"
   q!1   = "lev"
   q!2   = "lat"
   q!3   = "lon"
   qq!0   = "time"
   qq!1   = "lev"
   qq!2   = "lat"
   qq!3   = "lon"
   q_n=q(time|:,lev|:,{lat|latc},{lon|lonc_1:lonc_2})
   q_s=qq(time|:,lev|:,{lat|latd},{lon|lond_1:lond_2})
   ; q12=dim_avg_n_Wrap(q_n,0)*1000
   ; q22=dim_avg_n_Wrap(q_s,0)*1000
   q12=dim_avg_n_Wrap(q_n,0)
   q22=dim_avg_n_Wrap(q_s,0)
   anomq1=q12(:,:)-clmq3(:,:)
   anomq2=q22(:,:)-clmq4(:,:)
   copy_VarCoords(clmq3(:,:),anomq1)
   copy_VarCoords(clmq4(:,:),anomq2)

   ; wrf_smooth_2d(anomq1,2)
   ; wrf_smooth_2d(anomq2,2)

   delete([/q,qq/])

;************************************************
            ; open workstation
  plot=new(2,"graphic")
  plotq=new(1,"graphic")
  gsn_define_colormap(wks,"BlueDarkRed18")
  
   res                        = True                 
   res@gsnFrame               = False                   
   res@gsnDraw                = False                   
   res@gsnAddCyclic           = False     
   res@cnLevelSpacingF        = 1                 
   res@cnMinLevelValF         = -6                 
   res@cnMaxLevelValF         =  6              
   res@cnLineLabelsOn         = True               
   res@cnFillOn               = True                
   res@cnLinesOn              = False
   res@cnLineLabelsOn         = False
   res@tmYROn		            = True
   res@tmXTOn                 = True
   res@tmXBLabelDeltaF   = -0.5
   res@tmYLLabelDeltaF   = -0.5
   res@tmXTLabelDaltaF   = -0.5
   res@tmYRLabelDeltaF   = -0.5  
   res@tmXBMode               = "Explicit"
   res@tmYRMode               = "Automatic"
   ; res@cnFillPalette          = "BlueDarkRed18"             
   res@lbLabelBarOn           = False  
   res@cnInfoLabelOn          = False  
   res@cnLevelSelectionMode   = "ExplicitLevels" 
   res@cnLevels = (/-5.5,-4.5,-3.5,-2.5,-1.5,-0.5,0,0.5,1.5,2.5,3.5,4.5,5.5/)
   res@cnFillColors = (/4,5,6,7,8,9,0,0,12,13,14,15,16,17/)


   res@vcLineArrowThicknessF  = 2.7
   res@vcRefAnnoZone          = 0  ;
   res@vcRefAnnoOrthogonalPosF = -0.5            
   res@vcRefAnnoParallelPosF  = 0.6
   res@vcRefAnnoBackgroundColor = -1
   res@vcRefAnnoPerimOn       = False
   res@vcRefMagnitudeF        = 3           
   res@vcRefLengthF           = 0.035       
   res@vcMinDistanceF         = 0.05       
   ;res@vcMapDirection         = False
   ;res@vcGlyphStyle           = "LineArrow"       
   res@vcMinDistanceF         = 0.035             
   res@vcRefAnnoFontHeightF   = 0.022
   res@vcRefAnnoString2On     = False


   resc                        = res 
   resc@tmXBLabelFontHeightF   = 0.033
   resc@tmYLLabelFontHeightF   = 0.033
   resc@tiYAxisString		    = "Pressure(hPa)"
   resc@tmXBMode               = "Explicit"
   resc@tmXBValues             = (/113,113.5,114,114.5,115,115.5/)
   resc@tmXBLabels             = (/"113E","113.5E","114E","114.5E","115E","115.5E"/)

   resd                        = res 
   resd@tiYAxisString			 = " "
   resd@tmXBLabelFontHeightF   = 0.033
   resd@tmYLLabelFontHeightF   = 0.033
   resd@tmXBMode               = "Explicit"
   resd@tmXBValues             = (/113,113.5,114,114.5,115,115.5/)
   resd@tmXBLabels             = (/"113E","113.5E","114E","114.5E","115E","115.5E"/)

   res1                       = True              ;z,u
   res1@gsnFrame              = False                    
   res1@gsnDraw               = False                    
   res1@cnFillOn              = False
   res1@cnLinesOn             = True
   res1@gsnAddCyclic          = False      ;
   res1@gsnLeftString         = ""
   res1@gsnRightString        = ""
   res1@cnLevelSelectionMode  = "ExplicitLevels"
   res1@cnInfoLabelOn         = False
   res1@cnLineThicknessF      = 3
   res1@cnLineLabelBackgroundColor = -1
   res1@cnLineLabelPlacementMode = "Constant"
   res1@cnLineLabelFontHeightF = 0.025 
   res1@gsnContourNegLineDashPattern = 1       
   res1@lbLabelBarOn          = False 
   res1@cnInfoLabelOn         = False  
   res1@tmYRMode              = "Automatic"

   res2                       = True                       ;q 
   res2@gsnFrame              = False                   
   res2@gsnDraw               = False                     
   res2@cnFillOn              = False
   res2@cnLinesOn             = True
   res2@gsnAddCyclic          = False     
   res2@cnLineColor		      = "ForestGreen"
   res2@cnLineLabelFontColor  = "ForestGreen"
   res2@gsnLeftString         = ""
   res2@cnLevelSelectionMode  = "ExplicitLevels"
   res2@cnLevels              = (/-4,-3,-2,-1,1,2,3,4/)
   res2@cnInfoLabelOn         = False
   res2@cnLineThicknessF      = 3
   res2@cnLineLabelBackgroundColor = -1
   res2@cnLineLabelPlacementMode = "Constant"
   res2@cnLineLabelFontHeightF = 0.025
   res2@gsnContourNegLineDashPattern = 1      
   res2@lbLabelBarOn          = False   
   res2@tmYRMode              = "Automatic"


; ===========================a
   res@tmYLLabelsOn           = True
   resc@gsnLeftString        = "(c) Type1 plane AB "
   resc@gsnRightString        = " C' - D'  "
   resc@gsnRightStringFontColor = "red"
   resc@gsnRightStringFontHeightF = 0.03
   resc@gsnLeftStringFontHeightF = 0.03
   wrf_smooth_2d(anomd1,1)
   wrf_smooth_2d(anomd2,1)
   plot(0) = gsn_csm_pres_hgt_vector(wks, anomd1(11:,:) , anomu1(11:,:), anomw1(11:,:) , resc)
   plotq=gsn_csm_pres_hgt(wks,anomq1(11:,:),res2)
   ; overlay(plot(0),plotq) 
; ===========================b
   
   ;res@tmYLLabelsOn           = False
   resd@gsnLeftString        = "(d) Type2 plane A'B' "
   resd@gsnRightString        = "  A'  B' "
   resd@gsnRightStringFontHeightF = 0.03
   resd@gsnRightStringFontColor = "red"
   resd@gsnLeftStringFontHeightF = 0.03
   plot(1) = gsn_csm_pres_hgt_vector(wks, anomd2(11:,:) , anomu2(11:,:), anomw2(11:,:) , resd)
   plotq=gsn_csm_pres_hgt(wks,anomq2(11:,:),res2)
   ; overlay(plot(1),plotq) 

;---Panel all four plots
  resP                       = True                            ; panel mods desired
  resP@gsnMaximize           = True                            ; fill up the page
  resP@gsnPanelLabelBar      = True
  resP@lbOrientation		     = "vertical"
  resP@lbLabelStride         = 2
  resP@lbLabelFontHeightF    = 0.018
  resP@gsnPanelYWhiteSpacePercent = 1
  resP@gsnPanelXWhiteSpacePercent = 0
  gsn_panel(wks,plot,(/1,2/),resP)  
end