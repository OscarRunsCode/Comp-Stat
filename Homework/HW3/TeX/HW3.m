 %Problems 1-3
 clc
 clear
 
 diary MATLAB_Output_OM.txt
 
 %Introduction
 fprintf('--------------------------------------------------------------\n');
 fprintf('Oscar Martinez \t Homework 3: Problems 1-3 \t STA 5106\n');
 fprintf('--------------------------------------------------------------\n');
 
 %-----Problem 1:-----
 fprintf('-----Problem 1-----');
 X1=[5 0 9 3; 3 6 8 9; 4 4 9 6; 0 3 1 8; 2 8 2 3]
 y=[20 17 32 10 12]'
 b=multilinreg(X1,y)
 
 %-----Problem 2:-----
 fprintf('-----Problem 2-----\n');
 X2=[15 16 12 14 13 15 16 21 12 11 19 14 13 14 16 17 12 16;
 13 11 13 12 09 14 12 16 09 08 15 13 15 13 12 16 11 09];
 fprintf(' X2^T=\n ');
 X2'
 
 fprintf('---Part (a)---\n');
 %First Plot
 figure(1);
 plot(X2(1,:),X2(2,:),'b*', 'markersize', 5)
 xlabel('X-Axis');
 ylabel('Y-Axis');
 
 
 fprintf('---Part (b)---');
 %PCA analysis
 [m, n] = size(X2);
 
 % 1. Compute sample covariance
 C = cov(X2')
 
 % 2. SVD on C
 [U, S, V] = svd(C);
 U
 
 % 3. select the first 2 columns of U
 U1 = U(:,1:2);
 
 % 4. Define Z
 Z = U1'*X2;
 
 % plot the transformed data
 figure(2);
 plot(Z(1,:), Z(2,:), 'r*', 'markersize', 5);
 xlabel('Principal Component 1');
 ylabel('Principal Component 2');
 % axis([-110 -85 -1 6]);
 % axis equal;
 
 % plot the principal directions on the origianl data
 m_X2 = mean(X2');
 figure(1);
 hold on;
 plot(2*sqrt(S(1,1))*[-U(1, 1) U(1, 1)]+m_X2(1), ...
 2*sqrt(S(1,1))*[-U(2, 1) U(2, 1)]+m_X2(2), 'g', 'linewidth', 2);
 plot(2*sqrt(S(2,2))*[-U(1, 2) U(1, 2)]+m_X2(1), ...
 2*sqrt(S(2,2))*[-U(2, 2) U(2, 2)]+m_X2(2), 'g', 'linewidth', 2);
 hold off;
 % compare the covariance and the total variance
 Cov_X2 = cov(X2'),
 Cov_Z = cov(Z'),
 Total_var_X2 = trace(Cov_X2),
 Total_var_Z = trace(Cov_Z),
 
 Ratio=Total_var_Z/Total_var_X2
 %-----Problem 3:-----
 fprintf('-----Problem 3-----\n');
 clear
 
 %Import Data
 load hw3_3_data.mat
 
 %----Part (a)----
 fprintf('---Part (a)---\n');
 %%% Perform the PCA analysis %%%
 [m, n] = size(X);
 
 % i. Compute sample covariance
 C = cov(X);
 
 % ii. SVD on C
 [U, S, V] = svd(C);
 %U is 100x100, was formerly 200x200 before making C the covariance of X
 %transpose
 
 % iii. select the first D=10 columns of U
 U1 = U(:,1:10); %100x10
 
 % iv. Define X3 (Prompt's X1)
 X3 = X*U1; %Want this to be 200x10
 
 %----Part (b)----
 fprintf('---Part (b)---');
 b1=multilinreg(X3,y)
 
 %----Part (c)----
 fprintf('---Part (c)---');
 E=y-X3*b1;
 SSE=norm(E,2)
 
 %closing output
 diary off
