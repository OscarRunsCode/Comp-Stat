clear
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('hw6_1_data1');
load('hw6_1_data2');

X = (Xn)';
Y = (Yn)';

%%%%%%%%%%%%%% Part 1

[N, I] = size(X);

figure(1)
plot(X(:,1),X(:,2),'.')

K = 5;
C1(:,:,1) = X(1:K,:);
E = 1;
m = 1;

while (E > 1e-3)
    for n = 1:N
        dis1 = sqrt(sum((ones(K,1)*X(n,:) - C1(:,:,m)).^2,2));
        [min_dis1(m,n), ind1(m,n)] = min(dis1);
    end
    for k = 1:K
        C1(k,:,m+1) = mean(X(ind1(m,:)==k,:)); 
    end
    E1 = norm(C1(:,:,m+1)-C1(:,:,m));
    
    % plot the process
    figure(2); clf;
    color = 'rbgcmyk';
    for k = 1:K
        plot(X(ind1(m,:)==k,1),X(ind1(m,:)==k,2),[color(k) '.'],'MarkerSize',12);
        hold on;
        plot(C1(k,1,m),C1(k,2,m),'kx', 'MarkerSize',12,'LineWidth',2)
    end
    
    % compute the sum of squares
%     ss1(m) = sum(min_dis1(m,:).^2);
    
    pause;
    m = m+1;
end

%%%%%%%%%%% Part 2

[N, I] = size(Y);

K = 5;
C2(:,:,1) = Y(1:K,:);
E = 1;
m = 1;
while (E > 1e-3)
    for n = 1:N
        dis2 = sqrt(sum((ones(K,1)*Y(n,:) - C2(:,:,m)).^2,2));
        [min_dis2(m,n), ind2(m,n)] = min(dis2);
    end
    for k = 1:K
        C2(k,:,m+1) = mean(Y(ind2(m,:)==k,:)); 
    end
    E2 = norm(C2(:,:,m+1)-C2(:,:,m));
    
    % plot the process
    figure(2); clf;
    color = 'rbgcmyk';
    for k = 1:K
        plot(Y(ind2(m,:)==k,1),Y(ind2(m,:)==k,2),[color(k) '.'],'MarkerSize',12);
        hold on;
        plot(C2(k,1,m),C2(k,2,m),'kx', 'MarkerSize',12,'LineWidth',2)
    end
    
    % compute the sum of squares
%     ss2(m) = sum(min_dis2(m,:).^2);
    
    pause;
    m = m+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
clc

load hw5_2_data2;
J = (Y)';

clear Y
load hw5_2_data1;

R = (Y)';

X = [J R];

clear J
clear R
clear Y

[N, I] = size(X);

K = 2;
C(:,:,1) = X(1:K,:);
E = 1;
m = 1;

while (E > 1e-3)
    for n = 1:N
        dis = sqrt(sum((ones(K,1)*X(n,:) - C(:,:,m)).^2,2));
        [min_dis(m,n), ind(m,n)] = min(dis);
    end
    for k = 1:K
        C(k,:,m+1) = mean(X(ind(m,:)==k,:)); 
    end
    E = norm(C(:,:,m+1)-C(:,:,m));
    
    % plot the process
    figure(2); clf;
    color = 'rbgcmyk';
    for k = 1:K
        plot(X(ind(m,:)==k,1),X(ind(m,:)==k,2),[color(k) '.'],'MarkerSize',12);
        hold on;
        plot(C(k,1,m),C(k,2,m),'kx', 'MarkerSize',12,'LineWidth',2)
    end
    
    % compute the sum of squares
%     ss(m) = sum(min_dis(m,:).^2);
    
    pause; 
    m = m+1;
end
