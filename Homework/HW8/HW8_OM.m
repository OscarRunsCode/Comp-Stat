clc
clear
%Diary
dfile ='MATLAB_Output_OM.txt';
if exist(dfile, 'file') ; delete(dfile); end
diary(dfile)
diary on

%Introduction
fprintf('----------------------------------------------------------------------\n');
fprintf('\t Oscar Martinez \t HW 8 \t STA 5106\n');
fprintf('----------------------------------------------------------------------\n');

%-----Problem 1:-----
fprintf('-----------Problem 1----------\n');

m = 2^(13)-1; 
a = 17;
x(1) = 100;

for k = 2:500
    x(k) = mod(a*x(k-1),m);
end
u1=x/m;
u2=u1(2:end);

figure(1);
subplot(211);
histogram(u1)
grid off;
set(gca, 'fontsize', 16);
title('u_i=x_i/m')
axis([0 1 0 75]);

subplot(212);
plot(u1(1:end-1),u2,'*')
set(gca, 'fontsize', 16);
title('u_i vs u_{i+1}')

%-----Problem 2:-----
fprintf('-----------Problem 2----------\n');
clear

m = 2^(13)-1; 
a = 85;
x(1) = 100;

for k = 2:500
    x(k) = mod(a*x(k-1),m);
end
u1=x/m;
u2=u1(2:end);

figure(2);
subplot(211);
histogram(u1)
grid off;
set(gca, 'fontsize', 16);
title('u_i=x_i/m')
axis([0 1 0 75]);

subplot(212);
plot(u1(1:end-1),u2,'*')
set(gca, 'fontsize', 16);
title('u_i vs u_{i+1}')

%-----Problem 3:-----
fprintf('-----------Problem 3----------\n');
clear

m=2^31 - 1; %Common Mod
a=7; %Prime root
x(1) = 100;

for k = 2:1000 %gen rand from U(0,1)
    x(k) = mod(a*x(k-1),m);
end
u1=x/m;

F_inv = @(y,a,b) ( (-log(1-y)/a).^(1/b) ); %Inverse Weibull CDF
X=F_inv(u1,1,0.5); %Weibull vars
figure(3);
hist(X,100);
title('Weibull RV');

%-----Problem 4:-----
fprintf('-----------Problem 4----------\n');
clear

rng('default')
%Part c
m = 3000;
for j = 1:m;
    %Part a
    n=200; 
    rng(j); %Set Seed
    y=rand(1,n);
    Exp_inv = @(y) (-log(1-y));
    X = Exp_inv(y);
    Z(1)=1;
    for i = 2:n
        Z(i)=(X(i) >= max(X(1:i-1)));
    end

    %Part b
    Z_NZ = find(Z); %non-zero elts of Z
    Z_Dist = diff(Z_NZ)-1; %Distance b/w non/zero elts of Z
    for K=0:8 %Tally up Distances
        Y(j,K+1) = sum(Z_Dist == K); %count of 'k' = Y(k+1)
    end
end

for k = 1:K+1
    re(k,:) = hist(Y(:,k),0:8);
    re(k,:) = re(k,:)/m;
    rp(k,:) = poisspdf(0:8, 1/k);
    figure(4);
    subplot(3,3,k);
    bar (0:8, re(k,:));
    hold on;
    plot(0:8, rp(k,:), 'r-', 'linewidth', 2);
    title(['k = ', num2str(k-1)]);
    axis([-1 9 0 1]);
end

diary off