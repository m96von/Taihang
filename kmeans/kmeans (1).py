#!/usr/bin/env python
# coding: utf-8

# In[ ]:


from sklearn.cluster import KMeans
from sklearn import metrics
import os
import xarray as xr
import pandas as pd
import numpy as np
from datetime import timedelta
import matplotlib.pyplot as plt

def calscore(var,n,N):
    score_=[]
    for num in range(2,N):
        kms=KMeans(n_clusters=num,random_state=n).fit(var)
        labels = kms.labels_
        score_.append(metrics.silhouette_score(var,labels,metric='euclidean'))
    fig=plt.figure(figsize=(8,4))
    ax= plt.subplot(122)
    plt.xticks(np.arange(1,N+1,1))
    ax.plot(np.arange(2,N),score_)
    ax.scatter(np.arange(2,N),score_,s=5)
    ax.set_title('Silhouette score   '+str(n))  
    
    inertia = []
    for k in range(1,N):
        kmeans = KMeans(n_clusters=k,random_state=n).fit(var)
        inertia.append(kmeans.inertia_)
    ax= plt.subplot(121)
    plt.xticks(np.arange(1,N+1,1))
    ax.plot(np.arange(1,N),inertia)
    ax.scatter(np.arange(1,N),inertia,s=5)
    ax.set_title('Elbow')
    plt.savefig('test/55-25'+str(n)+'.png')
    plt.close()

    
    
climated=xr.open_dataset('climate19912020.nc')['t'].loc[:,300,35:38.5,113:115]
climate=np.mean(climated,axis=0)

data=xr.open_dataset('T.nc')['t'].loc[:,300,35:38.5,113:115]
datat=list(data)[1][1]
print(climate.shape)

t=datat-climate
lat=t['latitude']
lon=t['longitude']
timesd=t['time']

t2d=t.data.reshape(9,-1)


# for n in range(50):  随机数
#      calscore(t2d,n,15)


rdm=6   # 选6
k_optimal=4
kms = KMeans(n_clusters=k_optimal,random_state=rdm).fit(t2d)
res= kms.predict(t2d)

cluster=list(range(k_optimal))
ncluster=np.zeros((k_optimal))
for n,g in enumerate(res):
    ddtt=t2d[n].reshape(len(lat),len(lon))
    if ncluster[g]==0: 
        cluster[g]=[list(ddtt)]
    else: 
        cluster[g].append(ddtt)
    ncluster[g]=ncluster[g]+1


# In[ ]:




