begin

wksname = "traj_1_850-700"
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

ff = addfile("../kmeans/cluster/type1_l2_1_152.nc","r")

k1_lat = ff->lat                           ;;
k1_lon = ff->lon
k1_rh = ff->rh
delete(ff)
printVarSummary(k1_lat)	    

ff = addfile("../kmeans/cluster/type1_l2_2_48.nc","r")

k2_lat = ff->lat                           ;
k2_lon = ff->lon
k2_rh = ff->rh
delete(ff)
printVarSummary(k2_lat)	

ff = addfile("../kmeans/cluster/type1_l2_3_212.nc","r")

k3_lat = ff->lat                         
k3_lon = ff->lon
k3_rh = ff->rh
delete(ff)
printVarSummary(k3_lat)	

;

printVarSummary(k1_rh)
printVarSummary(k2_rh)
printVarSummary(k3_rh)

r1 = dim_avg_n_Wrap(k1_rh(:,0),0)          
r11 = dim_avg_n_Wrap(k1_rh(:,79),0) 
print(r1)
print(r11)
print(r1-r11)

r2 = dim_avg_n_Wrap(k2_rh(:,0),0)               
r22 = dim_avg_n_Wrap(k2_rh(:,79),0) 
print(r2)
print(r22)
print(r2-r22)

r3 = dim_avg_n_Wrap(k3_rh(:,0),0)               
r33 = dim_avg_n_Wrap(k3_rh(:,79),0) 
print(r3)
print(r33)
print(r3-r33)


; exit()

;

a1 = 152
a2 = 48
a3 = 212

rh1 = dim_avg_n_Wrap(k1_rh,0)
rh11 = dim_avg_n_Wrap(rh1,0)
rh2 = dim_avg_n_Wrap(k2_rh,0)
rh22 = dim_avg_n_Wrap(rh2,0)
rh3 = dim_avg_n_Wrap(k3_rh,0)
rh33 = dim_avg_n_Wrap(rh3,0)
print(rh11)
print(rh22)
print(rh33)
c1_lat = dim_avg_n_Wrap(k1_lat,0)
c1_lon = dim_avg_n_Wrap(k1_lon,0)
c2_lat = dim_avg_n_Wrap(k2_lat,0)
c2_lon = dim_avg_n_Wrap(k2_lon,0)
c3_lat = dim_avg_n_Wrap(k3_lat,0)
c3_lon = dim_avg_n_Wrap(k3_lon,0)
printVarSummary(c1_lat)

;--------------------------------------plot--------------------------------------------
wks_type = "pdf"
wks=gsn_open_wks(wks_type,wksname)
gsn_define_colormap(wks,"GMT_wysiwygcont")

;-----------------------------------------map------------------------------------------
res = True
res@gsnDraw = False
res@gsnFrame = False
res@vpWidthF = 0.5           ; change aspect ratio of plot
res@vpHeightF = 0.3
res@gsnMaximize = True          ; maximize plot size
res@trLineInterpolationOn = True
res@pmLabelBarKeepAspect                      = True
;--------坐标
res@tmXBTickSpacingF = 10                      
res@tmYLTickSpacingF = 10             
res@tmXUseBottom = False
res@tmYUseLeft = False
res@tmXTOn = True
res@tmYROn = True
res@tmXBLabelFontHeightF = 0.014                  
res@tmYLLabelFontHeightF = 0.014
res@tmXBLabelDeltaF   = -0.5
res@tmYLLabelDeltaF   = -0.5
res@tmXTLabelDaltaF   = -0.5
res@tmYRLabelDeltaF   = -0.5  
res@mpMaxLatF = 45                          
res@mpMinLatF = 20 
res@mpMaxLonF = 130
res@mpMinLonF	= 95 
res@tmXBMode = "Explicit"
res@tmXBValues = (/100,110,120,130,140,150/)
res@tmXBLabels = (/"100E","110E","120E","130E","140E","150E"/)
res@tmYLMode = "Explicit"
res@tmYLValues = (/10,20,30,40,50/)
res@tmYLLabels = (/"10N","20N","30N","40N","50N"/)
res@gsnMinorLonSpacing = 5
res@gsnMinorLatSpacing = 5 
;---------地图
res@mpDataSetName  = "/data/home/liyan/wangqy/ccr/SVD/177/circulation/NCL-Chinamap/database/Earth..4"
res@mpDataBaseVersion = "MediumRes" ; or "Ncarg4_1"
res@mpAreaMaskingOn = True
res@mpMaskAreaSpecifiers = (/"China"/)
res@mpOutlineSpecifiers = (/"China","China:Provinces"/)
res@mpLandFillColor	= 0
res@mpOutlineOn	= True
res@mpDataResolution = "Fine"
res@gsnLeftString = "(a) Type1 850-700 hPa" 
res@gsnRightString = "51%    37%   12%" 
res@gsnLeftStringOrthogonalPosF = 0.04
res@gsnLeftStringFontHeightF    = 0.015
res@gsnRightStringFontHeightF    = 0.014
res@gsnDraw	= False
res@gsnFrame = False
map = gsn_csm_map(wks,res)
;-----------------------------------------path-----------------------------------
pres = True                   
pres@gsLineThicknessF = 1.5
pres@gsLineDashPattern = 0
pres@lbLabelBarOn = True
pres@lbOrientation = "vertical"
colors = (/120,123,125,127,129,131,133,136,138,140,142,144,146,148,150,152,154,156,158,160/)

