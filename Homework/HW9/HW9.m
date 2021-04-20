clc
clear
%Diary
dfile ='MATLAB_Output_OM.txt';
if exist(dfile, 'file') ; delete(dfile); end
diary(dfile)
diary on

%Introduction
fprintf('----------------------------------------------------------------------\n');
fprintf('\t Oscar Martinez \t HW 9 \t STA 5106\n');
fprintf('----------------------------------------------------------------------\n');

%-----Problem 1:-----
fprintf('-----------Problem 1----------\n');

K = 100; %Iterations
M = 10000; %Sample Size
for i = 1:K;
    rng(i + 10); %Set seed
    x(:,i) = randn(1,M); %Create x_i ~iid~ N(0,1); i = 1,..,M
    y = reshape(x,1,[]); %Reshape for larger means
    mu(i) = mean(y); %Sample Mean
    sig2(i) = mean((y-mu(i)).^2); %Sample Variance
    kurt(i) = mean((y-mu(i)).^4)/(sig2(i)^2); %Sample Kurtosis
    
    %Sample Estimator Variances
    Vmu(i) = sum( ( mu(1:i) - 0 ).^2 )/i; %Var of x bar
    Vsig2(i) = sum( ( sig2(1:i) - 1 ).^2 )/i; %Var of s
    Vkurt(i) = sum( ( kurt(1:i) - 3 ).^2 )/i; %Var of s kurt
end

%Plot
figure(1);
subplot(3,2,1);
plot(1:K, mu);
title('mu');
subplot(3,2,2);
plot(1:K, Vmu);
title('var(mu)');
subplot(3,2,3);
plot(1:K, sig2);
title('sigma^2');
subplot(3,2,4);
plot(1:K, Vsig2);
title('var(sigma^2)');
subplot(3,2,5);
plot(1:K, kurt);
title('kurtosis');
subplot(3,2,6);
plot(1:K, Vkurt);
title('var(kurtosis)');

%-----Problem 2:-----
fprintf('-----------Problem 2----------\n');
clear

K = 100; %Iterations
M = 10000; %Sample Size
for i = 1:K;
    rng(i + 10); %Set seed
    T = 1-exp(-1); %true probability
    
    %MC estimator 1: Exp
    x(:,i) = exprnd(1,1,M); %Create x_i ~iid~ exp(1); i = 1,..,M
    y = reshape(x,1,[]); %Reshape for aggregate mean
    mu1(i) = sum( (y <= 1 & y >= 0) )/size(y,2); %Sample Mean 1
    Vmu1(i) = sum( ( mu1(1:i) - T ).^2 )/i; %Var of x bar 1
    
    %MC estimator 2: Unif
    u(:,i) = rand(1,M); %Create x_i ~iid~ U(0,1); i = 1,..,M
    z = reshape(u,1,[]); %Reshape for aggregate mean
    mu2(i) = sum(exp(-z))/size(z,2); %Sample mean 2
    Vmu2(i) = sum( ( mu2(1:i) - T ).^2 )/i; %Var of xbar 2
end

%Plot
figure(2);
subplot(3,2,1);
plot(1:K, mu1);
title('\mu_1 = 0 \leq e^{-x} \leq 1');
subplot(3,2,2);
plot(1:K, Vmu1);
title('var(\mu_1)');
subplot(3,2,3);
plot(1:K, mu2);
title('\mu_2 = \int e^{-x}   x \sim U(0,1)');
subplot(3,2,4);
plot(1:K, Vmu2);
title('var(\mu_2)');
subplot(3,2,[5,6]);
plot(1:K, mu1, 'b', 1:K, mu2, 'r')
title('\mu_1 vs \mu_2');
legend('\mu_1', '\mu_2','Location', 'southeast');

%-----Problem 3:-----
fprintf('-----------Problem 3----------\n');
clear

K = 100; %Iterations
M = 10000; %Sample Size
    
%Set R.V.'s
for i = 1:K;
    rng(i + 10); %Set seed
    x(:,i) = exprnd(1,1,M);
    P1 = reshape(x,1,[]);
    y(:,i) = exprnd(x(:,i));
    z(:,i) = x(:,i).*y(:,i);
    P3 = reshape(z<=3,1,[]);
    mu1(i) = (sum(P3))/size(P3,2); %Pr XY<=3
    mu2(i) = mean(1-exp(-3./(P1.^2))); %Cond 
end

%Plot
figure(3)
plot(1:K, mu1, 'b', 1:K, mu2, 'r')
legend('Pr(XY \leq 3)', '1-exp(-3/x^2)')

diary off