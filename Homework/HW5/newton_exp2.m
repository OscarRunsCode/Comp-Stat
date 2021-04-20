% example for Newton-Raphson method for 2D case

clear; close all;

h = inline('sin(2*x+y)+2*cos(x-2*y)+0.1*(x+y)', 'x', 'y');

dhx = inline('2*cos(2*x+y) - 2*sin(x-2*y) + 0.1', 'x', 'y');
dhy = inline('cos(2*x+y) + 4*sin(x-2*y) + 0.1', 'x', 'y');

ddhxx = inline('-4*sin(2*x+y) - 2*cos(x-2*y)', 'x', 'y');
ddhyy = inline('-sin(2*x+y) - 8*cos(x-2*y)', 'x', 'y');
ddhxy = inline('-2*sin(2*x+y) + 4*cos(x-2*y)', 'x', 'y');


X = -2:0.005:2;
Y = -2:0.005:2;
for i = 1:length(X)
    Z(:,i) = h(X(i),Y);
end

figure(1);
mesh(X,Y,Z);
xlabel('x', 'fontsize', 14);
ylabel('y', 'fontsize', 14);
zlabel('h(x, y)', 'fontsize', 14); 

figure(2);
contour(X,Y,Z);
xlabel('x', 'fontsize', 14);
ylabel('y', 'fontsize', 14);
colorbar; 

%%% Newtwon-Raphson
x0 = [-1,0.5]';

x(:,1) = x0;

gx = x(:,1)+1;

i = 1;
while (norm(x(:,i) - gx) > 1e-6)
    gx = x(:,i);
    
    GRD = [dhx(x(1,i), x(2,i)), dhy(x(1,i), x(2,i))]';

    H = [ddhxx(x(1,i), x(2,i)), ddhxy(x(1,i), x(2,i)); ...
         ddhxy(x(1,i), x(2,i)), ddhyy(x(1,i), x(2,i));];    
    
    x(:,i+1) = x(:,i) - inv(H)*GRD;
    i = i+1;
end

figure(2);
hold on;
plot(x(1,:), x(2,:),'ro');
set(gca, 'fontsize', 20);