k1_lon = runave_n(k1_lon,3,0,1)
k1_lat = runave_n(k1_lat,3,0,1)
k1_rh = runave_n(k1_rh,3,0,1)

k2_lon = runave_n(k2_lon,3,0,1)
k2_lat = runave_n(k2_lat,3,0,1)
k2_rh = runave_n(k2_rh,3,0,1)

;-------------------------
; i = 110
; j = 0
do i = 0,a1-1                 ;0,tu-1
    do j = 2,72
        xx = (/k1_lon(i,j),k1_lon(i,j+1)/)
        yy = (/k1_lat(i,j),k1_lat(i,j+1)/)
            if ((k1_rh(i,j).gt.0).and.(k1_rh(i,j).le.50)) then
                pres@gsLineColor = colors(0)
            end if 
            if ((k1_rh(i,j).gt.50).and.(k1_rh(i,j).le.52.5)) then
                pres@gsLineColor = colors(1)
            end if
            if ((k1_rh(i,j).gt.52.5).and.(k1_rh(i,j).le.55)) then
                pres@gsLineColor = colors(2)
            end if
            if ((k1_rh(i,j).gt.55).and.(k1_rh(i,j).le.57.5)) then
                pres@gsLineColor = colors(3)
            end if
            if ((k1_rh(i,j).gt.57.5).and.(k1_rh(i,j).le.60)) then
                pres@gsLineColor = colors(4)
            end if
            if ((k1_rh(i,j).gt.60).and.(k1_rh(i,j).le.62.5)) then
                pres@gsLineColor = colors(5)
            end if
            if ((k1_rh(i,j).gt.62.5).and.(k1_rh(i,j).le.65)) then
                pres@gsLineColor = colors(6)
             end if
            if ((k1_rh(i,j).gt.65).and.(k1_rh(i,j).le.67.5)) then
                pres@gsLineColor = colors(7)
            end if
            if ((k1_rh(i,j).gt.67.5).and.(k1_rh(i,j).le.70)) then
                pres@gsLineColor = colors(8)
            end if 
            if ((k1_rh(i,j).gt.70).and.(k1_rh(i,j).le.72.5)) then
                pres@gsLineColor = colors(9)
            end if
            if ((k1_rh(i,j).gt.72.5).and.(k1_rh(i,j).le.75)) then
                pres@gsLineColor = colors(10)
            end if
            if ((k1_rh(i,j).gt.75).and.(k1_rh(i,j).le.77.5)) then
                pres@gsLineColor = colors(11)
            end if
            if ((k1_rh(i,j).gt.77.5).and.(k1_rh(i,j).le.80)) then
                pres@gsLineColor = colors(12)
            end if
            if ((k1_rh(i,j).gt.80).and.(k1_rh(i,j).le.82.5)) then
                pres@gsLineColor = colors(13)
            end if
            if ((k1_rh(i,j).gt.82.5).and.(k1_rh(i,j).le.85)) then
                pres@gsLineColor = colors(14)
             end if
            if ((k1_rh(i,j).gt.85).and.(k1_rh(i,j).le.87.5)) then
                pres@gsLineColor = colors(15)
            end if 
            if ((k1_rh(i,j).gt.87.5).and.(k1_rh(i,j).le.90)) then
                pres@gsLineColor = colors(16)
            end if
            if ((k1_rh(i,j).gt.90).and.(k1_rh(i,j).le.92.5)) then
                pres@gsLineColor = colors(17)
            end if
            if ((k1_rh(i,j).gt.92.5).and.(k1_rh(i,j).le.95)) then
                pres@gsLineColor = colors(18)
            end if
            if (k1_rh(i,j).gt.95) then
                pres@gsLineColor = colors(19)
            end if
            str = unique_string("string")
            map@$str$ = gsn_add_polyline(wks, map, xx, yy, pres)
    end do 
