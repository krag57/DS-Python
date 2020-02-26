#!/usr/bin/env python
# coding: utf-8

# In[106]:


from random import choices
inp = int(input())
inputList = []
proList=[]
n_lsList=[]
ladList=[]
snaList=[]
for k in range(inp):
    pro = input().split(",")
    proList.append(pro)
    n_ls = input().split(",")
    n_lsList.append(n_ls)
    lad = input().split()
    ladList.append(lad)
    sna = input().split()
    snaList.append(sna)

Listcount=[]
for i in range(inp):
    tcount=[]
    for j in range(5000):
        lis=[]
        lis.extend(s.split(",") for s in (ladList[i]))
        st_la=[int(s[0]) for s in lis ]
        end_la=[int(s[1]) for s in lis ]
        lis1=[]
        lis1.extend(s.split(",") for s in (snaList[i]))
        st_sn=[int(s[0]) for s in lis1 ]
        end_sn=[int(s[1]) for s in lis1 ]
        weights=[float(s) for s in (proList[i])]
        pos=1
        count=0
        while pos!=100:
            step=choices([1, 2, 3, 4, 5, 6], weights)
            step1=int(str(step).strip('[]'))
            pos=pos+step1
            count+=1
            if pos in st_la:
                pos=end_la[st_la.index(pos)]
            if pos in st_sn:
                pos=end_sn[st_sn.index(pos)]
            if pos>100:
                pos=pos-step1
        tcount.append(count)
    avg= sum(tcount)/5000   
    Listcount.append(tcount)
    print(round(avg))

#print([round(sum(s)/5000) for s in Listcount])

