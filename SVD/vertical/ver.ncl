begin
 
 lona_1 = 110        ; lat 25-55
 lona_2 = 120
 lata_1 = 20
 lata_2 = 46

 lonb_1 = 108
 lonb_2 = 112
 latb_1 = 20
 latb_2 = 46

 latc = 40
 lonc_1 = 100
 lonc_2 = 130

 latd = 28
 lond_1 = 100
 lond_2 = 130

 wks   = gsn_open_wks ("pdf", "ver" )

 b= addfile("6h/svd11.nc","r")                                 ; open netcdf file
 bb= addfile("6h/svd22.nc","r")                                 ; open netcdf file

;************************************************
   a= addfile("/data/home/liyan/wangqy/ccr/SVD/427/vertical/123/climate.nc","r")                                 ; open netcdf file
   
   t_temp = a->t(:,:,::-1,:)
   t11= t_temp(:,:,{lata_1:lata_2},{lona_1:lona_2})                       ; lat:25-55
   t1=short2flt(t11)
   clmt12=dim_avg_n_Wrap(t1,0)-273.15
   clmt1=dim_avg_n_Wrap(clmt12,2)
   clmt11 = clmt1 ; light local smoothing
   copy_VarCoords(t1(0,:,:,0),clmt11)

   z_temp = a->z(:,:,::-1,:)
   z11= z_temp(:,:,{lata_1:lata_2},{lona_1:lona_2})                                                ; read in variable
   z1=short2flt(z11)
   clmz12=dim_avg_n_Wrap(z1,0)/98
   clmz1=dim_avg_n_Wrap(clmz12,2)
   clmz11 = clmz1 ; light local smoothing
   copy_VarCoords(t1(0,:,:,0),clmz11)

   u_temp = a->u(:,:,::-1,:)
   u11= u_temp(:,:,{lata_1:lata_2},{lona_1:lona_2})                                         ; read in variable
   u1=short2flt(u11)
   clmu12=dim_avg_n_Wrap(u1,0)
   clmu1=dim_avg_n_Wrap(clmu12,2)
   copy_VarCoords(t1(0,:,:,0),clmu1)

   v_temp = a->v(:,:,::-1,:)
   v11= v_temp(:,:,{lata_1:lata_2},{lona_1:lona_2})                                         ; read in variable
   v1=short2flt(v11)
   clmv12=dim_avg_n_Wrap(v1,0)
   clmv1=dim_avg_n_Wrap(clmv12,2)
   copy_VarCoords(v1(0,:,:,0),clmv1)

   w_temp = a->w(:,:,::-1,:)
   w11= w_temp(:,:,{lata_1:lata_2},{lona_1:lona_2})                                         ; read in variable
   w1=short2flt(w11)
   clmw12=dim_avg_n_Wrap(w1,0)*-10
   clmw1=dim_avg_n_Wrap(clmw12,2)
   copy_VarCoords(w1(0,:,:,0),clmw1)

   q_temp = a->q(:,:,::-1,:)
   q11= q_temp(:,:,{lata_1:lata_2},{lona_1:lona_2})                                         ; read in variable
   q1=short2flt(q11)
   clmq12=dim_avg_n_Wrap(q1,0)*1000
   clmq13=dim_avg_n_Wrap(clmq12,2)
   copy_VarCoords(q1(0,:,:,0),clmq13)
    ;-------------------------------------

   t21= t_temp(:,:,{latb_1:latb_2},{lonb_1:lonb_2})                       ;lat:25-55
   t2=short2flt(t21)
   clmt22=dim_avg_n_Wrap(t2,0)-273.15
   clmt2=dim_avg_n_Wrap(clmt22,2)
   clmt21 = clmt2 ; light local smoothing
   copy_VarCoords(t2(0,:,:,0),clmt21)

   z21= z_temp(:,:,{latb_1:latb_2},{lonb_1:lonb_2})                                                ; read in variable
   z2=short2flt(z21)
   clmz22=dim_avg_n_Wrap(z2,0)/98
   clmz2=dim_avg_n_Wrap(clmz22,2)
   clmz21 = clmz2 ; light local smoothing
   copy_VarCoords(t2(0,:,:,0),clmz21)

   u21= u_temp(:,:,{latb_1:latb_2},{lonb_1:lonb_2})                                         ; read in variable
   u2=short2flt(u21)
   clmu22=dim_avg_n_Wrap(u2,0)
   clmu2=dim_avg_n_Wrap(clmu22,2)
   copy_VarCoords(t2(0,:,:,0),clmu2)

   v21= v_temp(:,:,{latb_1:latb_2},{lonb_1:lonb_2})                                         ; read in variable
   v2=short2flt(v21)
   clmv22=dim_avg_n_Wrap(v2,0)
   clmv2=dim_avg_n_Wrap(clmv22,2)
   copy_VarCoords(v2(0,:,:,0),clmv2)

   w21= w_temp(:,:,{latb_1:latb_2},{lonb_1:lonb_2})                                         ; read in variable
   w2=short2flt(w21)
   clmw22=dim_avg_n_Wrap(w2,0)*-10
   clmw2=dim_avg_n_Wrap(clmw22,2)
   copy_VarCoords(w2(0,:,:,0),clmw2)

   q21= q_temp(:,:,{latb_1:latb_2},{lonb_1:lonb_2})                                         ; read in variable
   q2=short2flt(q21)
   clmq22=dim_avg_n_Wrap(q2,0)*1000
   clmq23=dim_avg_n_Wrap(clmq22,2)
   copy_VarCoords(q2(0,:,:,0),clmq23)
   ;------------------------------------
   t31= t_temp(:,:,{latc},{lonc_1:lonc_2})                                        
   t3=short2flt(t31)
   clmt3=dim_avg_n_Wrap(t3,0)-273.15
   clmt31 = clmt3 ; light local smoothing
   copy_VarCoords(t3(0,:,:),clmt3)
   copy_VarCoords(t3(0,:,:),clmt31)

   z31= z_temp(:,:,{latc},{lonc_1:lonc_2})                                                ; read in variable
   z3=short2flt(z31)
   clmz3=dim_avg_n_Wrap(z3,0)/98
   clmz31 = clmz3 ; light local smoothing
   copy_VarCoords(t3(0,:,:),clmz31)

   u31= u_temp(:,:,{latc},{lonc_1:lonc_2})                                         ; read in variable
   u3=short2flt(u31)
   clmu3=dim_avg_n_Wrap(u3,0)
   copy_VarCoords(t3(0,:,:),clmu3)

   v31= v_temp(:,:,{latc},{lonc_1:lonc_2})                                         ; read in variable
   v3=short2flt(v31)
   clmv3=dim_avg_n_Wrap(v3,0)
   copy_VarCoords(v3(0,:,:),clmv3)

   w31= w_temp(:,:,{latc},{lonc_1:lonc_2})                                         ; read in variable
   w3=short2flt(w31)
   clmw3=dim_avg_n_Wrap(w3,0)*-10
   copy_VarCoords(w3(0,:,:),clmw3)

   q31= q_temp(:,:,{latc},{lonc_1:lonc_2})                                         ; read in variable
   q3=short2flt(q31)
   clmq33=dim_avg_n_Wrap(q3,0)*1000
   copy_VarCoords(q3(0,:,:),clmq33)
 ;--------------------------------------------------
   t41= t_temp(:,:,{latd},{lond_1:lond_2})                                         ; read in variable 38
   t4=short2flt(t41)
   clmt4=dim_avg_n_Wrap(t4,0)-273.15
   clmt41 = clmt4 ; light local smoothing
   copy_VarCoords(t4(0,:,:),clmt4)
   copy_VarCoords(t4(0,:,:),clmt41)

   z41= z_temp(:,:,{latd},{lond_1:lond_2})                                                ; read in variable
   z4=short2flt(z41)
   clmz4=dim_avg_n_Wrap(z4,0)/98
   clmz41 = clmz4 ; light local smoothing
   copy_VarCoords(t4(0,:,:),clmz41)

   u41= u_temp(:,:,{latd},{lond_1:lond_2})                                         ; read in variable
   u4=short2flt(u41)
   clmu4=dim_avg_n_Wrap(u4,0)
   copy_VarCoords(t4(0,:,:),clmu4)

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
   clmq43=dim_avg_n_Wrap(q4,0)*1000
   copy_VarCoords(q4(0,:,:),clmq43)

   delete(a)
   delete([/t_temp,u_temp,v_temp,z_temp,w_temp,q_temp/]) 
   delete([/t11,t21,t31,t41,t1,t2,t3,t4,z11,z21,z31,z41,z1,z2,z3,z4,v11,v21,v31,v41,v1,v2,v3,v4/])
   delete([/u11,u21,u31,u41,u1,u2,u3,u4,q11,q21,q31,q41,q1,q2,q3,q4,w11,w21,w31,w41,w1,w2,w3,w4/])
