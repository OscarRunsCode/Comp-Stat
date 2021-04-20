clear
clc
%Problem 1
fprintf("-----Problem 1-----");
X=[6 3 9 2; 0 4 6 1; 0 0 8 8; 0 0 0 5] %Defining X
y=[1; 4; 6; 1]  %Defining y
b=backsub(X,y)  %Running the backsub function
%The backsub function is:
% 	function b = backsub(X,y)
% 	l = size(X);
% 	n = l(2);
% 	b(n, 1) = y(n, 1)/X(n, n);
% 	for j = n - 1 : -1 : 1
% 		b(j, 1) = (y(j, 1) - X(j, j + 1 : n) * b(j + 1 : n, 1))/X(j, j);
% 	end

%Problem 2
fprintf("-----Problem 2-----");
x=[1.4 5.8 2.3 8.1 9]'   %Defining x
v=house(x)   %running the house function with v as output
%The house function is:
% 	function v = house(x)
% 	m = length(x);
% 	mu = norm(x,2);
% 	v = x;
% 	if mu ~= 0
% 		c = x(1) + sign(x(1))*mu;
% 		v(2 : m, 1) = v(2 : m, 1)/c;
% 	end
% 	v(1) = 1;

%Problem 3
fprintf("-----Problem 3-----");
x=[1.4 5.8 2.3 8.1 9]';  %Defining x
v=house(x)   %running the house function
X=[1.4 4.5 6.5; 5.8 3.2 7.3; 2.3 -2.6 8.2; 8.1 -5.8 -8.0; 9.0 0.3 1.5]
XHouse=rowhouse(X,v)
