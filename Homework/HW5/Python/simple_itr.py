# simple iteration and Netwon-Raphson

from numpy import *
from matplotlib import pyplot
set_printoptions(precision=4)

# define the function
f = lambda x: 0.9*cos(x)

# simple iteration
x0 = 0.3

x = zeros(10)
x[0]=  x0
gx = f(x[0]) + x[0]
i = 0

while abs(x[i] - gx) > 1e-6:
    gx = x[i]
    x[i+1] = f(x[i]) + x[i]
    i = i + 1

# plot the function
t = arange(0, pi, 0.01)
yt = f(t)

pyplot.figure(1)
pyplot.plot(t, yt, 'go')
pyplot.plot((0, pi), (0, 0), 'r')

pyplot.figure(2)
pyplot.plot(range(0,i+1), x[0:i+1], 'b-')

pyplot.show()


