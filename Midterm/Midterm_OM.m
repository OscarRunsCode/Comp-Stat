%Midterm OM, Begin:
clc
clear
%Diary
dfile ='MATLAB_Output_OM.txt';
if exist(dfile, 'file') ; delete(dfile); end
diary(dfile)
diary on
%Introduction
fprintf('----------------------------------------------------------------------\n');
fprintf('\t Oscar Martinez \t Midterm \t STA 5106\n');
fprintf('----------------------------------------------------------------------\n');
%Load Data
load mid_train.mat %Loads the 644 x 200 double "Ytrain"
load mid_test.mat %Load the test data, Y_test, 644 x 200
%The images are arranged in a vector of size (s1 x s2) x (n1 x n2)
%s1 = 28, s2 = 23, n1 = 40, n2 = 5
%First 5 columns are of person 1, send 5 (cols 6-10) are of person 2 etc.
    X = Ytrain'; %200 x 644
    [m,n] = size(X); %m=200, n=644
 %Visualization of the images
 for t = 1:m
    figure(1);
    I = reshape(X(t,:),28,23); %Reshape column i of X into a 28x23 matrix
    imagesc(I); %Takes the reshapen column/matrix and converts it to an image
    colormap(gray); %The image's color scheme is grayscale
    axis equal; %Equal Margins
    title(['Data Image ', num2str(t)]); %Title
    %pause;
 end
%PCA
C = cov(X); %C is the 644 x 644, Var-Cov Matrix of X
[U,S,V]=svd(C); %SVD decomposition w/ U = V being our matrix of interest
IDM=eye(644); %644 x 644 IDentity Matrix
%Preallocating For Speed
K=40; %Principal components
d_PCA=zeros(m,m); %PCA distance
d_Proj=zeros(m,m); %Projection distance
nn_PCA=zeros(1,m); %PCA nearest neighbor
nn_Proj=zeros(1,m); %Projection Nearest Neighbor
FPCA=zeros(1,m); %PCA Accuracy Logical
FProj=zeros(1,m); %Projection accuracy logical
LPCA=zeros(m,K); %Aggregate PCA logical
LProj=zeros(m,K); %Aggregate Proj logical
AccPCA=zeros(1,K); %PCA accuracy
AccProj=zeros(1,K);  %Projection accuracy
Diff=zeros(1,K); %Difference in accuracy
 
for k=1:K %X is 200 x 644, Ytrain/test is 644 x 200
    U1=U(:,1:k); %PCA Proj Matrix, (s1 x s2) x k; 644 x k
    U2=IDM(:,1:k); %Simple Projection Matrix, (s1 x s2) x k; 644 x k
    Y1=U1'*X'; %PCA Projection, k x 200
    Y2=U2'*X'; %Simple Projection, k x 200
%---Classification---
%Form feature Vector
for i=1:m %m=200 images
    I_Test = Ytest(:,i); %Select an image (644 x 1 col vect) from test data
    I_PCA = U1'*I_Test; %PCA Feature, k x 1
    I_Proj = U2'*I_Test; %Projection Feature, k x 1
%Nearest Neighbor
    for j = 1:m %Compute distances for each image i in test and all m images of train
      d_PCA(i,j) = norm(I_PCA-Y1(:,j)); %Distance of i from PCA projection j, 200 x 200
      d_Proj(i,j) = norm(I_Proj-Y2(:,j)); %Distance of i from simple projection j, 200 x 200
    end
%Distances and Neighbors
    [dis_PCA, dis_indPCA] = sort(d_PCA(i,:)); %Sorting PCA distances in ascending order with index
    [dis_Proj, dis_indProj] = sort(d_Proj(i,:)); %Sorting SP distances in ascending order with index
    nn_PCA(i) = dis_indPCA(1); %Column of Y1 with closest distance to I_PCA
    nn_Proj(i) = dis_indProj(1); %Column of Y1 with closest distance to I_PCA
%Accuracy
    FPCA(i) = ceil((nn_PCA(i)/5))==ceil(i/5); %Logical Accuracy PCA
    FProj(i) = ceil((nn_Proj(i)/5))==ceil(i/5); %Logical Accuracy SP
end
    LPCA(:,k) = FPCA; %Aggregate Logical Correct PCA Matrix
    LProj(:,k) = FProj; %Aggregate Logical Correct Proj Matrix
    AccPCA(k)=sum(FPCA)/m; %ACC = #Correct/Total
    AccProj(k)=sum(FProj)/m; %ACC = #Correct/Total
    Diff(k)=abs(AccPCA(k)-AccProj(k)); %difference in accuracy
%Print Results
    fprintf('k = %2.0f \t PCA Acc = %2.2f%% \t SP Acc = %2.2f%% \t Diff = %2.2f%% \n', k, AccPCA(k)*100, AccProj(k)*100, Diff(k)*100);
end
%Accuracy Plot
    figure(2);
    t=1:K;
    plot(t,AccPCA*100, 'bo-', t,AccProj*100,'ro-', 'LineWidth',1);
    grid on;
    title('Accuracy (%)');
    legend('PCA Projection', 'Simple Projection','Location', 'southeast');
    axis([1 40 0 100]);
    xlabel('k');
    ylabel('F(k)');
%Visual Examples
    PCA_Right = find(LPCA(:,k)); %PCA Right ID
    PCA_Wrong = find(1-LPCA(:,k)); %PCA Wrong ID
    SP_Right = find(LProj(:,k)); %SP Right ID
    SP_Sup = find((1-LPCA(:,k)).*(LProj(:,k))); %SP Right ID & PCA Wrong ID
    EX = {PCA_Right PCA_Wrong SP_Sup}; %Examples Matrix Reference
    for j=1:3
        [a,b]=size(eval('EX{j}'));
        for i=1:a
            figure(j+2); %Figures 3-5
        %Test Image
            subplot(1,3,1); 
            I = reshape(Ytest(:,eval('EX{j}(i)')),28,23); %Col/Img i in Ytest
            imagesc(I); %Takes the reshapen column/matrix and converts it to an image
            colormap(gray); %The image's color scheme is grayscale
            axis equal; %Equal Margins
            title(['Test: ', num2str(eval('EX{j}(i)'))],'fontsize', 18); %Title
        %PCA Image
            subplot(1,3,2);
            I = reshape(Ytrain(:,nn_PCA(eval('EX{j}(i)'))),28,23); %Col/Img in Ytrain w/ nn corresponding to Col/Img i in Ytest
            imagesc(I);
            colormap(gray);
            axis equal;
            title(['PCA NN:' num2str(nn_PCA(eval('EX{j}(i)')))], 'fontsize', 18);
        %SP Image
            subplot(1,3,3); 
            I = reshape(Ytrain(:,nn_Proj(eval('EX{j}(i)'))),28,23); %Col/Img in Ytrain w/ nn_SP corresponding to Col/Img i in Ytest
            imagesc(I);
            colormap(gray);
            axis equal;
            title(['SP NN:' num2str(nn_Proj(eval('EX{j}(i)')))], 'fontsize', 18);
            %pause
        end
    end      
diary off