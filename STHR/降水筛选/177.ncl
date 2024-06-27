begin 


;----------------------------
; ff = addfile("/data/home/liyan/wangqy/ccr/data/32208/SP.nc","r")

; printVarSummary(ff)
; var = short2flt(ff->sp(:,::-1,:))                             ;;颠倒纬度顺序,有add_offset、scale_factor的数据
; delete(ff)
; printVarSummary(var)	                          

;          t=asciiread("/data/home/liyan/wangqy/ccr/data/prep/st678_177.txt/",-1, "integer")
; ;printVarSummary(t)

; t = t - 0
; ;print(t(0:10))

; var1=new((/177,361,321/),"float")             
; do x=0,32207
; 	do j=0,177-1
; 		if(t(j).eq.x) then
; 			var1(j,:,:)=var(x,:,:)
; 		end if
; 	end do
; end do
; printVarSummary(var1)
; ;print(var1(0,0,0:10))
; delete(var)


; fout=addfile("/data/home/liyan/wangqy/ccr/data/177/SP.nc","c")
; fout@creation_date:= systemfunc("date")
; fout->sp=var1(:,:,:)       ;{15:55},{95:135}
; b=fout
; printVarSummary(b)
; delete([/t,var1,fout,b/])

;-------------------------------



; ff = addfile("/data/home/liyan/wangqy/ccr/data/32208/2mT.nc","r")

; printVarSummary(ff)
; var = short2flt(ff->t2m(:,::-1,:))                             ;;颠倒纬度顺序,有add_offset、scale_factor的数据
; delete(ff)
; printVarSummary(var)	                          

;          t=asciiread("/data/home/liyan/wangqy/ccr/data/prep/st678_177.txt/",-1, "integer")
; ;printVarSummary(t)

; t = t - 0
; ;print(t(0:10))

; var1=new((/177,361,321/),"float")             
; do x=0,32207
; 	do j=0,177-1
; 		if(t(j).eq.x) then
; 			var1(j,:,:)=var(x,:,:)
; 		end if
; 	end do
; end do
; printVarSummary(var1)
; ;print(var1(0,0,0:10))
; delete(var)


; fout=addfile("/data/home/liyan/wangqy/ccr/data/177/2mT.nc","c")
; fout@creation_date:= systemfunc("date")
; fout->t2m=var1(:,:,:)       ;{15:55},{95:135}
; b=fout
; printVarSummary(b)
; delete([/t,var1,fout,b/])


; ;---------------------------------
; ff = addfile("/data/home/liyan/wangqy/ccr/data/32208/RH950.nc","r")

; printVarSummary(ff)
; var = short2flt(ff->r(:,::-1,:))                             ;;颠倒纬度顺序,有add_offset、scale_factor的数据
; delete(ff)
; printVarSummary(var)	                          

;          t=asciiread("/data/home/liyan/wangqy/ccr/data/st678_177.txt/",-1, "integer")
; ;printVarSummary(t)

; t = t - 6
; ;print(t(0:10))

; var1=new((/177,361,321/),"float")             
; do x=0,32207
; 	do j=0,177-1
; 		if(t(j).eq.x) then
; 			var1(j,:,:)=var(x,:,:)
; 		end if
; 	end do
; end do
; printVarSummary(var1)
; ;print(var1(0,0,0:10))
; delete(var)


; fout=addfile("/data/home/liyan/wangqy/ccr/data/177/RH950_6.nc","c")
; fout@creation_date:= systemfunc("date")
; fout->r=var1(:,:,:)       ;{15:55},{95:135}
; b=fout
; printVarSummary(b)
; delete([/t,var1,fout,b/])

; ;---------------------------------
; ff = addfile("/data/home/liyan/wangqy/ccr/data/32208/RH925.nc","r")

; printVarSummary(ff)
; var = short2flt(ff->r(:,::-1,:))                             ;;颠倒纬度顺序,有add_offset、scale_factor的数据
; delete(ff)
; printVarSummary(var)	                          

;          t=asciiread("/data/home/liyan/wangqy/ccr/data/st678_177.txt/",-1, "integer")
; ;printVarSummary(t)

; t = t - 6
; ;print(t(0:10))

; var1=new((/177,361,321/),"float")             
; do x=0,32207
; 	do j=0,177-1
; 		if(t(j).eq.x) then
; 			var1(j,:,:)=var(x,:,:)
; 		end if
; 	end do
; end do
; printVarSummary(var1)
; ;print(var1(0,0,0:10))
; delete(var)


; fout=addfile("/data/home/liyan/wangqy/ccr/data/177/RH925_6.nc","c")
; fout@creation_date:= systemfunc("date")
; fout->r=var1(:,:,:)       ;{15:55},{95:135}
; b=fout
; printVarSummary(b)
; delete([/t,var1,fout,b/])

