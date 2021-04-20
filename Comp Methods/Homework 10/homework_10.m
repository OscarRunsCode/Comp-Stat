clear
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load ('hw10_1');

n = 15;

[M N] = size(X);

y = randsample(M,n,true);

for i = 1:n
    j(i,:) = X(y(i),:);
end

x1 = j(:,1);
x2 = j(:,2);

mu_x1 = mean(x1)
mu_x2 = mean(x2)
cc1 = corrcoef(x1,x2)

%Bootstrap Sample

B = [25 50 100 200 500 1000 2000];

for j = 1:7;
    for i = 1:B(j)
        b(i,:) = randsample(M, n, true);
    end
    
    b1 = transpose(b);
    
    for i = 1:B(j)
        s = X(b1(:,1),:);
    end
    
    s1 = s(:,1);
    s2 = s(:,2);
    
    theta1(j) = mean(s1);  %(1/B(j))*sum(s1);
    theta2(j) = mean(s2);  %(1/B(j))*sum(s2);
    
    se1(j) = ((1/(B(j)-1))*sum((s1-theta1(j)).^2))^.5;
    se2(j) = ((1/(B(j)-1))*sum((s2-theta2(j)).^2))^.5;
    cc2(j) = corrcoef(theta1(j), theta2(j));
end

figure(1)
plot(se1)
xlabel('Sample Size (as an element of B)')
ylabel('Standar Errors')

figure(2)
plot(se2)
xlabel('Sample Size (as an element of B)')
ylabel('Standar Errors')

figure(3)
plot(theta1)
xlabel('Sample Size (as an element of B)')
ylabel('Mean')

figure(4)
plot(theta2)
xlabel('Sample Size (as an element of B)')
ylabel('Mean')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
clc

X = [1 2 3.5 4 7 7.3 8.6 12.4 13.8 18.1];

x1 = transpose(X);

X1 = sort(X);

x = X1(3:8);
m = length(x);

B = [25 100 200 500 1000 2000];

for j = 1:6
    for r = 1:B(j)
        b(r,:) = randsample(X, 10, true);
    end
    b1 = transpose(b);
    b2 = sort(b1);
    b3 = b2(3:8,:);
    
    theta1 = mean(b3);
    theta2(j) = mean(theta1);
    
    for ir = 1:B(j)
        se(j) = ((1/(B(j)-1))*sum((b3(:,r)-theta2(j)).^2))^.5;
    end
end


theta3 = (1/(m-1))*sum(x);
se3 = (1/(m-1))*sum((x-theta3).^2)^.5;



clear
clc

B = [25 100 200 500 1000 2000];
X = [1 2 3.5 4 7 7.3 8.6 12.4 13.8 18.1];



for i = 1:50
    for j = 1:6
        for r = 1:B(j)
            b(r,:) = randsample(X, 10, true);
        end
        b1 = transpose(b);  
        b2 = sort(b1);
        b3 = b2(3:8,:);
        
        theta1 = mean(b3);
        theta2(j) = mean(theta1);
        
        for ir = 1:B(j)
            se2(i,j) = ((1/(B(j)-1))*sum((b3(:,r)-theta2(j)).^2))^.5;
        end
    end
    
end

se3 = transpose(se2);

figure(5)
plot(se3)
xlabel('B')
ylabel('se')


figure(5)
plot(theta4)
xlabel('Sample Size')
ylabel('Mean')

figure(6)
plot(se4)
xlabel('Sample Size')
ylabel('Standar Errors')


