begin
 
 
 latc = 33
 lonc_1 = 100
 lonc_2 = 125

 latd = 33
 lond_1 = 100
 lond_2 = 125
 g = 9.8

 wks   = gsn_open_wks ("pdf", "mis33" )

 var= addfile("../vertical/6h/svd11.nc","r")                                 ; open netcdf file
 var2= addfile("../vertical/6h/svd22.nc","r")                                 ; open netcdf file
 var_d = addfile("../vertical/6h/d11.nc","r")
 var2_d = addfile("../vertical/6h/d22.nc","r")
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

   vx31 = q3*u3*1000/g
   vy31 = q3*v3*1000/g
   vint31 = sqrt((vx31^2)+(vy31^2))
   copy_VarMeta(q3,vint31)
   ; q*u/g*1000→10g/(cm*s*hPa)
   clmvint3 = dim_avg_n_Wrap(vint31,0)
   copy_VarMeta(clmq3,clmvint3)

   wind31 = sqrt((v3^2)+(u3^2))
   copy_VarMeta(q3,wind31)
   ; q*u/g*1000→10g/(cm*s*hPa)
   clmwind3 = dim_avg_n_Wrap(wind31,0)
   copy_VarMeta(clmq3,clmwind3)

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

   vx41 = q4*u4*1000/g
   vy41 = q4*v4*1000/g
   vint41 = sqrt((vx41^2)+(vy41^2))
   copy_VarMeta(q4,vint41)
   ; q*u/g*1000→10g/(cm*s*hPa)
   clmvint4 = dim_avg_n_Wrap(vint41,0)
   copy_VarMeta(clmq4,clmvint4)

   wind41 = sqrt((v4^2)+(u4^2))
   copy_VarMeta(q4,wind41)
   ; q*u/g*1000→10g/(cm*s*hPa)
   clmwind4 = dim_avg_n_Wrap(wind41,0)
   copy_VarMeta(clmq4,clmwind4)

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
   delete([/v1,v2/])
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
   delete([/u1,u2/])

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


   vx = q*u*1000/g
   vy = q*v*1000/g
   vint = sqrt((vx^2)+(vy^2))
   copy_VarMeta(q,vint)
   vxx = qq*uu*1000/g
   vyy = qq*vv*1000/g
   vintt = sqrt((vxx^2)+(vyy^2))
   copy_VarMeta(qq,vintt)
   ; q*u/g*1000→10g/(cm*s*hPa)
   vint_n = vint(time|:,lev|:,{lat|latc},{lon|lonc_1:lonc_2})
   vint_s = vintt(time|:,lev|:,{lat|latd},{lon|lond_1:lond_2})
   vint12=dim_avg_n_Wrap(vint_n,0)
   vint22=dim_avg_n_Wrap(vint_s,0)
   anomvint1=vint12(:,:)-clmvint3(:,:)
   anomvint2=vint22(:,:)-clmvint4(:,:)
   copy_VarCoords(clmvint3(:,:),anomvint1)
   copy_VarCoords(clmvint4(:,:),anomvint2)
   printVarSummary(anomvint1)


   wind = sqrt((v^2)+(u^2))
   copy_VarMeta(q,wind)
   windd = sqrt((vv^2)+(uu^2))
   copy_VarMeta(qq,windd)
   wind_n = wind(time|:,lev|:,{lat|latc},{lon|lonc_1:lonc_2})
   wind_s = windd(time|:,lev|:,{lat|latd},{lon|lond_1:lond_2})
   wind12=dim_avg_n_Wrap(wind_n,0)
   wind22=dim_avg_n_Wrap(wind_s,0)
   anomwind1=wind12(:,:)-clmwind3(:,:)
   anomwind2=wind22(:,:)-clmwind4(:,:)
   copy_VarCoords(clmwind3(:,:),anomwind1)
   copy_VarCoords(clmwind4(:,:),anomwind2)
   printVarSummary(anomwind1)
   printMinMax(anomwind1,0)