; ;---------------------------------
; ff = addfile("/data/home/liyan/wangqy/ccr/data/32208/RH900.nc","r")

; printVarSummary(ff)
; var = short2flt(ff->r(:,::-1,:))                             ;;颠倒纬度顺序,有add_offset、scale_factor的数据
; delete(ff)
; printVarSummary(var)	                          

;          t=asciiread("/data/home/liyan/wangqy/ccr/data/st678_177.txt/",-1, "integer")
; ;printVarSummary(t)

; t = t - 6
; ;print(t(0:10))

; var1=new((/177,361,321/),"float")             
; do x=0,32207
; 	do j=0,177-1
; 		if(t(j).eq.x) then
; 			var1(j,:,:)=var(x,:,:)
; 		end if
; 	end do
; end do
; printVarSummary(var1)
; ;print(var1(0,0,0:10))
; delete(var)


; fout=addfile("/data/home/liyan/wangqy/ccr/data/177/RH900_6.nc","c")
; fout@creation_date:= systemfunc("date")
; fout->r=var1(:,:,:)       ;{15:55},{95:135}
; b=fout
; printVarSummary(b)
; delete([/t,var1,fout,b/])

; ;---------------------------------
; ff = addfile("/data/home/liyan/wangqy/ccr/data/32208/RH875.nc","r")

; printVarSummary(ff)
; var = short2flt(ff->r(:,::-1,:))                             ;;颠倒纬度顺序,有add_offset、scale_factor的数据
; delete(ff)
; printVarSummary(var)	                          

;          t=asciiread("/data/home/liyan/wangqy/ccr/data/st678_177.txt/",-1, "integer")
; ;printVarSummary(t)

; t = t - 6
; ;print(t(0:10))

; var1=new((/177,361,321/),"float")             
; do x=0,32207
; 	do j=0,177-1
; 		if(t(j).eq.x) then
; 			var1(j,:,:)=var(x,:,:)
; 		end if
; 	end do
; end do
; printVarSummary(var1)
; ;print(var1(0,0,0:10))
; delete(var)


; fout=addfile("/data/home/liyan/wangqy/ccr/data/177/RH875_6.nc","c")
; fout@creation_date:= systemfunc("date")
; fout->r=var1(:,:,:)       ;{15:55},{95:135}
; b=fout
; printVarSummary(b)
; delete([/t,var1,fout,b/])

; ;---------------------------------
; ff = addfile("/data/home/liyan/wangqy/ccr/data/32208/RH850.nc","r")

; printVarSummary(ff)
; var = short2flt(ff->r(:,::-1,:))                             ;;颠倒纬度顺序,有add_offset、scale_factor的数据
; delete(ff)
; printVarSummary(var)	                          

;          t=asciiread("/data/home/liyan/wangqy/ccr/data/st678_177.txt/",-1, "integer")
; ;printVarSummary(t)

; t = t - 6
; ;print(t(0:10))

; var1=new((/177,361,321/),"float")             
; do x=0,32207
; 	do j=0,177-1
; 		if(t(j).eq.x) then
; 			var1(j,:,:)=var(x,:,:)
; 		end if
; 	end do
; end do
; printVarSummary(var1)
; ;print(var1(0,0,0:10))
; delete(var)


; fout=addfile("/data/home/liyan/wangqy/ccr/data/177/RH850_6.nc","c")
; fout@creation_date:= systemfunc("date")
; fout->r=var1(:,:,:)       ;{15:55},{95:135}
; b=fout
; printVarSummary(b)
; delete([/t,var1,fout,b/])

; ;---------------------------------
; ff = addfile("/data/home/liyan/wangqy/ccr/data/32208/RH800.nc","r")

; printVarSummary(ff)
; var = short2flt(ff->r(:,::-1,:))                             ;;颠倒纬度顺序,有add_offset、scale_factor的数据
; delete(ff)
; printVarSummary(var)	                          

;          t=asciiread("/data/home/liyan/wangqy/ccr/data/st678_177.txt/",-1, "integer")
; ;printVarSummary(t)

; t = t - 6
; ;print(t(0:10))

; var1=new((/177,361,321/),"float")             
; do x=0,32207
; 	do j=0,177-1
; 		if(t(j).eq.x) then
; 			var1(j,:,:)=var(x,:,:)
; 		end if
; 	end do
; end do
; printVarSummary(var1)
; ;print(var1(0,0,0:10))
; delete(var)


; fout=addfile("/data/home/liyan/wangqy/ccr/data/177/RH800_6.nc","c")
; fout@creation_date:= systemfunc("date")
; fout->r=var1(:,:,:)       ;{15:55},{95:135}
; b=fout
; printVarSummary(b)
; delete([/t,var1,fout,b/])

