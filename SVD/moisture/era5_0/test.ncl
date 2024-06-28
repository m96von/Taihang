begin

tu =270
level_num = 12
hour_num = 241
LATS = new((/tu,level_num*hour_num/),float)
LONS = new((/tu,level_num*hour_num/),float)
RHS = new((/tu,level_num*hour_num/),float)
QS = new((/tu,level_num*hour_num/),float)

;------------------------------------------------------------------
lat1 = 10
lat2 = 70
lon1 = 90
lon2 = 150

        ff2 = addfile("/data/home/liyan/wangqy/topo/topo.nc","r")

topo = ff2->htopo({lat1:lat2},{lon1:lon2})
topo&lat@long_name = "Latitude"
topo&lat@units = "degrees_north"
topo&lon@long_name = "Longitude"
topo&lon@units = "degrees_east"
topo@long_name = "  "
topo@units = "  " 
printVarSummary(topo)

;----------------------------------------read-data-------------------------------------------
do i = 0,tu-1
    
    data = asciiread("../../type1/traj/traj_" + i,-1,"string")
    LAT = tofloat(str_get_field(data(22:),10," "))
    LON = tofloat(str_get_field(data(22:),11," "))
    RH = tofloat(str_get_field(data(22:),15," "))
    Q = tofloat(str_get_field(data(22:),16," "))
    LATS(i,:) = LAT(:)
    LONS(i,:) = LON(:)
    RHS(i,:) = RH(:)
    QS(i,:) = Q(:)
end do
delete(data)

;-------------------------------------------------------------------------------------
lat = new((/tu,level_num,hour_num/),float)
lon = new((/tu,level_num,hour_num/),float)
rh = new((/tu,level_num,hour_num/),float)
q = new((/tu,level_num,hour_num/),float)

do i = 0,level_num-1
    lat(:,i,:) = LATS(:,i::12)
    lon(:,i,:) = LONS(:,i::12)
    rh(:,i,:) = RHS(:,i::12)
    q(:,i,:) = QS(:,i::12)
end do 

path = fspan(1,tu,tu)
level = (/600,800,1000,1400,1700,2200,2600,3000,4000,4500,5000,5500/)
hour = fspan(0,-240,241)
lat!0 = "path"
lat!1 = "level"
lat!2 = "hour_back" 
lat&path = path
lat&level = level
lat&hour_back = hour 
lat&level@units = "m"
copy_VarMeta(lat, lon)
copy_VarMeta(lat, rh)
copy_VarMeta(lat, q)
lat@units = "degrees_north"
lon@units = "degrees_east"
rh@units = "%"
q@units = "g/kg"
printVarSummary(lat)


lon(80:89,0:3,:) = lon@_FillValue
lat(80:89,0:3,:) = lat@_FillValue
lon(80:89,4:7,:) = lon@_FillValue 
lat(80:89,4:7,:) = lat@_FillValue

; print(lat(0,0,:))
lat_1 = reshape(lat(:,0:3,:), (/tu*4,241/))
lat_2 = reshape(lat(:,4:7,:), (/tu*4,241/))
lat_3 = reshape(lat(:,8:11,:), (/tu*4,241/))
lon_1 = reshape(lon(:,0:3,:), (/tu*4,241/))
lon_2 = reshape(lon(:,4:7,:), (/tu*4,241/))
lon_3 = reshape(lon(:,8:11,:), (/tu*4,241/))


;-------------------------------------------------------------------------------------------------




rh_1 = reshape(rh(:,0:3,:), (/tu*4,241/))
rh_2 = reshape(rh(:,4:7,:),(/tu*4,241/))
rh_3 = reshape(rh(:,8:11,:), (/tu*4,241/))


rh_ave1 = dim_avg_n_Wrap(rh_1(:,0:10),1)
rh_ave2 = dim_avg_n_Wrap(rh_2(:,0:10),1)
rh_ave3 = dim_avg_n_Wrap(rh_3(:,0:10),1)


s1 = 500
s2 = 556
s3 = 300

s1_lat = new((/s1,hour_num/),float)
s1_lon = new((/s1,hour_num/),float)
s1_rh = new((/s1,hour_num/),float)
s1_q = new((/s1,hour_num/),float)
s1_lat = 0
s1_lon = 0
s1_rh = 0
s1_q = 0

s2_lat = new((/s2,hour_num/),float)
s2_lon = new((/s2,hour_num/),float)
s2_rh = new((/s2,hour_num/),float)
s2_q = new((/s2,hour_num/),float)
s2_lat = 0
s2_lon = 0
s2_rh = 0
s2_q = 0

s3_lat = new((/s3,hour_num/),float)
s3_lon = new((/s3,hour_num/),float)
s3_rh = new((/s3,hour_num/),float)
s3_q = new((/s3,hour_num/),float)
s3_lat = 0
s3_lon = 0
s3_rh = 0
s3_q = 0

