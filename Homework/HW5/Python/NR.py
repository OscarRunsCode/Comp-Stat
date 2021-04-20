# simple iteration and Netwon-Raphson

from numpy import *
from matplotlib import pyplot

# define the function
f = lambda x: x**3 - 9*x**2 + 2*x + 7
df = lambda x: 3*x**2 - 18*x + 2

# Newton-Raphson
x0 = 1

x = zeros(100)
x[0]=  x0
gx = x[0] - f(x[0])/df(x[0])
i = 0
while abs(x[i] - gx) > 1e-6:
    gx = x[i]
    x[i+1] = x[i]- f(x[i])/df(x[i])
    i = i + 1

# plot the function
t = arange(-4, 12, 0.1)
yt = f(t)

pyplot.subplot(211)
pyplot.plot(t, yt, 'go')
pyplot.plot((-4, 12), (0, 0), 'r')
pyplot.grid(True)
pyplot.subplot(212)
pyplot.plot(range(0,i+1), x[0:i+1], 'b-')

pyplot.show()





