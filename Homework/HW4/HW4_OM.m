clc
clear 

%Diary
dfile ='MATLAB_Output_OM.txt';
if exist(dfile, 'file') ; delete(dfile); end
diary(dfile)
diary on
diary MATLAB_Output_OM.txt

%Introduction
fprintf('--------------------------------------------------------------\n');
fprintf('Oscar Martinez \t Homework 4: Problems 1-2 \t STA 5106\n');
fprintf('--------------------------------------------------------------\n');

%-----Problem 1:-----
fprintf('-----Problem 1-----\n');

%Load the data
load hw4_1_data.mat

%size
[m,n] = size(X)

%Part a
fprintf('---Part (a)---\n');

for i = 1:m 
    I = reshape(X(i,:),28,23); %Reshape column i of X into a 28x23 matrix
    imagesc(I); %Takes the reshapen column/matrix and converts it to an image
    colormap(gray); %The image's color scheme is grayscale
    axis equal; %Equal Margins
    title(['Data Image ', num2str(i)]) %Title
    pause; %Wait until user presses a key to move on to the next image
end;

%PCA
C = cov(X); %Variance Covariance
[U,S,V]=svd(C); %SVD decomposition w/ U = V being our matrix of interest
U1=U(:,1:3); %U1 is the first 3 columns of U ie 3 principal directions
%Z=X*U1; %Z is our typical transformation but is unused

%1st three components 
for i = 1:3 
    I = reshape(U1(:,i),28,23); %Reshape column i of U1 into a 28x23 matrix
    imagesc(I); %Takes the reshapen column/matrix and converts it to an image
    colormap(gray); %The image's color scheme is grayscale
    axis equal; %Equal Margins
    title(['First Three Principal Directions: Image ', num2str(i)]) %Title
    pause; %Wait until user presses a key to move on to the next image
end

%Part b
fprintf('---Part (b)---\n');

%Show the projection of the first image
i=0; %start counter at 0
for d = [50 100] %Doing this for d=50 and d=100
    i = i+1; %Update the counter by 1
    Z(:,i) = U(:,1:d)*(X(1,:)*U(:,1:d))'; %Create a new matrix Z, whose ith column corresponds to the ith value of d as per the prompt
end

d = [50 100];
for i = 1:size(Z, 2) %For i from 1 to the # of columns in Z (here 2)
    I = reshape(Z(:,i),28,23); %Reshape column i of Z into a 28x23 matrix
    imagesc(I); %Takes the reshapen column/matrix and converts it to an image
    colormap(gray); %The image's color scheme is grayscale
    axis equal; %Equal Margins
    title(['(b) Projection Onto Subspace ', num2str(d(1,i))]) %Title
    pause %Wait until user presses a key to move on to the next image
end 

%-----Problem 1:-----
clear
fprintf('-----Problem 2-----\n');

%Load the data
load hw4_2_data.mat

%Relevant Details
% m = 5 classes
%k = 10 observations
%n = 3 size of vector per observation
%d = 1

%Part a
fprintf('---Part (a)---\n');

%Plot X
[n, m, k] = size(X);
figure(1);
color = 'brgcy';
for j = 1:m
    for i = 1:k
        plot3(X(1,j,i), X(2,j,i), X(3,j,i), [color(j) '*']);
       %grid on;
       title('Plot of X');
        hold on;
    end
end

%Part b
fprintf('---Part (b)---\n');

%Class Means
for i = 1:n
    for j = 1:m
        mu(i,j) = mean(X(i,j,:));
    end
end

%Total Mean
MU = mean(mu, 2); %column vector w/ mean of each row of mu

%Between-class Scatter Matrix
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
U = U(:,n)  % take the last component (w.r.t. largest generalized eigenvalue)

%Part c
fprintf('---Part (c)---\n');

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
    plot(Z(:,j), [color(j) 'o']);
    title('Plot of Z');
    hold on;
end

%closing output
diary off