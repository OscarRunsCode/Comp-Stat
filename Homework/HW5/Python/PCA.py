# principal component analysis

from numpy import *
from matplotlib import pyplot
import scipy


x = mat(" \
68    69; \
72    71; \
73    71; \
70    71; \
72    69; \
69    68; \
75    73; \
72    67; \
69    72; \
69    68; \
75    73; \
64    63; \
69    72; \
73    73; \
78    75; \
70    72; \
72    69; \
65    67; \
71    70; \
69    70; \
71    73; \
68    64; \
69    72; \
75    74; \
75    75")

x = x.T

#### Perform the PCA analysis ###
m, n = shape(x) 

# 1. Compute sample covariance
C = cov(x)

# 2. SVD on C
U, S, Vh = linalg.svd(C)
V = Vh.T

# 3. select the first 2 columns of U
U1 = U[:,0:2]

# 4. Define Z 
Z = U1.T*x;

## plot the raw data
pyplot.figure(1)
pyplot.plot(x[0,:], x[1,:], 'b.')
pyplot.axis([60, 80, 60, 80])
pyplot.axis('equal')
pyplot.xlabel('Father Height (in)')
pyplot.ylabel('Son Height (in)');  


## plot the transformed data
pyplot.figure(2)
pyplot.plot(Z[0,:], Z[1,:], 'b.')
pyplot.axis([-110, -85, -1, 6])
pyplot.axis('equal')
pyplot.xlabel('Principal Component 1')
pyplot.ylabel('Principal Component 2')

## add the principal directions
pyplot.figure(1)
m_x = x.mean(axis=1)
TP1 = array(2*sqrt(S[0])*mat([-U[0, 0], U[0, 0]])+m_x[0])
TP2 = array(2*sqrt(S[0])*mat([-U[1, 0], U[1, 0]])+m_x[1])
TP3 = array(2*sqrt(S[1])*mat([-U[0, 1], U[0, 1]])+m_x[0])
TP4 = array(2*sqrt(S[1])*mat([-U[1, 1], U[1, 1]])+m_x[1])      
pyplot.plot(TP1[0], TP2[0], 'g-')
pyplot.plot(TP3[0], TP4[0], 'g-')  

pyplot.show()

## compare the covariance and the total variance
Cov_x = cov(x)
Cov_Z = cov(Z)
Total_var_x = trace(Cov_x)
Total_var_Z = trace(Cov_Z)

#print('total_var_x = ' + repr(Total_var_x), 'total_var_z = ' + repr(Total_var_Z))

print('total_var_x = %5.2f' %Total_var_x, 'total_var_Z = %5.2f' %Total_var_Z) 