; ;---------------------------------
; ff = addfile("/data/home/liyan/wangqy/ccr/data/32208/RH750.nc","r")

; printVarSummary(ff)
; var = short2flt(ff->r(:,::-1,:))                             ;;颠倒纬度顺序,有add_offset、scale_factor的数据
; delete(ff)
; printVarSummary(var)	                          

;          t=asciiread("/data/home/liyan/wangqy/ccr/data/st678_177.txt/",-1, "integer")
; ;printVarSummary(t)

; t = t - 6
; ;print(t(0:10))

; var1=new((/177,361,321/),"float")             
; do x=0,32207
; 	do j=0,177-1
; 		if(t(j).eq.x) then
; 			var1(j,:,:)=var(x,:,:)
; 		end if
; 	end do
; end do
; printVarSummary(var1)
; ;print(var1(0,0,0:10))
; delete(var)


; fout=addfile("/data/home/liyan/wangqy/ccr/data/177/RH750_6.nc","c")
; fout@creation_date:= systemfunc("date")
; fout->r=var1(:,:,:)       ;{15:55},{95:135}
; b=fout
; printVarSummary(b)
; delete([/t,var1,fout,b/])

; ;---------------------------------
; ff = addfile("/data/home/liyan/wangqy/ccr/data/32208/RH700.nc","r")

; printVarSummary(ff)
; var = short2flt(ff->r(:,::-1,:))                             ;;颠倒纬度顺序,有add_offset、scale_factor的数据
; delete(ff)
; printVarSummary(var)	                          

;          t=asciiread("/data/home/liyan/wangqy/ccr/data/st678_177.txt/",-1, "integer")
; ;printVarSummary(t)

; t = t - 6
; ;print(t(0:10))

; var1=new((/177,361,321/),"float")             
; do x=0,32207
; 	do j=0,177-1
; 		if(t(j).eq.x) then
; 			var1(j,:,:)=var(x,:,:)
; 		end if
; 	end do
; end do
; printVarSummary(var1)
; ;print(var1(0,0,0:10))
; delete(var)


; fout=addfile("/data/home/liyan/wangqy/ccr/data/177/RH700_6.nc","c")
; fout@creation_date:= systemfunc("date")
; fout->r=var1(:,:,:)       ;{15:55},{95:135}
; b=fout
; printVarSummary(b)
; delete([/t,var1,fout,b/])

; ;---------------------------------
; ff = addfile("/data/home/liyan/wangqy/ccr/data/32208/RH500.nc","r")

; printVarSummary(ff)
; var = short2flt(ff->r(:,::-1,:))                             ;;颠倒纬度顺序,有add_offset、scale_factor的数据
; delete(ff)
; printVarSummary(var)	                          

;          t=asciiread("/data/home/liyan/wangqy/ccr/data/st678_177.txt/",-1, "integer")
; ;printVarSummary(t)

; t = t - 6
; ;print(t(0:10))

; var1=new((/177,361,321/),"float")             
; do x=0,32207
; 	do j=0,177-1
; 		if(t(j).eq.x) then
; 			var1(j,:,:)=var(x,:,:)
; 		end if
; 	end do
; end do
; printVarSummary(var1)
; ;print(var1(0,0,0:10))
; delete(var)


; fout=addfile("/data/home/liyan/wangqy/ccr/data/177/RH500_6.nc","c")
; fout@creation_date:= systemfunc("date")
; fout->r=var1(:,:,:)       ;{15:55},{95:135}
; b=fout
; printVarSummary(b)
; delete([/t,var1,fout,b/])

; ;---------------------------------
; ff = addfile("/data/home/liyan/wangqy/ccr/data/32208/RH300.nc","r")

; printVarSummary(ff)
; var = short2flt(ff->r(:,::-1,:))                             ;;颠倒纬度顺序,有add_offset、scale_factor的数据
; delete(ff)
; printVarSummary(var)	                          

;          t=asciiread("/data/home/liyan/wangqy/ccr/data/st678_177.txt/",-1, "integer")
; ;printVarSummary(t)

; t = t - 6
; ;print(t(0:10))

; var1=new((/177,361,321/),"float")             
; do x=0,32207
; 	do j=0,177-1
; 		if(t(j).eq.x) then
; 			var1(j,:,:)=var(x,:,:)
; 		end if
; 	end do
; end do
; printVarSummary(var1)
; ;print(var1(0,0,0:10))
; delete(var)


; fout=addfile("/data/home/liyan/wangqy/ccr/data/177/RH300_6.nc","c")
; fout@creation_date:= systemfunc("date")
; fout->r=var1(:,:,:)       ;{15:55},{95:135}
; b=fout
; printVarSummary(b)
; delete([/t,var1,fout,b/])