s1_lat = new((/s1,hour_num/),float)
s1_lon = new((/s1,hour_num/),float)
s1_rh = new((/s1,hour_num/),float)
s1_q = new((/s1,hour_num/),float)
s1_lat = 0
s1_lon = 0
s1_rh = 0
s1_q = 0

s2_lat = new((/s2,hour_num/),float)
s2_lon = new((/s2,hour_num/),float)
s2_rh = new((/s2,hour_num/),float)
s2_q = new((/s2,hour_num/),float)
s2_lat = 0
s2_lon = 0
s2_rh = 0
s2_q = 0

s3_lat = new((/s3,hour_num/),float)
s3_lon = new((/s3,hour_num/),float)
s3_rh = new((/s3,hour_num/),float)
s3_q = new((/s3,hour_num/),float)
s3_lat = 0
s3_lon = 0
s3_rh = 0
s3_q = 0

a = 0                                   ; a: path_num
do i = 0,tu*4-1
    if (rh_ave1(i).ge.75) then
        s1_lat(a,:) = lat_1(i,:)
        s1_lon(a,:) = lon_1(i,:)
        s1_rh(a,:) = rh_1(i,:)
        a = a + 1
    end if 
end do
print(a)
printVarSummary(s1_lat)
print(s1_lat(0:10,1))

; exit()


a = 0                                   ; a: path_num
do i = 0,tu*4-1
    if (rh_ave2(i).ge.75) then
        s2_lat(a,:) = lat_2(i,:)
        s2_lon(a,:) = lon_2(i,:)
        s2_rh(a,:) = rh_2(i,:)
        a = a + 1
    end if 
end do
print(a)



a = 0                                   ; a: path_num
do i = 0,tu*4-1
    if (rh_ave3(i).ge.75) then
        s3_lat(a,:) = lat_3(i,:)
        s3_lon(a,:) = lon_3(i,:)
        s3_rh(a,:) = rh_3(i,:)
        a = a + 1
    end if 
end do
print(a)

s3_rh = s3_rh - 8

path1 = fspan(1,s1,s1)
hour = fspan(0,-240,241)
s1_lat!0 = "path"
s1_lat!1 = "hour_back"
s1_lat&path = path1
s1_lat&hour_back = hour 
s1_lat&hour_back@units = "h"
copy_VarMeta(s1_lat,s1_lon)
copy_VarMeta(s1_lat,s1_rh)
s1_lat@units = "degrees_north"
s1_lon@units = "degrees_east"
s1_rh@units = "%"
printVarSummary(s1_rh)

path2 = fspan(1,s2,s2)
hour = fspan(0,-240,241)
s2_lat!0 = "path"
s2_lat!1 = "hour_back"
s2_lat&path = path2
s2_lat&hour_back = hour 
s2_lat&hour_back@units = "h"
copy_VarMeta(s2_lat,s2_lon)
copy_VarMeta(s2_lat,s2_rh)
s2_lat@units = "degrees_north"
s2_lon@units = "degrees_east"
s2_rh@units = "%"
printVarSummary(s2_lat)


path3 = fspan(1,s3,s3)
hour = fspan(0,-240,241)
s3_lat!0 = "path"
s3_lat!1 = "hour_back"
s3_lat&path = path3
s3_lat&hour_back = hour 
s3_lat&hour_back@units = "h"
copy_VarMeta(s3_lat,s3_lon)
copy_VarMeta(s3_lat,s3_rh)
s3_lat@units = "degrees_north"
s3_lon@units = "degrees_east"
s3_rh@units = "%"
printVarSummary(s3_lat)


setfileoption("nc","Format","NetCDF4Classic")               
;This allows us to save a variable larger than 2GB gracefully.
fout=addfile("type1_l11.nc","c")
fout@creation_date:= systemfunc("date")
fout->lat=s1_lat    
fout->lon=s1_lon 
fout->rh=s1_rh 
b=fout
printVarSummary(b)
delete([/fout,b/])


setfileoption("nc","Format","NetCDF4Classic")               
;This allows us to save a variable larger than 2GB gracefully.
fout=addfile("type1_l22.nc","c")
fout@creation_date:= systemfunc("date")
fout->lat=s2_lat    
fout->lon=s2_lon 
fout->rh=s2_rh 
b=fout
printVarSummary(b)
delete([/fout,b/])

setfileoption("nc","Format","NetCDF4Classic")               
;This allows us to save a variable larger than 2GB gracefully.
fout=addfile("type1_l33.nc","c")
fout@creation_date:= systemfunc("date")
fout->lat=s3_lat    
fout->lon=s3_lon 
fout->rh=s3_rh 
b=fout
printVarSummary(b)
delete([/fout,b/])





end