begin 


;----------------------------
ff = addfile("/data/home/liyan/wangqy/ccr/data/32208/SP.nc","r")

printVarSummary(ff)
var = short2flt(ff->sp(:,::-1,:))                             ;;颠倒纬度顺序,有add_offset、scale_factor的数据
delete(ff)
printVarSummary(var)	                          

         t=asciiread("/data/home/liyan/wangqy/ccr/data/prep/st678_177.txt/",-1, "integer")
;printVarSummary(t)

t = t - 0
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


fout=addfile("/data/home/liyan/wangqy/ccr/data/177/SP.nc","c")
fout@creation_date:= systemfunc("date")
fout->sp=var1(:,:,:)       ;{15:55},{95:135}
b=fout
printVarSummary(b)
delete([/t,var1,fout,b/])


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