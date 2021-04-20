function b = multilinreg(x,y)
[m,n] = size(x);
for j = 1:n
    v(1:m,1) = zeros(m,1);
    v(j:m,1) = house(x(j:m,j));
    X(j:m,j:n) = rowhouse(x(j:m,j:n),v(j:m));
    beta = -2*(v(j:m)'*y(j:m))/(v(j:m)'*v(j:m));
    y(j:m) = y(j:m)+beta*v(j:m);
end
b = backsub(x,y);