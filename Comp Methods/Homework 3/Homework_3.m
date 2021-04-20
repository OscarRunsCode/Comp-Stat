clc
clear

% Question 1

load('hw3_1_data.mat')

%%% Perform the PCA analysis %%%
[m, n] = size(x); 

% 1. Compute sample covariance
C = cov(x);

% 2. SVD on C
[U, S, V] = svd(C);

% 3. select the first 10 columns of U
U1 = U(:,1:10);

% 4. Define Z 
Z = x*U1;

b = multilinreg(Z,y)

B = Z*b;

SSE = [y-B]'*[y-B]

SSE_new = [y(1:10:100)-B(1:10:100)]'*[y(1:10:100)-B(1:10:100)]

i = 0;
for d = 10:10:100;
    U1 = U(:,1:d);
    x1 = x*U1;
    b1 = multilinreg(x1,y);
    i = i+1;
    SSE(i) = norm(y-x1*b1,2)^2;
end

figure(1)
plot(10:10:100,SSE)


% Question 2

clear

K = [1 .8; .8 5];
k = 100;
x = sqrtm(K)*randn(2,k);

figure(2)
plot(x(1,:),x(2,:),'*');

%%% Perform the PCA analysis %%%
[m, n] = size(x); 

% 1. Compute sample covariance
C = cov(x);

% 2. SVD on C
[U, S, V] = svd(C);

% 3. select the first column of U
U1 = U(:,1);

% 4. Define Z 
Z = x*U1;

figure(2)
hold on
plot(2*sqrt(S(1, 1))*[-U(1, 1) U(1, 1)], 2*sqrt(S(1, 1))*[-U(2, 1) U(2, 1)], 'g')

ratio = var(Z)/trace(C)

% Question 3
clear
load('hw3_3_data.mat')

%%% Perform the PCA analysis %%%
[m, n] = size(X); 

% 1. Compute sample covariance
C = cov(X);

% 2. SVD on C
[U, S, V] = svd(C);

% 3. select the first 10 columns of U
U1 = U(:,1);
U2 = U(:,2);
U3 = U(:,3);

% 4. Define Z 
Z = X*U1;

figure(3)
I = reshape(U1,28,23);
imagesc(I);
colormap(gray)
axis equal;

figure(4)
I = reshape(U2,28,23);
imagesc(I);
colormap(gray)
axis equal;

figure(5)
I = reshape(U3,28,23);
imagesc(I);
colormap(gray)
axis equal;

for i = 1:50
    sum(X(1,:)*U)
end

% Question 4
clear
load('hw3_4_data.mat')

figure(4)
plot3

