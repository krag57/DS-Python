#!/usr/bin/env python
# coding: utf-8

# In[27]:


n= int(input())
#scoreList=[]
#occur={}
score=list(map(int,input().split()))
#scoreList.append(score)
score.sort()
def mean(score):
    return round(sum(score)/n,1)

def median(score):
    if n%2!=0:
        return score[int((n+1)/2)-1]
    else:
        return (score[int(n/2)-1]+score[int((n/2)+1)-1])/2
    
def mode(score):
    freList=[score.count(sc) for sc in score]
    mo=score[freList.index(max(freList))]
    return mo

def sd(score):
    sss=[(i-mean(score))**2 for i in score]
    return round(((sum(sss)/n)**0.5),1)

def ci(score):
    up=round(mean(score)+1.96*(sd(score)/n**0.5),1)
    lo=round(mean(score)-1.96*(sd(score)/n**0.5),1)
    return[lo,up]

print(mean(score))
print(median(score))    
print(mode(score))
print(sd(score))
print(*ci(score))


# In[11]:


score


# In[23]:


ci(score)


# In[17]:


1.96*sd(score)+mean(score)


# In[79]:


n/2


# In[39]:


sss


# In[41]:


((sum(sss)/5)**0.5)


# In[ ]:




