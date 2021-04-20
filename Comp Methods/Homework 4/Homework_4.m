clear
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f = inline ('0.9*sin(x)-x', 'x');
fprime = inline ('0.9*cos(x)-1', 'x');

% plot the function
t = -4:0.1:12;
yt = f(t);
figure(1);
plot(t,yt, '-');
hold on;
plot([-4 12], [0 0], 'r');
grid on;

%%% Newtwon-Raphson
x0 = pi/4;

clear x; 
x(1) = x0;
gx = x(1)-f(x(1))/fprime(x(1));
i = 1;
while (abs(x(i) - gx) > 1e-6)
    gx = x(i);
    x(i+1) = x(i) - f(x(i))/fprime(x(i));
    i = i+1;
end
figure(2); 
plot(x,'r');

% plot the function
t = 0:0.01:pi;
yt = f(t);
figure(1);
plot(t,yt);
hold on;
plot([0 pi], [0 0], 'r');


%%% Simple iterations
x0 = pi/4;

x(1) = x0;
gx = f(x(1))+x(1);
i = 1;
while (abs(x(i) - gx) > 1e-6)
    gx = x(i);
    x(i+1) = f(x(i)) + x(i);
    i = i+1;
end
figure(2);
plot(x); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define the function
f = inline('x.^5-4.5*x.^4+4.55*x.^3+2.675*x.^2-3.3*x-1.4375', 'x');
fprime = inline('5*x.^4-18*x.^3+3*4.55*x.^2+2*2.675*x-3.3', 'x');

% plot the function
t = -4:0.1:12;
yt = f(t);
%figure(1);
%plot(t,yt, '-');
%hold on;
%plot([-4 12], [0 0], 'r');
%grid on;

%%% Newtwon-Raphson
x0 = -0.6;

clear x; 
x(1) = x0;
gx = x(1)-f(x(1))/fprime(x(1));
i = 1;

while (abs(x(i) - gx) > 1e-6)
    gx = x(i);
    x(i+1) = x(i) - f(x(i))/fprime(x(i));
    i = i+1;
end
%figure(2); 
%plot(x,'r');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
load('hw4_3_data.mat');

f = inline('(exp(-(X-theta)))/(1+exp(-(X-theta))).^2', 'X');

[m,n] = size(X);
syms X(i);
l(theta) = symsum(log(f(X(i))),1,n) 

