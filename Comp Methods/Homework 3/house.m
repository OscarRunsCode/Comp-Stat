function v = house(x);
m = length(x);
mu = norm(x,2);
v = x;
if mu ~=0
    c = x(1)+sign(x(1))*mu;
    v(2:m,1) = v(2:m,1)/c;
end
v(1) = 1;