end do


do i = 0,a2-1                 ;0,tu-1
    do j = 2,72
        xx = (/k2_lon(i,j),k2_lon(i,j+1)/)
        yy = (/k2_lat(i,j),k2_lat(i,j+1)/)
            if ((k2_rh(i,j).gt.0).and.(k2_rh(i,j).le.50)) then
                pres@gsLineColor = colors(0)
            end if 
            if ((k2_rh(i,j).gt.50).and.(k2_rh(i,j).le.52.5)) then
                pres@gsLineColor = colors(1)
            end if
            if ((k2_rh(i,j).gt.52.5).and.(k2_rh(i,j).le.55)) then
                pres@gsLineColor = colors(2)
            end if
            if ((k2_rh(i,j).gt.55).and.(k2_rh(i,j).le.57.5)) then
                pres@gsLineColor = colors(3)
            end if
            if ((k2_rh(i,j).gt.57.5).and.(k2_rh(i,j).le.60)) then
                pres@gsLineColor = colors(4)
            end if
            if ((k2_rh(i,j).gt.60).and.(k2_rh(i,j).le.62.5)) then
                pres@gsLineColor = colors(5)
            end if
            if ((k2_rh(i,j).gt.62.5).and.(k2_rh(i,j).le.65)) then
                pres@gsLineColor = colors(6)
             end if
            if ((k2_rh(i,j).gt.65).and.(k2_rh(i,j).le.67.5)) then
                pres@gsLineColor = colors(7)
            end if
            if ((k2_rh(i,j).gt.67.5).and.(k2_rh(i,j).le.70)) then
                pres@gsLineColor = colors(8)
            end if 
            if ((k2_rh(i,j).gt.70).and.(k2_rh(i,j).le.72.5)) then
                pres@gsLineColor = colors(9)
            end if
            if ((k2_rh(i,j).gt.72.5).and.(k2_rh(i,j).le.75)) then
                pres@gsLineColor = colors(10)
            end if
            if ((k2_rh(i,j).gt.75).and.(k2_rh(i,j).le.77.5)) then
                pres@gsLineColor = colors(11)
            end if
            if ((k2_rh(i,j).gt.77.5).and.(k2_rh(i,j).le.80)) then
                pres@gsLineColor = colors(12)
            end if
            if ((k2_rh(i,j).gt.80).and.(k2_rh(i,j).le.82.5)) then
                pres@gsLineColor = colors(13)
            end if
            if ((k2_rh(i,j).gt.82.5).and.(k2_rh(i,j).le.85)) then
                pres@gsLineColor = colors(14)
             end if
            if ((k2_rh(i,j).gt.85).and.(k2_rh(i,j).le.87.5)) then
                pres@gsLineColor = colors(15)
            end if 
            if ((k2_rh(i,j).gt.87.5).and.(k2_rh(i,j).le.90)) then
                pres@gsLineColor = colors(16)
            end if
            if ((k2_rh(i,j).gt.90).and.(k2_rh(i,j).le.92.5)) then
                pres@gsLineColor = colors(17)
            end if
            if ((k2_rh(i,j).gt.92.5).and.(k2_rh(i,j).le.95)) then
                pres@gsLineColor = colors(18)
            end if
            if (k2_rh(i,j).gt.95) then
                pres@gsLineColor = colors(19)
            end if
            str = unique_string("string")
            map@$str$ = gsn_add_polyline(wks, map, xx, yy, pres)
    end do 
end do

