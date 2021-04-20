function X = rowhouse(x,v)
beta = -2/(v'*v);
w = beta*x'*v;
X = x+v*w';