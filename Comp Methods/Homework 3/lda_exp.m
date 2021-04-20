% one example to show the LDA method
clear; close all;

randn('seed',0);  % set the starting point of randn
for i = 1:2
    for j = 1:3
        X(i,j,:) = randn(1,20)+i+4*j;
    end
end

[n, m, k] = size(X);

% plot X
figure(1);
color = 'brgcy';
for j = 1:m
    for i = 1:k
        plot(X(1,j,i), X(2,j,i), [color(j) '*']);
        hold on;
    end
end

% compute mean in each class
for i = 1:n
    for j = 1:m
        mu(i,j) = mean(X(i,j,:));
    end
end

% compute total mean
MU = mean(mu, 2);

% compute between-class scatter matrix
S_B = zeros(n, n);
for j = 1:m
    S_B = S_B + (mu(:,j) - MU)*(mu(:,j) - MU)';
end

% compute within-class scatter matrix
S_W = zeros(n, n);
for j = 1:m
    for i = 1:k
        S_W = S_W + (X(:,j,i) - mu(:,j))*(X(:,j,i) - mu(:,j))';
    end
end

% compute U
[U, D] = eig(S_B, S_W);
U = U(:,n);  % take the last component (w.r.t. largest generalized eigenvalue)

% projection to Z
for j = 1:m
    for i = 1:k
        Z(i,j) = U'*X(:,j,i);
    end
end

% plot Z
figure(2);
color = 'brgcy';
for j = 1:m
    plot(Z(:,j),[color(j)]);
    hold on;
end



   