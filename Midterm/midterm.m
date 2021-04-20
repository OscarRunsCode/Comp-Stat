% midterm

clear;

load mid_train;
load mid_test;

X = Ytrain';
[m,n] = size(X);

% % show all data
% for i = 1:m
%     I = reshape(X(i,:),28,23);
%     imagesc(I);
%     colormap(gray)
%     axis equal;
%     pause(0.5);
% end 

tic;
% PCA 
C = cov(X);
[U, S, V] = svd(C);

K = 40;
for k = 1:K
    U1 = U(:,1:k);
    Z_train = X*U1;
    Z_test = Ytest'*U1;
    
    % find the nearest neighbor
    for i = 1:m
        for j = 1:m
            d(i,j) = norm(Z_test(i,:)-Z_train(j,:));
        end
        [dis, dis_ind] = sort(d(i,:));
        nn(i) = dis_ind(1);
    end
    
    % accuracy
    acc_pca(k) = sum(ceil(nn/5)==ceil((1:m)/5))/m; 
end
toc,


tic;
% simple projection
for k = 1:K
    Z_train_sp = Ytrain(1:k,:)';
    Z_test_sp = Ytest(1:k,:)';
    
    % find the nearest neighbor
    for i = 1:m
        for j = 1:m
            d_sp(i,j) = norm(Z_test_sp(i,:)-Z_train_sp(j,:));
        end
        [dis, dis_ind] = sort(d_sp(i,:));
        nn_sp(i) = dis_ind(1);
    end
    
    % accuracy
    acc_sp(k) = sum(ceil(nn_sp/5)==ceil((1:m)/5))/m; 
end
toc,

plot(1:K, acc_pca, 'bo-', 1:K, acc_sp, 'r*-');
legend('PCA', 'SP');% example figures
ind = [ceil(nn/5)==ceil((1:m)/5); ceil(nn_sp/5)==ceil((1:m)/5)];

S = [141 182 42 81]; 

for j = 1:4
    figure(j+10);  clf; 
    set(gcf, 'position', [50, 50, 700, 400]);
    
    subplot(1,3,1); 
    I = reshape(Ytest(:,S(j)),28,23);
    imagesc(I);
    colormap(gray);
    axis equal;   
    title(['Test: ' num2str(S(j))], 'fontsize', 20);
    
    subplot(1,3,2); 
    I = reshape(Ytrain(:,nn(S(j))),28,23);
    imagesc(I);
    colormap(gray);
    axis equal;
    title(['PCA NN:' num2str(nn(S(j)))], 'fontsize', 20);
    
    subplot(1,3,3); 
    I = reshape(Ytrain(:,nn_sp(S(j))),28,23);
    imagesc(I);
    colormap(gray)
    axis equal;
    title(['SP NN:' num2str(nn_sp(S(j)))], 'fontsize', 20);   
end




