#!/usr/bin/env python
# coding: utf-8

# In[3]:


## congruential generator exp
from numpy import *
from matplotlib import pyplot


m = 2**13-1
a = 17

N = 500
x = zeros(N)
x[0] = 1

for k in range(1,N):
    x[k] = mod(a*x[k-1],m)
    
u1 = x/m
u2 = u1[1:N]

# plot the estimate
pyplot.subplot(211)
pyplot.hist(u1,10)
pyplot.xlim(0, 1)
pyplot.ylim(0, 75)
pyplot.subplot(212)
pyplot.plot(u1[0:N-1], u2, '*')


pyplot.show()


# In[2]:


## congruential generator exp
from numpy import *
from matplotlib import pyplot


m = 2**13-1
a = 85

N = 500
x = zeros(N)
x[0] = 1

for k in range(1,N):
    x[k] = mod(a*x[k-1],m)

u1 = x/m
u2 = u1[1:N]

# plot the estimate
pyplot.subplot(211)
pyplot.hist(u1,10)
pyplot.xlim(0, 1)
pyplot.ylim(0, 75)
pyplot.subplot(212)
pyplot.plot(u1[0:N-1], u2, '*')

pyplot.show()


# In[19]:


from numpy import *
from matplotlib import pyplot

del x
m = 2**13-1
a = 85

N = 1000
x = zeros(N)
x[0] = 1

for k in range(1,N):
    x[k] = mod(a*x[k-1],m)

y = x/m


def weib_inv(y,a,b):
    return (-log(1 - y) / a)**(1 / b)

X = weib_inv(y, 1, 0.5)
pyplot.hist(X,100)
pyplot.xlim(0, 75)
pyplot.ylim(0, 550)


# In[ ]:




