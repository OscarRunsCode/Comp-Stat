clc
clear

load ('Ytrain.mat')
load('Ytest.mat')

Y = (Ytrain)';
W = eye(644);

%%% Perform the PCA analysis %%%
[m, n] = size(Y); 

% 1. Compute sample covariance
C = cov(Y);

% 2. SVD on C
[U, S, V] = svd(C);

for K = 1:40;
        UPCA = U(:,1:K);
        Z = (UPCA)'*Ytrain;
        
        USP = W(:,1:K);
        Y1 = (USP)'*Ytrain;
        
        for i = 1:100
            IND(i) = ceil(200*rand(1));
            I = Ytest(:,IND(i));
            I1 = (USP)'*I;
            Z1 = (UPCA)'*I;
            IN(i) = ceil(IND(i)/5);
            
            [a b] = size(Y1);
            [c d] = size(Z);
            
            for j = 1:b
                d1(j) = norm(I1-Y1(:,j));
            end
            [dis1, dis_ind1] = sort(d1);
            nn1(i) = dis_ind1(1);
            NN1(i) = ceil(nn1(i)/5);
            diff1(i) = (IN(i)-NN1(i));
            if (diff1(i)==0)
                s1(i)=1;
            else
                s1(i)=0;
            end
            success1(K) = sum(s1);
            FSP(K) = success1(K)/100; 
            
            for m = 1:d
                d2(m) = norm(Z1-Z(:,m));
            end
            [dis2, dis_ind2] = sort(d2);
            nn2(i) = dis_ind2(1);
            NN2(i) = ceil(nn2(i)/5);
            diff2(i) = (IN(i)-NN2(i));
            if (diff2(i)==0)
                s2(i) = 1;
            else
                s2(i) = 0;
            end
            success2(K) = sum(s2);
            FPCA(K) = success2(K)/100;
        end
        VPCA = var(FPCA(K));
        VSP = var(FSP(K));
end
%plot(nn1)

figure(1)
plot(FSP,'b')
xlabel('K')
ylabel('F(K)')
title('Figure 1')
hold on

plot(FPCA,'r')

figure(2)
I=reshape(Ytrain(:,100),28,23);
imagesc(I);
colormap(gray);
axis equal;

figure(3)
I=reshape(Ytest(:,98),28,23);
imagesc(I);
colormap(gray);
axis equal;

figure(4)
I=reshape(Ytrain(:,130),28,23);
imagesc(I);
colormap(gray);
axis equal;

figure(5)
I=reshape(Ytest(:,129),28,23);
imagesc(I);
colormap(gray);
axis equal;
