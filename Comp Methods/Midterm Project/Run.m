clc
clear

iter = 1;
maxiter = 101;
W = eye(644);

load ('Ytrain.mat')
load('Ytest.mat')

Y = (Ytrain)';

%%% Perform the PCA analysis %%%
[m, n] = size(Y); 

% 1. Compute sample covariance
C = cov(Y);

% 2. SVD on C
[U, S, V] = svd(C);

for K = 1:40;
    while iter<maxiter;
        UPCA = U(:,1:K);
        Z = (UPCA)'*Ytrain;
        
        USP = W(:,1:K);
        Y1 = (USP)'*Ytrain;
        
        I = Ytest(:,ceil(K*rand(1)));
        I1 = (USP)'*I;
        Z1 = (UPCA)'*I;
        
        for i = 1:200
            Dist(i) = norm(I1-Y1(:,i));
        end
        
        [a b] = size(Y1);
        [c d] = size(Z);
        
        for i = 1:b
            d1(i) = norm(I1-Y1(:,i));
            [dis1, dis_ind1] = sort(d1(i));
            nn1(i) = dis_ind1(1);
        end
        
        for i = 1:d
            d2(i) = norm(Z1-Z(:,i));
            [dis2, dis_ind2] = sort(d2(i));
            nn2(i) = dis_ind2(1);
        end
        iter = iter+1;
    end
end