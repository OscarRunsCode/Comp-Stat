% one example to show the use of principal component analysis
% the data is multiple pairs of father-son heights in inches

clear;

load('hw3_1_data.mat')


% plot the raw data
figure(1);
plot(x(:,1), x(:,2), '.');
axis([60 80 60 80]);
axis equal;
xlabel('Father Height (in)');
ylabel('Son Height (in)');

%%% Perform the PCA analysis %%%
[m, n] = size(x); 

% 1. Compute sample covariance
C = cov(x);

% 2. SVD on C
[U, S, V] = svd(C);

% 3. select the first 2 columns of U
U1 = U(:,1:10);

% 4. Define Z 
Z = x*U1;

% plot the transformed data
%figure(2);
%plot(Z(:,1), Z(:,2), Z(:,3), Z(:,4), Z(:,5), Z(:,6), Z(:,7), Z(:,8), Z(:,9), Z(:,10),'.');
%xlabel('Principal Component 1');
%ylabel('Principal Component 2');
%axis([-110 -85 -1 6]);
%axis equal;

% plot the principal directions on the origianl data
m_x = mean(x);
figure(1);
hold on;
plot(2*sqrt(S(1,1))*[-U(1, 1) U(1, 1)]+m_x(1), ...
       2*sqrt(S(1,1))*[-U(2, 1) U(2, 1)]+m_x(2), 'g');
plot(2*sqrt(S(2,2))*[-U(1, 2) U(1, 2)]+m_x(1), ...
       2*sqrt(S(2,2))*[-U(2, 2) U(2, 2)]+m_x(2), 'g');


% compare the covariance and the total variance
%Cov_x = cov(x),
%Cov_Z = cov(Z),
%Total_var_x = trace(Cov_x),
%Total_var_Z = trace(Cov_Z),

b = multilinreg(x,y)