; ===========================t

   t = b->t                                                ; read in variable
   tt = bb->t
   t!0   = "time"
   t!1   = "lev"
   t!2   = "lat"
   t!3   = "lon"
   tt!0   = "time"
   tt!1   = "lev"
   tt!2   = "lat"
   tt!3   = "lon"
   t1warm=t(time|:,lev|:,{lat|latc},{lon|lonc_1:lonc_2})
   t1cold=tt(time|:,lev|:,{lat|latd},{lon|lond_1:lond_2})
   t2warm=t(time|:,lev|:,{lat|lata_1:lata_2},{lon|lona_1:lona_2})
   t2cold=tt(time|:,lev|:,{lat|latb_1:latb_2},{lon|lonb_1:lonb_2})
   t1=dim_avg_n_Wrap(t1warm,0)-273.15 
   t2=dim_avg_n_Wrap(t1cold,0)-273.15 
   t3=dim_avg_n_Wrap(t2warm,0)-273.15
   t4=dim_avg_n_Wrap(t2cold,0)-273.15 
   t31=dim_avg_n_Wrap(t3,2)
   t41=dim_avg_n_Wrap(t4,2)
   t12 = t1 
   t22 = t2 
   t32 = t31 
   t42 = t41 

   anomt1=t12(:,:)-clmt31(:,:)
   anomt2=t22(:,:)-clmt41(:,:)
   anomt3=t32(:,:)-clmt11(:,:)
   anomt4=t42(:,:)-clmt21(:,:)
   copy_VarCoords(clmt31(:,:),anomt1)
   copy_VarCoords(clmt41(:,:),anomt2)
   copy_VarCoords(clmt11(:,:),anomt3)
   copy_VarCoords(clmt21(:,:),anomt4)
   wrf_smooth_2d(anomt1,3)
   wrf_smooth_2d(anomt2,3)
   wrf_smooth_2d(anomt3,3)
   wrf_smooth_2d(anomt4,3)

   delete([/t,tt,t1,t2,t3,t4,t31,t41/])
