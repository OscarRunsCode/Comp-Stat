clear
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:500
    j = 10000*i;
    x = randn(1,j);
    n = length(x);
    
    theta1(i) = (1/n)*sum(x);
    sig2(i) = (1/n)*sum((x-theta1(i)).^2);
    k(i) = (1/n)*sum((x-theta1(i)).^4);
    
    vtheta1(i) = var(theta1);
    vsig2(i) = var(sig2);
    vk(i) = var(k);
    i
end

figure(1)
plot(theta1)
xlabel('Sample Size (in 10,000s)')
ylabel('Mean')

figure(2)
plot(sig2)
xlabel('Sample Size (in 10,000s)')
ylabel('Variance')

figure(3)
plot(k)
xlabel('Sample Size (in 10,000s)')
ylabel('Kurtosis')

figure(4)
plot(vtheta1)
xlabel('Sample Size (in 10,000s)')
ylabel('Variance of Mean')

figure(5)
plot(vsig2)
xlabel('Sample Size (in 10,000s)')
ylabel('Variance of Sigma^2')

figure(6)
plot(vk)
xlabel('Sample Size (in 10,000s)')
ylabel('Variance of Kurtosis')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
clc

for a = 1:500
    k = 5000*a;
    y1 = exprnd(1,1,k);
    y2 = rand(1,k);

    n1 = length(y1);
    n2 = length(y2);
    
    theta2_2(a) = (1/n2)*(sum(exp(-y2)));

    
    R = zeros(1,n1);
    for i = 1:n1
        if (y1(i)<1)
            R(i) = 1;
        end
    end
    M(a) = sum(R);
    theta2_1(a) = M(a)/n1;
end

figure(7)
plot(theta2_1)
xlabel('Sample Size (in 5000s)')
ylabel('Theta')

figure(8)
plot(theta2_2)
xlabel('Sample Size (in 5000s)')
ylabel('Theta')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rand('seed', 0);
n = round(10.^(1:0.1:6));

for k = 1:length(n)
    x = exprnd(1,1,n(k));
    y = exprnd(x);
    p1(k) = mean(x.*y<=3);
    p2(k) = mean(1-exp(-3./(x.^2)));
end

figure(9)
plot(log10(n), p1, 'b', log10(n), p2, 'r')