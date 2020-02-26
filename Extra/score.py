#!/usr/bin/env python
# coding: utf-8

# In[21]:


n= int(input())
scoreList=[]
for i in range(n):
    score=int(input())
    scoreList.append(score)
l= int(input())
loList=[]
for i in range(l):
    lower=int(input())
    loList.append(lower)

u=int(input())
upList=[]
for i in range(u):
    upper=int(input())
    upList.append(upper)

ocList=[]
coList=[]
for k in range(len(loList)):
    occur=[j for i,j in enumerate(scoreList) if j>=loList[k] and j<=upList[k] ]
    ocList.append(occur)
    coList.append(len(occur))
    
print(*coList, sep="\n")#print("\n".join(str(loList)))

