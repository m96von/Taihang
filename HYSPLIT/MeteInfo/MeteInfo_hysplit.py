import calendar
import os
import datetime
import miutil
# Set working directory
metDir = 'E:\gdas_data'
outDir = 'E:\hysplit/temp'
workingDir = 'C:\hysplit/working'
os.chdir(workingDir)
print ('Current directory: ' + os.getcwd())

# Set parameters
lon = '114.6'
lat = '37'
shour = '06'
heights = ['100.0','500.0','1000.0']
hnum = len(heights)
hours = '-48'
vertical = '0'
top = '10000.0'

# Get meteorological data files by time
def getmeteofiles(t):
    ystr = t.strftime('%y')
    mdir = metDir + '/%s' % t.strftime('%Y')
    mmm = datetime.dateformat(t, 'MMM', 'us_en').lower()
    mdirs = []
    fns = []
    # The meteo files of this month
    for i in range(1,6):
        fn = 'gdas1.' + mmm + ystr + '.w' + str(i)
        if os.path.exists(os.path.join(mdir, fn)):
            mdirs.append(mdir)
            fns.append(fn)

    # The last two meteo files of last month
    days = calendar.monthrange(t.year, t.month)[1]
    t = t - datetime.timedelta(days=days)
    ystr = t.strftime('%y')
    mdir = metDir + '/%s' % t.strftime('%Y')
    mmm = miutil.dateformat(t, 'MMM', 'us_en').lower()
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

# Set start/end time
stime = datetime.datetime(2014,8,1)
etime = datetime.datetime(2014,9,1)

# Loop
ctFile = './CONTROL'
while stime < etime:
    print (stime.strftime('%Y-%m-%d ') + shour + ':00')
    ctf = open(ctFile, 'w')
    ctf.write(stime.strftime('%y %m %d ') + shour + "\n")
    ctf.write(str(hnum) + '\n')
    for j in range(0,hnum):
        ctf.write(lat + ' ' + lon + ' ' + heights[j] + '\n')
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
    outfn = stime.strftime('traj_%Y%m%d')
    ctf.write(outfn)
    ctf.close()
    os.system('c:/hysplit4/exec/hyts_std.exe')

    stime = stime + datetime.timedelta(days=1)

print ('Finish...')