clc
clear
%Diary
dfile ='MATLAB_Output_OM.txt';
if exist(dfile, 'file') ; delete(dfile); end
diary(dfile)
diary on

%Introduction
fprintf('----------------------------------------------------------------------\n');
fprintf('\t Oscar Martinez \t HW 7 \t STA 5106\n');
fprintf('----------------------------------------------------------------------\n');

%-----Problem 1:-----
fprintf('-----------Problem 1----------\n');

fprintf('\n----------Dataset 1---------\n');
%Load Data
load hw7_1_data1.mat %Loads the first dataset
X=Yn'; %X is 100*2
[N, I] = size(X); %N=100,n=I

%Visualize original data
figure(1);
plot(X(:,1), X(:,2), '.');
pause;

K = 5;    % number of clusters
C(:,:,1) = X(1:K,:);  % assign the first K points of X as the means

E = 1;  % update error
m = 1;
while (E > 1e-3)
    for n = 1:N %Find closest K-Mean for each n \in N of X = N x I
        dis = sqrt(sum((ones(K,1)*X(n,:) - C(:,:,m)).^2,2)); 
        [min_dis(m,n), ind(m,n)] = min(dis);
    end
    for k = 1:K
        C(k,:,m+1) = mean(X(ind(m,:)==k,:)); %Update Means
    end
    E = norm(C(:,:,m+1)-C(:,:,m)); %Difference between mean iterations
    
    % plot the process
    figure(2); clf;
    color = 'rbgcmyk';
    for k = 1:K
        plot(X(ind(m,:)==k,1),X(ind(m,:)==k,2),[color(k) '.'],'MarkerSize',12);
        hold on;
        plot(C(k,1,m),C(k,2,m),'kx', 'MarkerSize',12,'LineWidth',2)
    end
    
    % compute the sum of squares
    ss(m) = sum(min_dis(m,:).^2);
    
    pause;
    m = m+1;
end

figure(3);
plot(ss, 'o-');

%---Load Second Data---
fprintf('\n----------Dataset 2---------\n');
load hw7_1_data2.mat %Loads the second dataset
X=Yn'; %X is 100*2
[N, I] = size(X); %m=100,n=2

%Visualize original data
figure(4);
plot(X(:,1), X(:,2), '.');
pause;

K = 5;    % number of clusters
C(:,:,1) = X(1:K,:);  % assign the first K points of X as the means
%C(:,:,1) = [0.9852 2.935; -2.4 1.814; -2.193 -1.576; 0.8488 -2.765; 3.123
%-0.259] non-random seed

E = 1;  % update error
m = 1;
while (E > 1e-3)
    for n = 1:N %Find closest K-Mean for each n \in N of X = N x I
        dis = sqrt(sum((ones(K,1)*X(n,:) - C(:,:,m)).^2,2)); 
        [min_dis(m,n), ind(m,n)] = min(dis);
    end
    for k = 1:K
        C(k,:,m+1) = mean(X(ind(m,:)==k,:)); %Update Means
    end
    E = norm(C(:,:,m+1)-C(:,:,m)); %Difference between mean iterations
    
    % plot the process
    figure(5); clf;
    color = 'rbgcmyk';
    for k = 1:K
        plot(X(ind(m,:)==k,1),X(ind(m,:)==k,2),[color(k) '.'],'MarkerSize',12);
        hold on;
        plot(C(k,1,m),C(k,2,m),'kx', 'MarkerSize',12,'LineWidth',2)
    end
    
    % compute the sum of squares
    ss(m) = sum(min_dis(m,:).^2);
    
    pause;
    m = m+1;
end

figure(6);
plot(ss, 'o-'); %Plot Error

%-----Problem 2:-----
fprintf('\n-----------Problem 2----------\n');
clear;
fprintf('\n----------Dataset 1---------\n');
%Load the first dataset
load hw6_2_data1.mat;
X = Y'; %500 x 1

[N, I] = size(X); %N=500,I=1

%Visualize original data
figure(7);
plot(X(:), '.');
pause;

K = 2;    % number of clusters
C(:,1) = X(1:K);  % assign the first K points of X as the means

