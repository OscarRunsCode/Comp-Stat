function b = backsub(x,y)
l = size(x);
n = l(2);
b(n,1) = y(n,1)/x(n,n);
for j = n-1:-1:1
    b(j,1) = (y(j,1)-x(j,j+1:n)*b(j+1:n,1))/x(j,j);
end