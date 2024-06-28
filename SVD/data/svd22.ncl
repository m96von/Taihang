begin 


         time=asciiread("svd22.txt/",-1, "integer")
printVarSummary(time)
time = time - 0
time1 = dimsizes(time)
;print(t(0:10))

; ;----------------------------------------------------------------------------
		ff = addfile("/data/home/liyan/wangqy/ccr/data/177/test/var_6.nc","r")

printVarSummary(ff)
d = ff->d                            
printVarSummary(d)	                          

d1=new((/time1,13,361,321/),"float")          
do x=0,177-1
	do j=0,time1-1
			if(time(j).eq.x) then
				d1(j,:,:,:)=d(x,:,:,:)
			end if
	end do
end do
printVarSummary(d1)
;print(var1(0,0,0:10))
delete(d)


; ;--------------------------------------------------------------------------

t = ff->t                         
printVarSummary(t)	                          

t1=new((/time1,13,361,321/),"float")          
do x=0,177-1
	do j=0,time1-1
			if(time(j).eq.x) then
				t1(j,:,:,:)=t(x,:,:,:)
			end if
	end do
end do
printVarSummary(t1)
;print(var1(0,0,0:10))
delete(t)


;--------------------------------------------------------------------------

z = ff->z                     

printVarSummary(z)	                          

z1=new((/time1,13,361,321/),"float")          
do x=0,177-1
	do j=0,time1-1
			if(time(j).eq.x) then
				z1(j,:,:,:)=z(x,:,:,:)
			end if
	end do
end do
printVarSummary(z1)
;print(var1(0,0,0:10))
delete(z)


; ;--------------------------------------------------------------------------

u = ff->u                       

printVarSummary(u)	                          

u1=new((/time1,13,361,321/),"float")           
do x=0,177-1
	do j=0,time1-1
			if(time(j).eq.x) then
				u1(j,:,:,:)=u(x,:,:,:)
			end if
	end do
end do
printVarSummary(u1)
;print(var1(0,0,0:10))
delete(u)
;--------------------------------------------------------------------------


v = ff->v                       

printVarSummary(v)	                          

v1=new((/time1,13,361,321/),"float")           
do x=0,177-1
	do j=0,time1-1
			if(time(j).eq.x) then
				v1(j,:,:,:)=v(x,:,:,:)
			end if
	end do
end do
printVarSummary(v1)
;print(var1(0,0,0:10))
delete(v)

;--------------------------------------------------------------------------

w = ff->w                         

printVarSummary(w)	                          

w1=new((/time1,13,361,321/),"float")            
do x=0,177-1
	do j=0,time1-1
			if(time(j).eq.x) then
				w1(j,:,:,:)=w(x,:,:,:)
			end if
	end do
end do
printVarSummary(w1)
;print(var1(0,0,0:10))
delete(w)
;-----------------------------------------------------------------------


q = ff->q                        

printVarSummary(q)	                          

q1=new((/time1,13,361,321/),"float")           
do x=0,177-1
	do j=0,time1-1
			if(time(j).eq.x) then
				q1(j,:,:,:)=q(x,:,:,:)
			end if
	end do
end do
printVarSummary(q1)
;print(var1(0,0,0:10))
delete(q)
;------------------------------------------------------------------

r = ff->r                           
printVarSummary(r)	                          

r1=new((/time1,13,361,321/),"float")           
do x=0,177-1
	do j=0,time1-1
			if(time(j).eq.x) then
				r1(j,:,:,:)=r(x,:,:,:)
			end if
	end do
end do
printVarSummary(r1)
;print(var1(0,0,0:10))
delete(r)

;------------------------------------------------------------------
vo = ff->vo                           
printVarSummary(vo)	                          

vo1=new((/time1,13,361,321/),"float")          
do x=0,177-1
	do j=0,time1-1
			if(time(j).eq.x) then
				vo1(j,:,:,:)=vo(x,:,:,:)
			end if
	end do
end do
printVarSummary(vo1)
;print(var1(0,0,0:10))
delete(vo)


;------------------------------------------------
setfileoption("nc","Format","NetCDF4Classic")               
;This allows us to save a variable larger than 2GB gracefully.
fout=addfile("svd22_6.nc","c")
fout@creation_date:= systemfunc("date")
fout->u=u1    
fout->v=v1 
fout->z=z1 
fout->t=t1
fout->d=d1
fout->q=q1 
fout->w=w1 
fout->vo=vo1 
fout->r=r1 
b=fout
printVarSummary(b)
delete([/fout,b/])
delete([/u1,v1,z1,t1,d1,q1,w1,vo1,r1/])



end