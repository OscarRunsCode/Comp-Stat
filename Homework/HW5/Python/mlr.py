# backward substitution and all other files


from numpy import *
set_printoptions(precision=2)

X = mat("1. 2. 3.; 0. 3. 2.; 0. 0. 1.")
y = mat(" 2.; 4.; 5.")

# X = mat("2. 3. 4.; 8. 3. 2.; 9. 3. 3.; 0. 1. 2.")
# y = mat(" 4.; 3.; 2.; 1.")


def backsub(X, y):
    l = shape(X)  
    n = l[1]
    b = zeros((n,1))
    b[n-1, 0] = y[n-1, 0]/X[n-1, n-1]
    for j in range(n-1,0,-1):
        b[j-1,0] = (y[j-1,0] - dot(X[j-1, range(j,n)], b[range(j,n),0]))/X[j-1, j-1]
    return b


def house(x):
    m = size(x)
    mu = linalg.norm(x)
    v = x.copy()
    if mu != 0:
        c = x[0] + sign(x[0])*mu
        v[1:m+1] = v[1:m+1]/c
    v[0] = 1
    return v


def rowhouse(X,v):
    X = mat(X)
    v = mat(v)
    X = X - 2*v*v.T/(v.T*v)*X
    return X


def householder(X0):
    X = mat(X0.copy())
    m, n = shape(X)
    v = mat(zeros((m,1)))
    for j in range(1, n+1):
        v[j-1:m] = house(X[j-1:m,j-1])
        X[j-1:m,j-1:n] = rowhouse(X[j-1:m,j-1:n], v[j-1:m])
    return X


def multilinreg(X0,y0):
    X = X0.copy()
    y = y0.copy()
    m, n = shape(X0)
    for j in range(1,n+1):
        v = house(X[j-1:m,j-1])
        X[j-1:m,j-1:n] = rowhouse(X[j-1:m,j-1:n], v)
        beta = -2.*(v.T*y[j-1:m])/(v.T*v)
        y[j-1:m] = y[j-1:m] + v*beta

    b = backsub(X,y)
    return b
        
