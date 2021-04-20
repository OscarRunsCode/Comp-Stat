clear
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = 100; 
x = [6 52 28 14];

% EM procedure
alpha0 = 0.5;  % initial guess

alpha(1) = alpha0;
nth = 2*(alpha(1)/(2+alpha(1))*x(2)+2*x(1)+x(4))/(4*(alpha(1)/(2+alpha(1))*x(2)+4*x(1)-x(3)+2*x(4)));
i = 1;
while (abs(alpha(i)-nth)>1e-6)
    nth = alpha(i);
    alpha(i+1) =  2*(alpha(i)/(2+alpha(i))*x(2)+2*x(1)+x(4))/...
                      (4*(alpha(i)/(2+alpha(i))*x(2)+4*x(1)-x(3)+2*x(4)));
    i = i+1;
end

% plot the estimate
figure(1)
subplot(211);
plot(alpha, 'b-*');

% compute the log-likelihood
K = length(alpha);
for k = 1:K
    ll(k) = x(1)*log(2+alpha(k)) + (x(2)+x(3))*log(1-alpha(k)) + x(4)*log(alpha(k));
end

% plot the log-likelihood
subplot(212);
plot(ll, 'ro-');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear

load ('hw5_2.mat')

figure(2)
hist(Y1)
xlabel('Values')
ylabel('frequency')

figure(3)
hist(Y2)
xlabel('Values')
ylabel('frequancy')

n = 500; 

x=Y1;

% EM procedure
alpha0 = 0.5;  % initial guess

alpha(1) = alpha0;
syms i
nth =  (alpha(1)/(2+alpha(1))*x(2)+2*x(1)+x(4))/(4*(alpha(1)/(2+alpha(1))*x(2)+4*x(1)-x(3)+2*x(4)));
i = 1;
while (abs(alpha(i)-nth)>1e-6)
    nth = alpha(i);
    alpha(i+1) =  2*(alpha(i)/(2+alpha(i))*x(2)+2*x(1)+x(4))/...
                      (4*(alpha(i)/(2+alpha(i))*x(2)+4*x(1)-x(3)+2*x(4)));
    i = i+1;
end

% plot the estimate
figure(4)
subplot(211);
plot(alpha, 'b-*');

% compute the log-likelihood
K = length(alpha);
for k = 1:K
    ll(k) = x(1)*log(2+alpha(k)) + (x(2)+x(3))*log(1-alpha(k)) + x(4)*log(alpha(k));
end

% plot the log-likelihood
subplot(212);
plot(ll, 'ro-');