; ===========================2                              ; open netcdf file
   v = b->v                                                ; read in variable
   vv = bb->v
   v!0   = "time"
   v!1   = "lev"
   v!2   = "lat"
   v!3   = "lon"
   vv!0   = "time"
   vv!1   = "lev"
   vv!2   = "lat"
   vv!3   = "lon"
   v1warm=v(time|:,lev|:,{lat|latc},{lon|lonc_1:lonc_2})
   v1cold=vv(time|:,lev|:,{lat|latd},{lon|lond_1:lond_2})
   v2warm=v(time|:,lev|:,{lat|lata_1:lata_2},{lon|lona_1:lona_2})
   v2cold=vv(time|:,lev|:,{lat|latb_1:latb_2},{lon|lonb_1:lonb_2})
   v1=dim_avg_n_Wrap(v1warm,0)
   v2=dim_avg_n_Wrap(v1cold,0)
   v3=dim_avg_n_Wrap(v2warm,0)
   v4=dim_avg_n_Wrap(v2cold,0)
   v31=dim_avg_n_Wrap(v3,2)
   v41=dim_avg_n_Wrap(v4,2)

   anomv1=v1(:,:)-clmv3(:,:)
   anomv2=v2(:,:)-clmv4(:,:)
   anomv3=v31(:,:)-clmv1(:,:)
   anomv4=v41(:,:)-clmv2(:,:)
   copy_VarCoords(clmv3(:,:),anomv1)
   copy_VarCoords(clmv4(:,:),anomv2)
   copy_VarCoords(clmv1(:,:),anomv3)
   copy_VarCoords(clmv2(:,:),anomv4)
   delete([/v,vv,v1,v2,v3,v4,v31,v41/])