; ;---------------------------------
; ff = addfile("/data/home/liyan/wangqy/ccr/data/32208/RH200.nc","r")

; printVarSummary(ff)
; var = short2flt(ff->r(:,::-1,:))                             ;;颠倒纬度顺序,有add_offset、scale_factor的数据
; delete(ff)
; printVarSummary(var)	                          

;          t=asciiread("/data/home/liyan/wangqy/ccr/data/st678_177.txt/",-1, "integer")
; ;printVarSummary(t)

; t = t - 6
; ;print(t(0:10))

; var1=new((/177,361,321/),"float")             
; do x=0,32207
; 	do j=0,177-1
; 		if(t(j).eq.x) then
; 			var1(j,:,:)=var(x,:,:)
; 		end if
; 	end do
; end do
; printVarSummary(var1)
; ;print(var1(0,0,0:10))
; delete(var)


; fout=addfile("/data/home/liyan/wangqy/ccr/data/177/RH200_6.nc","c")
; fout@creation_date:= systemfunc("date")
; fout->r=var1(:,:,:)       ;{15:55},{95:135}
; b=fout
; printVarSummary(b)
; delete([/t,var1,fout,b/])

; ;---------------------------------
; ff = addfile("/data/home/liyan/wangqy/ccr/data/32208/RH100.nc","r")

; printVarSummary(ff)
; var = short2flt(ff->r(:,::-1,:))                             ;;颠倒纬度顺序,有add_offset、scale_factor的数据
; delete(ff)
; printVarSummary(var)	                          

;          t=asciiread("/data/home/liyan/wangqy/ccr/data/st678_177.txt/",-1, "integer")
; ;printVarSummary(t)

; t = t - 6
; ;print(t(0:10))

; var1=new((/177,361,321/),"float")             
; do x=0,32207
; 	do j=0,177-1
; 		if(t(j).eq.x) then
; 			var1(j,:,:)=var(x,:,:)
; 		end if
; 	end do
; end do
; printVarSummary(var1)
; ;print(var1(0,0,0:10))
; delete(var)


; fout=addfile("/data/home/liyan/wangqy/ccr/data/177/RH100_6.nc","c")
; fout@creation_date:= systemfunc("date")
; fout->r=var1(:,:,:)       ;{15:55},{95:135}
; b=fout
; printVarSummary(b)
; delete([/t,var1,fout,b/])


;============================================================

; ff = addfile("/data/home/liyan/wangqy/ccr/data/32208/CAPE.nc","r")

; printVarSummary(ff)
; var = short2flt(ff->cape(:,::-1,:))                             ;;颠倒纬度顺序,有add_offset、scale_factor的数据
; delete(ff)
; printVarSummary(var)	                          

;          t=asciiread("/data/home/liyan/wangqy/ccr/data/prep/st678_177.txt/",-1, "integer")
; ;printVarSummary(t)

; t = t - 6
; ;print(t(0:10))

; var1=new((/177,361,321/),"float")             
; do x=0,32207
; 	do j=0,177-1
; 		if(t(j).eq.x) then
; 			var1(j,:,:)=var(x,:,:)
; 		end if
; 	end do
; end do
; printVarSummary(var1)
; ;print(var1(0,0,0:10))
; delete(var)


; fout=addfile("/data/home/liyan/wangqy/ccr/data/177/CAPE_6.nc","c")
; fout@creation_date:= systemfunc("date")
; fout->cape=var1(:,:,:)       ;{15:55},{95:135}
; b=fout
; printVarSummary(b)
; delete([/t,var1,fout,b/])


;---------------------------------------------------

ff = addfile("/data/home/liyan/wangqy/ccr/data/32208/D2m.nc","r")

printVarSummary(ff)
var = short2flt(ff->d2m(:,::-1,:))                             ;;颠倒纬度顺序,有add_offset、scale_factor的数据
delete(ff)
printVarSummary(var)	                          

         t=asciiread("/data/home/liyan/wangqy/ccr/data/prep/st678_177.txt/",-1, "integer")
;printVarSummary(t)

t = t - 6
;print(t(0:10))

var1=new((/177,361,321/),"float")             
do x=0,32207
	do j=0,177-1
		if(t(j).eq.x) then
			var1(j,:,:)=var(x,:,:)
		end if
	end do
end do
printVarSummary(var1)
;print(var1(0,0,0:10))
delete(var)


fout=addfile("/data/home/liyan/wangqy/ccr/data/177/D2m_6.nc","c")
fout@creation_date:= systemfunc("date")
fout->d2m=var1(:,:,:)       ;{15:55},{95:135}
b=fout
printVarSummary(b)
delete([/t,var1,fout,b/])





end