;************************************************
            ; open workstation
  plot=new(2,"graphic")
  plotq=new(1,"graphic")
  gsn_define_colormap(wks,"temp_diff_18lev")
   ; gsn_define_colormap(wks,"BlueDarkRed18")
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
   res@lbLabelBarOn           = False  
   res@cnInfoLabelOn          = False  
   res@cnLevelSelectionMode   = "ExplicitLevels" 
   res@cnLevels               = (/-11,-9,-7,-5,-3,-1.2,0,1.2,3,5,7,9,11/)         ;t 
   res@cnFillColors           = (/17,16,15,14,13,12,0,0,10,9,8,7,6,5/)


   resc                        = res 
   resc@tmXBLabelFontHeightF   = 0.026
   resc@tmYLLabelFontHeightF   = 0.026
   resc@tiYAxisString		    = "Pressure(hPa)"
   resc@tiYAxisFontHeightF     = 0.027
   resc@tmXBMode               = "Explicit"
   resc@tmXBValues             = (/100,105,110,115,120,125/)
   resc@tmXBLabels             = (/"100E","105E","110E","115E","120E","125E"/)

   resd                        = res 
   resd@tiYAxisString			 = " "
   resd@tmXBLabelFontHeightF   = 0.026
   resd@tmYLLabelFontHeightF   = 0.026
   resd@tmXBMode               = "Explicit"
   resd@tmXBValues             = (/100,105,110,115,120,125/)
   resd@tmXBLabels             = (/"100E","105E","110E","115E","120E","125E"/)

   res1                       = True              ;z,u 等值线
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
   
   cres                                         = True
   cres@gsnDraw                                 = False
   cres@gsnAddCyclic                            = False
   cres@gsnFrame                                = False
   cres@cnLinesOn                               = True
   cres@cnMonoLineColor                         = False
   cres@cnLineColors						            = (/"tomato2","OrangeRed2","red","red2","red4"/)
   cres@cnLineLabelsOn                          = True
   cres@cnLabelMasking                          = True
   cres@cnLineLabelFontHeightF                  = 0.017                ;等值线标签大小  area
   cres@cnLineLabelInterval                     = 1
   cres@cnLineLabelDensityF                     = 1.25
   cres@cnLineLabelBackgroundColor              = "Transparent"
   cres@cnMonoLineLabelFontColor                = False
   cres@cnLineLabelFontColors                   = (/"tomato2","OrangeRed2","red","red2","red4"/)
   cres@cnInfoLabelOn                           = False
   cres@lbLabelBarOn                            = False
   cres@cnFillOn                                = False
   cres@gsnContourNegLineDashPattern            = 2
   cres@cnLevelSelectionMode                    = "ExplicitLevels"
   cres@cnLevels					                  = (/5,6,7,8,9/)
   cres@cnLineThicknessF                        = 2.5


   cres2                                         = True
   cres2@gsnDraw                                 = False
   cres2@gsnAddCyclic                            = False
   cres2@gsnFrame                                = False
   cres2@cnLinesOn                               = True
   cres2@cnMonoLineColor                         = False
   cres2@cnLineColors						          = (/"salmon2","DarkOrange2","coral1","tomato2","OrangeRed2"/)
   cres2@cnLineLabelsOn                          = True
   cres2@cnLabelMasking                          = True
   cres2@cnLineLabelFontHeightF                  = 0.017                ;等值线标签大小  area
   cres2@cnLineLabelInterval                     = 1
   cres2@cnLineLabelDensityF                     = 1.1
   cres2@cnLineLabelBackgroundColor              = "Transparent"
   cres2@cnMonoLineLabelFontColor                = False
   cres2@cnLineLabelFontColors                   = (/"salmon2","DarkOrange2","coral1","tomato2","OrangeRed2"/)
   cres2@cnInfoLabelOn                           = False
   cres2@lbLabelBarOn                            = False
   cres2@cnFillOn                                = False
   cres2@gsnContourNegLineDashPattern            = 2
   cres2@cnLevelSelectionMode                    = "ExplicitLevels"
   cres2@cnLevels					                   = (/2,3,4,5,6/)
   cres2@cnLineThicknessF                        = 3


; ===========================a
   res@tmYLLabelsOn           = True
   resc@gsnLeftString        = "(e) Type1 plane CD"
   resc@gsnLeftStringFontHeightF = 0.021
   wrf_smooth_2d(anomvint1,1)
   wrf_smooth_2d(anomvint2,1)
   plot(0) = gsn_csm_pres_hgt(wks, anomvint1(11:,:) , resc)
   wrf_smooth_2d(anomwind1,1)
   wrf_smooth_2d(anomwind2,1)
   plotq=gsn_csm_pres_hgt(wks,anomwind1(11:,:),cres)
   overlay(plot(0),plotq) 
; ===========================b
   
   ;res@tmYLLabelsOn           = False
   resd@gsnLeftString        = "(f) Type2 plane CD"
   resd@gsnLeftStringFontHeightF = 0.021
   plot(1) = gsn_csm_pres_hgt(wks, anomvint2(11:,:) , resd)
   plotq=gsn_csm_pres_hgt(wks,anomwind2(11:,:),cres2)
   overlay(plot(1),plotq) 

;---Panel all four plots
  resP                       = True                            ; panel mods desired
  resP@gsnMaximize           = True                            ; fill up the page
  resP@gsnPanelLabelBar      = True
  resP@lbOrientation		     = "vertical"
  resP@lbLabelStride         = 2
  resP@lbLabelFontHeightF    = 0.016
  resP@gsnPanelYWhiteSpacePercent = 1
  resP@gsnPanelXWhiteSpacePercent = 0
  gsn_panel(wks,plot,(/1,2/),resP)  
end