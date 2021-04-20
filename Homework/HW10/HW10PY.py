import numpy as np
from matplotlib import pyplot
import random

#-----------------------------Problem 4----------------------------------
print('Problem 4')
random.seed(1)
n = 10**7
K = 10
lm = 1/3
x = np.zeros((n,K))
theta = np.zeros((1,10))
num = np.zeros((1,10))
den = np.zeros((1,10))


for j in range(K):
    x[:,j] = np.array( [random.expovariate(1/lm) for x in range(n)] )
    if j == 0:
        num[0,j] =  np.mean( x[:,0]*np.exp( -0.5*(0.5-x[:,0])**2 )/3 )
        den[0,j] = np.mean( np.exp( -0.5*(0.5-x[:,0])**2 )/3 )
        theta[0,j] = num[0,j]/den[0,j]
    else:
        num[0,0:j+1] =  np.mean( x[:,0:j+1]*np.exp( -0.5*(0.5-x[:,0:j+1])**2 ) )
        den[0,j] = np.mean( np.exp( -0.5*(0.5-x[:,0:j+1])**2 ) )
        theta[0,j] = num[0,j]/den[0,j]
    
t = range(0,K)
#Plot
pyplot.plot(t, theta[0,:], 'b');
pyplot.title('Estimate of Theta');
pyplot.subplots_adjust(hspace=1,wspace=0.5);
pyplot.figure(num=1, figsize=(10, 10), dpi=140, facecolor='w', edgecolor='k');
pyplot.xlabel('Iteration K (Sample Size for each iteration is K*10^7)');
pyplot.ylabel('Estimate of Theta');
pyplot.show();


import numpy as np
from matplotlib import pyplot
import random

#-----------------------------Problem 5----------------------------------
print('Problem 5')
random.seed(1)
K = 5
i = 0
mu = np.zeros((3,5))

for y in range(3,8,2):
    print(y)
    n = 10**y
    if i == 3:
        i = 0
    for a in range(K):
        print(a)
        s = a+1
        x = np.array( [random.normalvariate(a+1,1) for x in range(n)] )
        mu[i,a] = np.mean( (x > s)*np.exp(0.5*s**2 - s*x ) )
    i = i+1

for a in range(K):
    #Plot
    t = range(0,3)
    s = a+1
    pyplot.subplot(3,2,a+1);
    pyplot.plot(t, mu[:,a], 'o-');
    pyplot.title('a = %i' %s);
    #pyplot.subplots_adjust(hspace=1,wspace=0.5);
    #pyplot.figure(num=2, figsize=(10, 10), dpi=140, facecolor='w', edgecolor='k');
    pyplot.xlabel('log_10(n)');
    pyplot.show();