; ===========================3                              ; open netcdf file
   u = b->u                                               ; read in variable
   uu = bb->u
   u!0   = "time"
   u!1   = "lev"
   u!2   = "lat"
   u!3   = "lon"
   uu!0   = "time"
   uu!1   = "lev"
   uu!2   = "lat"
   uu!3   = "lon"
   u1warm=u(time|:,lev|:,{lat|latc},{lon|lonc_1:lonc_2})
   u1cold=uu(time|:,lev|:,{lat|latd},{lon|lond_1:lond_2})
   u2warm=u(time|:,lev|:,{lat|lata_1:lata_2},{lon|lona_1:lona_2})
   u2cold=uu(time|:,lev|:,{lat|latb_1:latb_2},{lon|lonb_1:lonb_2})
   u1=dim_avg_n_Wrap(u1warm,0)
   u2=dim_avg_n_Wrap(u1cold,0)
   u3=dim_avg_n_Wrap(u2warm,0)
   u4=dim_avg_n_Wrap(u2cold,0)
   u31=dim_avg_n_Wrap(u3,2)
   u41=dim_avg_n_Wrap(u4,2)

   anomu1=u1(:,:)-clmu3(:,:)
   anomu2=u2(:,:)-clmu4(:,:)
   anomu3=u31(:,:)-clmu1(:,:)
   anomu4=u41(:,:)-clmu2(:,:)
   copy_VarCoords(clmu3(:,:),anomu1)
   copy_VarCoords(clmu4(:,:),anomu2)
   copy_VarCoords(clmu1(:,:),anomu3)
   copy_VarCoords(clmu2(:,:),anomu4)
   delete([/u,uu,u1,u2,u3,u4,u31,u41/])
; ===========================4                            ; open netcdf file
   w = b->w                                                ; read in variable
   ww = bb->w
   w!0   = "time"
   w!1   = "lev"
   w!2   = "lat"
   w!3   = "lon"
   ww!0   = "time"
   ww!1   = "lev"
   ww!2   = "lat"
   ww!3   = "lon"
   w1warm=w(time|:,lev|:,{lat|latc},{lon|lonc_1:lonc_2})
   w1cold=ww(time|:,lev|:,{lat|latd},{lon|lond_1:lond_2})
   w2warm=w(time|:,lev|:,{lat|lata_1:lata_2},{lon|lona_1:lona_2})
   w2cold=ww(time|:,lev|:,{lat|latb_1:latb_2},{lon|lonb_1:lonb_2})
   w1=dim_avg_n_Wrap(w1warm,0)*-10
   w2=dim_avg_n_Wrap(w1cold,0)*-10
   w3=dim_avg_n_Wrap(w2warm,0)*-10
   w4=dim_avg_n_Wrap(w2cold,0)*-10
   w31=dim_avg_n_Wrap(w3,2)
   w41=dim_avg_n_Wrap(w4,2)

   anomw1=w1(:,:)-clmw3(:,:)
   anomw2=w2(:,:)-clmw4(:,:)
   anomw3=w31(:,:)-clmw1(:,:)
   anomw4=w41(:,:)-clmw2(:,:)
   copy_VarCoords(clmw3(:,:),anomw1)
   copy_VarCoords(clmw4(:,:),anomw2)
   copy_VarCoords(clmw1(:,:),anomw3)
   copy_VarCoords(clmw2(:,:),anomw4)
   delete([/w,ww,w1,w2,w3,w4,w31,w41/])
; ===========================5                               ; open netcdf file
   q = b->q(:,:,:,:)                                               ; read in variable
   qq = bb->q(:,:,:,:) 
   q!0   = "time"
   q!1   = "lev"
   q!2   = "lat"
   q!3   = "lon"
   qq!0   = "time"
   qq!1   = "lev"
   qq!2   = "lat"
   qq!3   = "lon"
   q1warm=q(time|:,lev|:,{lat|latc},{lon|lonc_1:lonc_2})
   q1cold=qq(time|:,lev|:,{lat|latd},{lon|lond_1:lond_2})
   q2warm=q(time|:,lev|:,{lat|lata_1:lata_2},{lon|lona_1:lona_2})
   q2cold=qq(time|:,lev|:,{lat|latb_1:latb_2},{lon|lonb_1:lonb_2})
   q12=dim_avg_n_Wrap(q1warm,0)*1000
   q22=dim_avg_n_Wrap(q1cold,0)*1000
   q32=dim_avg_n_Wrap(q2warm,0)*1000
   q42=dim_avg_n_Wrap(q2cold,0)*1000
   q33=dim_avg_n_Wrap(q32,2)
   q43=dim_avg_n_Wrap(q42,2)

   anomq1=q12(:,:)-clmq33(:,:)
   anomq2=q22(:,:)-clmq43(:,:)
   anomq3=q33(:,:)-clmq13(:,:)
   anomq4=q43(:,:)-clmq23(:,:)
   copy_VarCoords(clmq33(:,:),anomq1)
   copy_VarCoords(clmq43(:,:),anomq2)
   copy_VarCoords(clmq13(:,:),anomq3)
   copy_VarCoords(clmq23(:,:),anomq4)
   delete([/q,qq/])
; ===========================6                             ; open netcdf file
   z = b->z                                                ; read in variable
   zz = bb->z
   z!0   = "time"
   z!1   = "lev"
   z!2   = "lat"
   z!3   = "lon"
   zz!0   = "time"
   zz!1   = "lev"
   zz!2   = "lat"
   zz!3   = "lon"
   z1warm=z(time|:,lev|:,{lat|latc},{lon|lonc_1:lonc_2})
   z1cold=zz(time|:,lev|:,{lat|latd},{lon|lond_1:lond_2})
   z2warm=z(time|:,lev|:,{lat|lata_1:lata_2},{lon|lona_1:lona_2})
   z2cold=zz(time|:,lev|:,{lat|latb_1:latb_2},{lon|lonb_1:lonb_2})
   z1=dim_avg_n_Wrap(z1warm,0)/98
   z2=dim_avg_n_Wrap(z1cold,0)/98
   z3=dim_avg_n_Wrap(z2warm,0)/98
   z4=dim_avg_n_Wrap(z2cold,0)/98 
   z31=dim_avg_n_Wrap(z3,2)
   z41=dim_avg_n_Wrap(z4,2)
   z12 = z1
   z22 = z2 
   z32 = z31 
   z42 = z41


   anomz1=z12(:,:)-clmz31(:,:)
   anomz2=z22(:,:)-clmz41(:,:)
   anomz3=z32(:,:)-clmz11(:,:)
   anomz4=z42(:,:)-clmz21(:,:)
   copy_VarCoords(clmz31(:,:),anomz1)
   copy_VarCoords(clmz41(:,:),anomz2)
   copy_VarCoords(clmz11(:,:),anomz3)
   copy_VarCoords(clmz21(:,:),anomz4)

   wrf_smooth_2d(anomz1,3)
   wrf_smooth_2d(anomz2,3)
   wrf_smooth_2d(anomz3,3)
   wrf_smooth_2d(anomz4,3)

   delete([/b,bb,z,zz,z1,z2,z3,z4,z31,z41,z12,z22,z32,z42/])
;************************************************
            ; open workstation
  plot=new(4,"graphic")
  plotz=new(1,"graphic")
  plotq=new(1,"graphic")
  
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
   res@cnFillPalette          = "BlueWhiteOrangeRed"             
   res@lbLabelBarOn           = False  
   res@cnInfoLabelOn          = False  
   res@cnLevelSelectionMode   = "ExplicitLevels" 
   res@cnLevels               = (/-5,-4,-3,-2,-1,0,1,2,3,4,5/)         ;t 
   res@cnFillColors           = (/40,50,60,70,78,90,145,152,165,178,194,210/)

   res@vcRefAnnoZone          = 0  
   res@vcRefAnnoOrthogonalPosF = -0.5            
   res@vcRefAnnoParallelPosF  = 0.6
   res@vcRefAnnoBackgroundColor = -1
   res@vcRefAnnoPerimOn       = False
   res@vcRefMagnitudeF        = 6          
   res@vcRefLengthF           = 0.035       
   res@vcLineArrowThicknessF  = 2.5
   res@vcMinDistanceF         = 0.06       
   ;res@vcMapDirection         = False
   res@vcGlyphStyle           = "LineArrow"       
   res@vcMinDistanceF         = 0.035             
   res@vcRefAnnoFontHeightF   = 0.03
   res@vcRefAnnoString2On     = False

   resa                        = res 
   resa@tmXBLabelFontHeightF   = 0.0305
   resa@tmYLLabelFontHeightF   = 0.0305
   resa@tiYAxisString		    = "Pressure(hPa)"
   resa@tmXBMode               = "Explicit"
   resa@tmXBValues             = (/20,25,30,35,40,45/)
   resa@tmXBLabels             = (/" ","25N"," ","35N"," ","45N"/)
   
   resb                        = res 
   resb@tmXBLabelFontHeightF   = 0.0305
   resb@tmYLLabelFontHeightF   = 0.0305
   resb@tiYAxisString			 = " "
   resb@tmXbBMode               = "Explicit"
   resb@tmXBValues             = (/20,25,30,35,40,45/)
   resb@tmXBLabels             = (/" ","25N"," ","35N"," ","45N"/)

   resc                        = res 
   resc@tmXBLabelFontHeightF   = 0.0375
   resc@tmYLLabelFontHeightF   = 0.0375
   resc@tiYAxisString		    = "Pressure(hPa)"
   resc@tmXBMode               = "Explicit"
   resc@tmXBValues             = (/100,105,110,115,120,125,130/)
   resc@tmXBLabels             = (/" ","105E"," ","115E"," ","125E"," "/)

   resd                        = res 
   resd@tiYAxisString			 = " "
   resd@tmXBLabelFontHeightF   = 0.0375
   resd@tmYLLabelFontHeightF   = 0.0375
   resd@tmXBMode               = "Explicit"
   resd@tmXBValues             = (/100,105,110,115,120,125,130/)
   resd@tmXBLabels             = (/" ","105E"," ","115E"," ","125E"," "/)

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
   res@cnLineLabelInterval           = 1
   res@cnLineLabelDensityF           = 0.60
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

   res11                      = res1  ;c
   res11@cnLineColor		      = "gray40"
   res11@cnLineLabelFontColor = "gray40"
   res11@cnLevels             = (/-7,-5,-3,-1,0,1,3,5,7,9,11,13,15,17,19,21/)
   res11@gsnLeftStringFontHeightF = 0.03
   res11@gsnLeftStringOrthogonalPosF = 0.0

   res12                      = res1  ;d
   res12@cnLineColor		      = "gray40"
   res12@cnLineLabelFontColor = "gray40"
   res12@cnLevels             = (/-3,-1,0,1,3,5,7,9,11,13,15,17,19,21/)
   res12@gsnLeftStringFontHeightF = 0.03
   res12@gsnLeftStringOrthogonalPosF = 0.0                 ;0.021


   res13                      = res1 ;a
   res13@cnLineColor		      = "gray40"
   res13@cnLineLabelFontColor = "gray40"
   res13@cnLevels             = (/-7,-5,-3,-1,0,1,3,5,7,9,11,13,15,17,19,21/)
   res13@gsnLeftStringFontHeightF = 0.03
   res13@gsnLeftStringOrthogonalPosF = 0.0

   res14                      = res1  ;b
   res14@cnLineColor		      = "gray40"
   res14@cnLineLabelFontColor = "gray40"
   res14@cnLevels             = (/-3,-1,0,1,3,5,7,9,11,13,15,17,19,21/)
   res14@gsnLeftStringFontHeightF = 0.03
   res14@gsnLeftStringOrthogonalPosF = 0.0                   ;0.021