do i = 0,a3-1                 ;0,tu-1
    do j = 2,72
        xx = (/k3_lon(i,j),k3_lon(i,j+1)/)
        yy = (/k3_lat(i,j),k3_lat(i,j+1)/)
            if ((k3_rh(i,j).gt.0).and.(k3_rh(i,j).le.50)) then
                pres@gsLineColor = colors(0)
            end if 
            if ((k3_rh(i,j).gt.50).and.(k3_rh(i,j).le.52.5)) then
                pres@gsLineColor = colors(1)
            end if
            if ((k3_rh(i,j).gt.52.5).and.(k3_rh(i,j).le.55)) then
                pres@gsLineColor = colors(2)
            end if
            if ((k3_rh(i,j).gt.55).and.(k3_rh(i,j).le.57.5)) then
                pres@gsLineColor = colors(3)
            end if
            if ((k3_rh(i,j).gt.57.5).and.(k3_rh(i,j).le.60)) then
                pres@gsLineColor = colors(4)
            end if
            if ((k3_rh(i,j).gt.60).and.(k3_rh(i,j).le.62.5)) then
                pres@gsLineColor = colors(5)
            end if
            if ((k3_rh(i,j).gt.62.5).and.(k3_rh(i,j).le.65)) then
                pres@gsLineColor = colors(6)
             end if
            if ((k3_rh(i,j).gt.65).and.(k3_rh(i,j).le.67.5)) then
                pres@gsLineColor = colors(7)
            end if
            if ((k3_rh(i,j).gt.67.5).and.(k3_rh(i,j).le.70)) then
                pres@gsLineColor = colors(8)
            end if 
            if ((k3_rh(i,j).gt.70).and.(k3_rh(i,j).le.72.5)) then
                pres@gsLineColor = colors(9)
            end if
            if ((k3_rh(i,j).gt.72.5).and.(k3_rh(i,j).le.75)) then
                pres@gsLineColor = colors(10)
            end if
            if ((k3_rh(i,j).gt.75).and.(k3_rh(i,j).le.77.5)) then
                pres@gsLineColor = colors(11)
            end if
            if ((k3_rh(i,j).gt.77.5).and.(k3_rh(i,j).le.80)) then
                pres@gsLineColor = colors(12)
            end if
            if ((k3_rh(i,j).gt.80).and.(k3_rh(i,j).le.82.5)) then
                pres@gsLineColor = colors(13)
            end if
            if ((k3_rh(i,j).gt.82.5).and.(k3_rh(i,j).le.85)) then
                pres@gsLineColor = colors(14)
             end if
            if ((k3_rh(i,j).gt.85).and.(k3_rh(i,j).le.87.5)) then
                pres@gsLineColor = colors(15)
            end if 
            if ((k3_rh(i,j).gt.87.5).and.(k3_rh(i,j).le.90)) then
                pres@gsLineColor = colors(16)
            end if
            if ((k3_rh(i,j).gt.90).and.(k3_rh(i,j).le.92.5)) then
                pres@gsLineColor = colors(17)
            end if
            if ((k3_rh(i,j).gt.92.5).and.(k3_rh(i,j).le.95)) then
                pres@gsLineColor = colors(18)
            end if
            if (k3_rh(i,j).gt.95) then
                pres@gsLineColor = colors(19)
            end if
            str = unique_string("string")
            map@$str$ = gsn_add_polyline(wks, map, xx, yy, pres)
    end do 
end do



;1,2,3
mres = True                   
mres@gsLineThicknessF = 7
mres@gsMarkerIndex     = 1                          ; index for circle
mres@gsMarkerSizeF     = .02                        ; size 

;0-实线，1-线段，2-点点
mres@gsLineColor = "black"
mres@gsLineDashPattern = 0
str = unique_string("string")
map@$str$ = gsn_add_polyline(wks, map, c3_lon, c3_lat, mres)

mres@gsLineColor = "black"
mres@gsLineDashPattern = 2
str = unique_string("string")
map@$str$ = gsn_add_polyline(wks, map, c1_lon, c1_lat, mres)

mres@gsLineColor = "black"
mres@gsLineDashPattern = 1
str = unique_string("string")
map@$str$ = gsn_add_polyline(wks, map, c2_lon, c2_lat, mres)



;-----------------------------------------------------------------------
draw(map)

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
gsn_polygon(wks,map,xlon,ylat,reg)

frame(wks)




end


