E = 1;  % update error
m = 1;  %Iteration
while (E > 1e-3)
    for n = 1:N %Find closest K-Mean for each n \in N of X = N x I
        dis = sqrt(sum((ones(K,1)*X(n) - C(:,m)).^2,2)); %distance between members of X and proposed means
        [min_dis(m,n), ind(m,n)] = min(dis); %Min dist and corresponding index between element n of X for iteration n
    end
    for k = 1:K
        C(k,m+1) = mean(X(ind(m,:)==k)); %Update Means via responsibilities for K
    end
    E = norm(C(:,m+1)-C(:,m)); %Difference between mean iterations
    
    % plot the process
    figure(8); clf;
    color = 'rbgcmyk';
    for k = 1:K
        plot(X(ind(m,:)==k),[color(k) '.'],'MarkerSize',12);
        hold on;
        plot(C(k,m),'kx', 'MarkerSize',12,'LineWidth',2)
    end
    
    % compute the sum of squares
    ss(m) = sum(min_dis(m).^2);
    
    pause;
    m = m+1;
end

figure(9);
plot(ss, 'o-'); %Plot Error

%Mean, Variance,and Proportion
Mu1 = C(1,m-1);
Mu2 = C(2,m-1);
Var1 = var(X(ind(m-1,:)==1));
Var2 = var(X(ind(m-1,:)==2));
Alpha1 = sum(ind(m-1,:)==1)/N;
Alpha2 = sum(ind(m-1,:)==2)/N;
theta = [Mu2 Mu1 Var2 Var1 Alpha2 Alpha1];
fprintf('mu = (%2.4f, %2.4f), sigma = (%2.4f, %2.4f), alpha = (%2.4f, %2.4f) \n', theta(1), theta(2), theta(3), theta(4), theta(5), theta(6));



fprintf('\n----------Dataset 2---------\n');
clear;
%Load the second dataset
load hw6_2_data2.mat;
X = Y'; %500 x 1

[N, I] = size(X); %N=500,I=1

%Visualize original data
figure(10);
plot(X(:), '.');
pause;

K = 2;    % number of clusters
C(:,1) = X(1:K);  % assign the first K points of X as the means
%C(:,1) = [min(X); max(X)]; %Extremal Seeds
%C(:,1) = [mean(X)+0.25; mean(X)-0.25]; %Mean seeds
%C(:,1) = [2.818; 0.550]; %HW6 Seeds

E = 1;  % update error
m = 1;  %Iteration
while (E > 1e-6)
    for n = 1:N %Find closest K-Mean for each n \in N of X = N x I
        dis = sqrt(sum((ones(K,1)*X(n) - C(:,m)).^2,2)); %distance between members of X and proposed means
        [min_dis(m,n), ind(m,n)] = min(dis); %Min dist and corresponding index between element n of X for iteration n
    end
    for k = 1:K
        C(k,m+1) = mean(X(ind(m,:)==k)); %Update Means via responsibilities for K
    end
    E = norm(C(:,m+1)-C(:,m)); %Difference between mean iterations
    
    % plot the process
    figure(11); clf;
    color = 'rbgcmyk';
    for k = 1:K
        plot(X(ind(m,:)==k),[color(k) '.'],'MarkerSize',12);
        hold on;
        plot(C(k,m),'kx', 'MarkerSize',12,'LineWidth',2)
    end
    
    % compute the sum of squares
    ss(m) = sum(min_dis(m).^2);
    
    pause;
    m = m+1;
end

figure(12);
plot(ss, 'o-'); %Plot Error

%Mean, Variance,and Proportion
Mu1 = C(1,m-1);
Mu2 = C(2,m-1);
Var1 = var(X(ind(m-1,:)==1));
Var2 = var(X(ind(m-1,:)==2));
Alpha1 = sum(ind(m-1,:)==1)/N;
Alpha2 = sum(ind(m-1,:)==2)/N;
theta = [Mu2 Mu1 Var2 Var1 Alpha2 Alpha1];
fprintf('mu = (%2.4f, %2.4f), sigma = (%2.4f, %2.4f), alpha = (%2.4f, %2.4f) \n', theta(1), theta(2), theta(3), theta(4), theta(5), theta(6));

diary off