
undef("get_ocean_colormap")
function get_ocean_colormap()
begin
  cmap = (/ (/0,       123,     3/), \
            (/0,       119,     5/), \
            (/0,       117,     7/), \
            (/0,       114,     8/), \
            (/0,       110,     10/), \
            (/0,       107,     12/), \
            (/0,       105,     15/), \
            (/0,       102,     17/), \
            (/0,       100,     17/), \
            (/0,       96,      21/), \
            (/0,       94,      22/), \
            (/0,       89,      24/), \
            (/0,       88,      26/), \
            (/0,       84,      28/), \
            (/0,       82,      29/), \
            (/0,       77,      33/), \
            (/0,       75,      35/), \
            (/0,       73,      35/), \
            (/0,       68,      38/), \
            (/0,       66,      40/), \
            (/0,       63,      42/), \
            (/0,       61,      43/), \
            (/0,       56,      47/), \
            (/0,       54,      49/), \
            (/0,       51,      51/), \
            (/0,       49,      52/), \
            (/0,       45,      54/), \
            (/0,       42,      56/), \
            (/0,       38,      59/), \
            (/0,       37,      59/), \
            (/0,       33,      63/), \
            (/0,       29,      65/), \
            (/0,       26,      66/), \
            (/0,       24,      68/), \
            (/0,       21,      70/), \
            (/0,       17,      73/), \
            (/0,       16,      73/), \
            (/0,       12,      77/), \
            (/0,       8,       79/), \
            (/0,       5,       80/), \
            (/0,       3,       82/), \
            (/0,       0,       84/), \
            (/0,       3,       86/), \
            (/0,       5,       89/), \
            (/0,       7,       89/), \
            (/0,       12,      93/), \
            (/0,       15,      94/), \
            (/0,       17,      96/), \
            (/0,       21,      98/), \
            (/0,       24,      100/), \
            (/0,       26,      103/), \
            (/0,       29,      105/), \
            (/0,       31,      105/), \
            (/0,       35,      109/), \
            (/0,       38,      110/), \
            (/0,       42,      112/), \
            (/0,       45,      114/), \
            (/0,       47,      117/), \
            (/0,       51,      119/), \
            (/0,       54,      121/), \
            (/0,       55,      121/), \
            (/0,       59,      124/), \
            (/0,       63,      126/), \
            (/0,       66,      128/), \
            (/0,       68,      130/), \
            (/0,       72,      133/), \
            (/0,       75,      135/), \
            (/0,       77,      137/), \
            (/0,       80,      138/), \
            (/0,       84,      140/), \
            (/0,       86,      142/), \
            (/0,       89,      144/), \
            (/0,       93,      147/), \
            (/0,       96,      149/), \
            (/0,       97,      149/), \
            (/0,       102,     153/), \
            (/0,       105,     154/), \
            (/0,       107,     156/), \
            (/0,       110,     158/), \
            (/0,       114,     161/), \
            (/0,       117,     163/), \
            (/0,       119,     165/), \
            (/0,       123,     167/), \
            (/0,       126,     168/), \
            (/3,       128,     170/), \
            (/8,       131,     172/), \
            (/15,      135,     175/), \
            (/21,      137,     177/), \
            (/26,      140,     179/), \
            (/33,      144,     181/), \
            (/35,      145,     181/), \
            (/45,      149,     184/), \
            (/51,      153,     186/), \
            (/56,      156,     188/), \
            (/63,      158,     191/), \
            (/68,      161,     193/), \
            (/75,      165,     195/), \
            (/80,      168,     196/), \
            (/86,      170,     198/), \
            (/93,      174,     200/), \
            (/98,      177,     202/), \
            (/105,     179,     205/), \
            (/110,     182,     207/), \
            (/117,     186,     209/), \
            (/123,     188,     211/), \
            (/128,     191,     212/), \
            (/131,     193,     214/), \
            (/140,     198,     216/), \
            (/147,     200,     219/), \
            (/153,     204,     221/), \
            (/158,     207,     223/), \
            (/165,     209,     225/), \
            (/170,     212,     226/), \
            (/177,     216,     228/), \
            (/182,     219,     230/), \
            (/188,     221,     232/), \
            (/195,     225,     235/), \
            (/200,     228,     237/), \
            (/207,     230,     239/), \
            (/212,     233,     240/), \
            (/219,     237,     242/), \
            (/225,     239,     244/), \
            (/228,     241,     246/), \
            (/237,     246,     249/), \
            (/242,     249,     251/), \
            (/249,     251,     253/), \
            (/255,     255,     255/)/)/255.
  return(cmap)
end

;----------------------------------------------------------------------
; This procedure draws subsets of a global 1' topographic map read in
; from a netCDF file. The first plot is of land, the second of ocean.
; Two different colormaps and contour levels are used.
;----------------------------------------------------------------------
undef("draw_topo_map")
procedure draw_topo_map(wks,minlat,maxlat,minlon,maxlon)
begin
;---Read data
  topo_file = "/data/home/liyan/wangqy/topo/ETOPO1_Bed_c_gmt4.grd.nc"
  a         = addfile(topo_file,"r")
  elev_lnd  = a->z({minlat:maxlat},{minlon:maxlon})
  elev_ocn  = a->z({minlat:maxlat},{minlon:maxlon})
  elev_lnd  = where(elev_lnd.lt.-90,elev_lnd@_FillValue,elev_lnd)
  elev_ocn  = where(elev_ocn.ge.0,elev_ocn@_FillValue,elev_ocn)

;---Set some resources
  res                   = True

  res@gsnDraw           = False    ; will panel later
  res@gsnFrame          = False    ; will panel later

  res@cnFillOn          = True     ; turn on contour fill
  res@lbOrientation     = "Vertical"
  ; res@vpWidthF                        = 0.72           ; change aspect ratio of plot
  ; res@vpHeightF                       = 0.4

  res@cnLinesOn         = False    ; turn off contour lines
  res@cnLineLabelsOn    = False    ; turn off line labels
  res@cnFillMode        = "MeshFill"
  res@lbBoxLinesOn      = False

  res@gsnAddCyclic      = False

;---Zoom in on map
  res@tmXTOn				    = True
  res@tmYROn					  = True
  ; res@tmXUseBottom			= False
  ; res@tmYUseLeft				= False
  res@mpMinLatF         = minlat
  res@mpMaxLatF         = maxlat
  res@mpMinLonF         = minlon
  res@mpMaxLonF         = maxlon
  res@tmXBLabelDeltaF   = -0.5
  res@tmYLLabelDeltaF   = -0.5
  res@tmXTLabelDaltaF   = -0.5
  res@tmYRLabelDeltaF   = -0.5
  res@tmXBLabelFontHeightF		=0.029                  ;坐标轴字号 0.019,0.014
  res@tmYLLabelFontHeightF		=0.029
  res@tmXBMode          ="Explicit"
  ;res@tmXBValues        =(/112,114,116,118/)
  ;res@tmXBLabels        =(/"112E","114E","116E","118E"/)
  ;res@tmYLMode          ="Explicit"
  ;res@tmYLValues        =(/35,37,39,41,43/)
  ;res@tmYLLabels        =(/"35N","37N","39N","41N","43N"/)
  res@tmXBValues        =(/111,113,115,117,119/)
  res@tmXBLabels        =(/"111E","113E","115E","117E","119E"/)
  res@tmYLMode          ="Explicit"
  res@tmYLValues        =(/35,37,39,41/)
  res@tmYLLabels        =(/"35N","37N","39N","41N"/)
  res@tmXBTickSpacingF			=2               ;坐标            
  res@tmYLTickSpacingF			=2
  res@mpCenterLonF      = (res@mpMinLonF + res@mpMaxLonF) / 2.
  res@mpDataBaseVersion			        = "Ncarg4_1"                   ;;;地图
  res@mpDataSetName			        = "Earth..4"
  res@mpAreaMaskingOn			        = True
  res@mpOutlineSpecifiers		        = (/"China:states","Taiwan"/)  
  res@mpOutlineOn				= True
  res@mpFillOn             = True

  res@mpDataBaseVersion = "MediumRes"   ; Improve map outlines
  res@mpFillDrawOrder   = "PostDraw"

  res@gsnLeftString			    = " (a) "
  res@gsnCenterString       = "Taihang Mountains"
  res@gsnRightString			    = "Beijing  Hebei  Henan Shanxi"
  res@gsnCenterStringFontColor  = "firebrick3"
  res@gsnRightStringFontColor  = "firebrick1"
  res@gsnLeftStringFontHeightF = 0.032
  res@gsnLeftStringOrthogonalPosF       = 0.015
  res@gsnCenterStringFontHeightF = 0.032
  res@gsnCenterStringOrthogonalPosF       = 0.1
  res@gsnRightStringFontHeightF = 0.025
  res@gsnRightStringOrthogonalPosF      = 0.02
  res@lbLabelStride     = 10
  res@pmLabelBarOrthogonalPosF			= 0.040
  res@lbLabelFontHeightF				   = 0.029  

