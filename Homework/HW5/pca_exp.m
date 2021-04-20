% one example to show the use of principal component analysis
% the data is multiple pairs of father-son heights in inches

clear;

x = [ 
    68    69
    72    71
    73    71
    70    71
    72    69
    69    68
    75    73
    72    67
    69    72
    69    68
    75    73
    64    63
    69    72
    73    73
    78    75
    70    72
    72    69
    65    67
    71    70
    69    70
    71    73
    68    64
    69    72
    75    74
    75    75
    ];

x = x'; 

% plot the raw data
figure(1);
plot(x(1,:), x(2,:), '.', 'markersize', 20);
axis([60 80 60 80]);
axis equal;
xlabel('Father Height (in)', 'fontsize', 25);
ylabel('Son Height (in)', 'fontsize', 25);
set(gca, 'fontsize', 18);

%%% Perform the PCA analysis %%%
[m, n] = size(x); 

% 1. Compute sample covariance
C = cov(x');

% 2. SVD on C
[U, S, V] = svd(C);

% 3. select the first 2 columns of U
U1 = U(:,1:2);

% 4. Define Z 
Z = U1'*x;

% plot the transformed data
figure(2);
plot(Z(1,:), Z(2,:), '.', 'markersize', 20);
xlabel('Principal Component 1');
ylabel('Principal Component 2');
axis([-110 -85 -1 6]);
axis equal;

% plot the principal directions on the origianl data
m_x = mean(x');
figure(1);
hold on;
plot(2*sqrt(S(1,1))*[-U(1, 1) U(1, 1)]+m_x(1), ...
        2*sqrt(S(1,1))*[-U(2, 1) U(2, 1)]+m_x(2), 'g', 'linewidth', 2);
plot(2*sqrt(S(2,2))*[-U(1, 2) U(1, 2)]+m_x(1), ...
        2*sqrt(S(2,2))*[-U(2, 2) U(2, 2)]+m_x(2), 'g', 'linewidth', 2);


% compare the covariance and the total variance
Cov_x = cov(x'),
Cov_Z = cov(Z'),
Total_var_x = trace(Cov_x),
Total_var_Z = trace(Cov_Z),





