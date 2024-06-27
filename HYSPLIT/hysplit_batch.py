# -*- coding: utf-8 -*-
"""
Created on Wed Oct 26 19:38:28 2022

@author: 15651
"""
import calendar
import os
import datetime
import numpy as np

# Set working directory

outDir = 'E:\\hysplit\\new\\tu1'
latDir = 'C:\\Users\\15651\\Desktop\\Taihang\\177\\hysplit\\tu1\\slat1.txt'
lonDir = 'C:\\Users\\15651\\Desktop\\Taihang\\177\\hysplit\\tu1\\slon1.txt'
hourDir = 'C:\\Users\\15651\\Desktop\\Taihang\\177\\hysplit\\tu1\\shour.txt'
timeDir = 'C:\\Users\\15651\\Desktop\\Taihang\\177\\hysplit\\tu1\\stime.txt'
n = 215
#------------------------------------------------------------------------------
# outDir = 'E:\\hysplit\\new\\tu2'
# latDir = 'C:\\Users\\15651\\Desktop\\Taihang\\177\\hysplit\\tu2\\slat1.txt'
# lonDir = 'C:\\Users\\15651\\Desktop\\Taihang\\177\\hysplit\\tu2\\slon1.txt'
# hourDir = 'C:\\Users\\15651\\Desktop\\Taihang\\177\\hysplit\\tu2\\shour.txt'
# timeDir = 'C:\\Users\\15651\\Desktop\\Taihang\\177\\hysplit\\tu2\\stime.txt' 
# n = 165
#------------------------------------------------------------------------------
#GDAS1 file
metDir = 'E:\gdas_data'
#hysplit                    
workingDir = 'C:\hysplit\working'                   
os.chdir(workingDir)
print ('Current directory: ' + os.getcwd())

#------------------------------------------------------------------------------
# Get GDAS1 meteorological data files by time
def getmeteofiles(t):
    ystr = t.strftime('%y')
    mdir = metDir + '/%s' % t.strftime('%Y')
    mmm = calendar.month_abbr[int(t.strftime('%m'))].lower()
    #print(mmm)                          
    mdirs = []
    fns = []
    # The meteo files of this month
    for j in range(1,6):
        fn = 'gdas1.' + mmm + ystr + '.w' + str(j)
        if os.path.exists(os.path.join(mdir, fn)):
            mdirs.append(mdir)
            fns.append(fn)

    # The last two meteo files of last month
    days = calendar.monthrange(t.year, t.month)[1]
    t = t - datetime.timedelta(days=days)
    ystr = t.strftime('%y')
    mdir = metDir + '/%s' % t.strftime('%Y')
    mmm = calendar.month_abbr[int(t.strftime('%m'))].lower()
    fn = 'gdas1.' + mmm + ystr + '.w4'
    mdirs.append(mdir)
    fns.append(fn)
    fn = 'gdas1.' + mmm + ystr + '.w5'
    if os.path.exists(os.path.join(mdir, fn)):
        mdirs.append(mdir)
        fns.append(fn)
    else:
        mdirs.append(mdir)
        fns.append('gdas1.' + mmm + ystr + '.w3')

    return mdirs, fns
#------------------------------------------------------------------------------
#格点、时间读取
if __name__ == '__main__':
    with open(latDir, 'r') as f:
        lat = f.readlines()
    lat = [line.strip("\n") for line in lat]

if __name__ == '__main__':
    with open(lonDir, 'r') as f:
        lon = f.readlines()
    lon = [line.strip("\n") for line in lon]
    
if __name__ == '__main__':
    with open(hourDir, 'r') as f:
        hour = f.readlines()
    hour = [line.strip("\n") for line in hour]
    
with open(timeDir) as f:
    line=f.readline()
    data_array=[]
    while line:
        num=list(map(int,line.split(' ')))
        data_array.append(num)
        line=f.readline()
    data_array=np.array(data_array)
    

for i in range(0,n):   #tu1-215,tu2-165
    # Set parameters 起点          
    slat = lat[i]
    slon = lon[i]
    shour = hour[i]
    stime = datetime.datetime(data_array[i,0],data_array[i,1],data_array[i,2])
    print(slat)
    print(slon)
    etime = stime
    #etime = datetime.datetime(2014,8,10)
    
    heights = ['600.0','800.0','1000.0','1400.0','1700.0','2200.0','2600','3000.0','4000.0','4500.0','5000.0','5500.0']
    #print(type(slon),type(stime),type(heights))
    hnum = len(heights)
    hours = '-240'     #后向追踪时间
    vertical = '4'
    top = '10000.0'
    
    # Loop
    ctFile = 'C:\hysplit\working\CONTROL'
    while stime <= etime:
        print (stime.strftime('%Y-%m-%d ') + shour + ':00')
        ctf = open(ctFile, 'w')
        ctf.write(stime.strftime('%y %m %d ') + shour + "\n")
        ctf.write(str(hnum) + '\n')
        for j in range(0,hnum):
            ctf.write(slat + ' ' + slon + ' ' + heights[j] + '\n')
        ctf.write(hours + '\n')
        ctf.write(vertical + '\n')
        ctf.write(top + '\n')
        mdirs, fns = getmeteofiles(stime)
        fnnum = len(fns)
        ctf.write(str(fnnum) + '\n')
        for mdir,fn in zip(mdirs,fns):
            ctf.write(mdir + '/' + '\n')
            ctf.write(fn + '\n')
        ctf.write(outDir + '/' + '\n')
        #outfn = stime.strftime('traj_%Y%m%d') + "_" + slat + "_" + slon
        # outfn = stime.strftime('traj_%Y%m%d') + "_" + str(i+1)
        outfn = stime.strftime('traj') + "_" + str(i)
        ctf.write(outfn)
        ctf.close()
        os.system('C:\hysplit\exec\hyts_std.exe')
    
        stime = stime + datetime.timedelta(days=1)
    
    print ('Finish...')