;---Get color map for land
  cmap = read_colormap_file("MPL_terrain")
  res@cnFillPalette        = cmap(10:,:)

;---Set contours for land levels
  mnmxint = nice_mnmxintvl( min(elev_lnd), max(elev_lnd), 18, False)
  res@cnLevelSelectionMode = "ManualLevels"
  res@cnMinLevelValF       = mnmxint(0)
  res@cnMaxLevelValF       = 2400
  res@cnLevelSpacingF      = mnmxint(2)/5.
  res@mpOceanFillColor     = 0
  res@mpLandFillColor      = -1            ; transparent

  plot_lnd  = gsn_csm_contour_map(wks,elev_lnd,res)

;---Get color map for ocean
  cmap := get_ocean_colormap()
  res@cnFillPalette := cmap

;---Set contours for ocean levels
  mnmxint = nice_mnmxintvl( min(elev_ocn), max(elev_ocn), 18, False)
  res@cnLevelSelectionMode = "ManualLevels"
  res@cnMinLevelValF       = mnmxint(0)
  res@cnMaxLevelValF       = -1000
  res@cnLevelSpacingF      = mnmxint(2)/8.
  res@mpOceanFillColor     := -1            ; transparent
  res@mpLandFillColor      := "tan"

  plot_ocn = gsn_csm_contour_map(wks,elev_ocn,res)

;---Panel both plots
  pres                     = True
  pres@gsnPanelMainString  = " "
  pres@gsnMaximize         = True
  gsn_panel(wks,(/plot_lnd/),(/1,1/),pres)



  lat_sjz=38.07
  lon_sjz=114.35
  
  mkres=True 
  mkres@gsMarkerColor="black"
  mkres@gsMarkerSizeF=0.005
  mkres@gsMarkerIndex=16
  mkres@cnFillDrawOrder			="AfterDraw"
  dum=gsn_add_polymarker(wks,plot_lnd,lon_sjz,lat_sjz,mkres)

  gsn_polymarker(wks,plot_lnd,lon_sjz,lat_sjz,mkres)


  
  draw(plot_lnd)
  xlon = (/113,115,115,113,113/)
  ylat = (/35,35,38.5,38.5,35/)
  reg                             = True
  reg@gsFillColor                 = "Transparent"
  ;reg@gsEdgeDashPattern           = 0
  reg@gsEdgesOn                   = True 
  reg@gsEdgeColor                 = "black"
  reg@gsEdgeThicknessF            = 3
  reg@gsEdgeDashPattern           = 0                 ; 0-实线 1-虚线
  reg@gsEdgeDashSegLenF           = 0.2
  gsn_polygon(wks,plot_lnd,xlon,ylat,reg)


  frame(wks)






end

;----------------------------------------------------------------------
; Main code
;----------------------------------------------------------------------
begin
  wksname = "a"        
  wks_type = "pdf"
  wks=gsn_open_wks(wks_type,wksname)
;
; Increase memory for contours. This is necessary if you are 
; contouring a large grid. Otherwise, you might get this error:
;
;     fatal:ContourPlotDraw: Workspace reallocation would exceed maximum size 262144
;
  setvalues NhlGetWorkspaceObjectId() 
    "wsMaximumSize" : 100000000000000000
  end setvalues

  draw_topo_map(wks,34,42,110,120)
end