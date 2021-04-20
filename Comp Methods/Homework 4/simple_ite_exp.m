% sample code for the simple iterations

clear; 

% define the function
f = inline('0.9*cos(x)', 'x');

% plot the function
t = 0:0.01:pi;
yt = f(t);
figure(1);
plot(t,yt);
hold on;
plot([0 pi], [0 0], 'r');


%%% Simple iterations
x0 = 0.3;

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



