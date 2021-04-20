% sample code for the newton-raphson method

clear; 

% define the function
f = inline('x.^3 - 9*x.^2 + 2*x + 7', 'x');

% plot the function
t = -4:0.1:12;
yt = f(t);
figure(1);
subplot(211);
plot(t,yt, '-');
hold on;
plot([-4 12], [0 0], 'r');
grid on;
set(gca, 'fontsize', 20);

%%% Newtwon-Raphson
x0 = 1;

df = inline('3*x.^2 -18*x + 2', 'x');

clear x; 
x(1) = x0;
gx = x(1)-f(x(1))/df(x(1));
i = 1;
while (abs(x(i) - gx) > 1e-6)
    gx = x(i);
    x(i+1) = x(i) - f(x(i))/df(x(i));
    i = i+1;
end
figure(1);
subplot(212);
plot(x,'r');
set(gca, 'fontsize', 20);