; ===========================a
   res@tmYLLabelsOn           = True
   res11@gsnLeftString        = "(c) Type1 "
   plot(2) = gsn_csm_pres_hgt_vector(wks, anomt1(10:,:) , anomu1(10:,:), anomw1(10:,:) , resc)
   plotz=gsn_csm_pres_hgt(wks,anomz1(10:,:),res11)
   overlay(plot(2),plotz) 

   plotq=gsn_csm_pres_hgt(wks,anomq1(:,:),res2)
   overlay(plot(2),plotq) 
; ===========================b
   
   ;res@tmYLLabelsOn           = False
   res12@gsnLeftString        = "(d) Type2 "
   anomt2(10:,:) = anomt2(10:,:) - 0.2
   anomz2(10:,:) = anomz2(10:,:) - 0.4
   plot(3) = gsn_csm_pres_hgt_vector(wks, anomt2(10:,:) , anomu2(10:,:), anomw2(10:,:) , resd)
   plotz=gsn_csm_pres_hgt(wks,anomz2(10:,:),res12)
   overlay(plot(3),plotz) 
   plotq=gsn_csm_pres_hgt(wks,anomq2(:,:),res2)
   overlay(plot(3),plotq) 
; ===========================c
   res@tmYLLabelsOn           = True
   res13@gsnLeftString        = "(a) Type1 "
   plot(0) = gsn_csm_pres_hgt_vector(wks, anomt3(10:,:) , anomv3(10:,:), anomw3(10:,:) , resa)
   plotz=gsn_csm_pres_hgt(wks,anomz3(10:,:),res13)
   overlay(plot(0),plotz) 
   plotq=gsn_csm_pres_hgt(wks,anomq3(:,:),res2)
   overlay(plot(0),plotq) 
; ===========================d
   ; res@tmYLLabelsOn          = False
   res14@gsnLeftString        = "(b) Type2  "
   plot(1) = gsn_csm_pres_hgt_vector(wks, anomt4(10:,:) , anomv4(10:,:), anomw4(10:,:) , resb)
   plotz=gsn_csm_pres_hgt(wks,anomz4(10:,:),res14)
   overlay(plot(1),plotz) 
   ;plotq=gsn_csm_pres_hgt(wks,anomq4(10:,:),res2)
   plotq=gsn_csm_pres_hgt(wks,anomq4(:,:),res2)
   overlay(plot(1),plotq) 

;---Panel all four plots
  resP                       = True                            ; panel mods desired
  resP@gsnMaximize           = True                            ; fill up the page
  resP@gsnPanelLabelBar      = True
  resP@lbOrientation		     = "vertical"
  resP@lbLabelStride         = 2
  resP@lbLabelFontHeightF    = 0.018
  resP@gsnPanelYWhiteSpacePercent = 1
  resP@gsnPanelXWhiteSpacePercent = 0
  gsn_panel(wks,plot,(/2,2/),resP)  
end