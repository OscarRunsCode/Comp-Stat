% example code for K-Means

clear; close all;

%randn('seed', 0);
%X = [randn(100,2)+ones(100,2); randn(100,2)-ones(100,2)];

X = [randn(100,2); randn(100,2) + 4];

[N, I] = size(X);

% figure(1);
% plot(X(:,1), X(:,2), '.');

K = 2;    % number of clusters
C(:,:,1) = X(1:K,:);  % assign the first K points as the means

E = 1;  % update error
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
%     figure(2); clf;
%     color = 'rbgcmyk';
%     for k = 1:K
%         plot(X(ind(m,:)==k,1),X(ind(m,:)==k,2),[color(k) '.'],'MarkerSize',12);
%         hold on;
%         plot(C(k,1,m),C(k,2,m),'kx', 'MarkerSize',12,'LineWidth',2)
%     end
    
    % compute the sum of squares
    ss(m) = sum(min_dis(m,:).^2);
    
%     pause;
    m = m+1;
end

figure(3);
plot(ss, 'o-');

        
