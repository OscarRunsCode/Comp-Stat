# linear disciminate analysis

# import numpy as np

from numpy import *
from matplotlib import pyplot
import scipy.linalg as syl


random.seed(0)  #fixed seed

n, m, k = 2, 3, 20

X = zeros((n,m,k))
for i in range(0,n):
    for j in range(0,m):
        for r in range(0,k): 
            X[i,j,r] = random.standard_normal()+i+4*j

# plot X
pyplot.close("all")
pyplot.figure(1)
cr = 'brgcy'
for j in range(0,m):
    for r in range(0,k):
        pyplot.plot(X[0,j,r], X[1,j,r], 'o', color = cr[j-1])

pyplot.axis([-1,11,-1, 11])
pyplot.axis('equal')

        
# compute mean in each class
mu = zeros((n,m))
for i in range(0,n):
    for j in range(0,m):
        mu[i,j] = mean(X[i,j,:]) 

mu = mat(mu)

# compute total mean
MU = mean(mu, axis=1)

# compute between-class and within-class scatter matrices

S_B = zeros((n, n))
for j in range(0,m):
    S_B = S_B + (mu[:,j] - MU)*(mu[:,j] - MU).T 

S_W = zeros((n, n))
for j in range(0,m):
    for r in range(0,k):
        temp = mat(X[:,j,r]).T - mu[:,j]
        S_W = S_W + temp*temp.T

# compute U
W, U = syl.eig(S_B, S_W)
U1 = U[:,1] # take the component woth largest eigenvalue

# projection to Z
Z = zeros((m,k))
for j in range(0,m):
    for r in range(0,k):
        Z[j,r] = sum(U1*X[:,j,r])

# plot Z
pyplot.figure(2);
for j in range(0,m):
    pyplot.plot(range(1,k+1), Z[j], 'o', color = cr[j-1])

pyplot.show()





