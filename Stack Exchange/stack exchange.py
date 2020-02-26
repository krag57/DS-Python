#!/usr/bin/env python
# coding: utf-8

# In[8]:


import json
import numpy as np
from sklearn.linear_model import SGDClassifier
from sklearn.feature_extraction.text import TfidfVectorizer

f = open('training.json','r',encoding="utf8")
N = int(f.readline())
y_train=[]
train=[]
topic_list=[]
for line in f:
    j = json.loads(line)
    topic = (j['topic'])
    if topic in topic_list:
        topic_index = topic_list.index(topic)
    else:
        topic_list.append(topic)
        topic_index = topic_list.index(topic)
    y_train.append(topic_index)
    y_train.append(topic_index)
    train.append(j['question'])
    train.append(j['excerpt'])


# In[14]:


topic_list


# In[10]:


test=[]
N = int(input())
for i in range(N):
    j = json.loads(input())
    test.append(j['question'])+ " " + j['excerpt'])

    
v = TfidfVectorizer(sublinear_tf=True,analyzer = 'word', max_df = 0.1, ngram_range=(1,2),stop_words="english")
X_train = v.fit_transform(train)
X_test = v.transform(test)

clf_hinge = SGDClassifier(loss='hinge', alpha=.00002, max_iter=30, penalty="l2").fit(X_train, y_train)
predictions = clf_hinge.predict(X_test)

for i in predictions:
    print(topic_list[i])


# In[13]:





# In[ ]:




