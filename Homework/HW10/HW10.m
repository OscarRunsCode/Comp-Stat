clc
clear
%Diary
dfile ='MATLAB_Output_OM.txt';
if exist(dfile, 'file') ; delete(dfile); end
diary(dfile)
diary on

%Introduction
fprintf('----------------------------------------------------------------------\n');
fprintf('\t Oscar Martinez \t HW 10 \t STA 5106\n');
fprintf('----------------------------------------------------------------------\n');

%-----Problem 1:-----
fprintf('-----------Problem 1----------\n');

rng(17);
n=10^7; 
K=10;

for k = 1:K
    x(:,k) = exprnd(1/3,1,n); %Sampling distrbn is exp(1/3)
    z = reshape(x(:,1:k),[],1);
    num(k) = mean(z.*exp(-(0.5-z).^2/2)/3);
    den(k) = mean(exp(-(0.5-z).^2/2)/3);
    ratio(k) = num(k)/den(k);
end

figure(1)
plot(1:K,ratio,'-o')
xlabel('Iteration K (Sample Size for each iteration is K*10^7)'); %Sample Size for each iteration is K*10^7
ylabel('Estimate of \Theta');

%-----Problem 2:-----
fprintf('-----------Problem 2----------\n');
clear

SM = [3 5 7]; %Sample Size Matrix
A = [1:5]; %Estimate MKatrix
for j = 1:3
    n = 10^eval('SM(j)');
    for a = 1:5
        x = normrnd(a,1,1,n); %Sample from Norm(a,1)
        mu(j,a) = mean((x>a).*exp(a^2/2-a*x));
        TP(a)=1-normcdf(a); %True Prob
        %Plot
        figure(2)
        subplot(3,2,a);
        plot(1:j, mu(:,a), '-bo',1:j, ones(1,j)*TP(a), 'r');
        title(['a = ', num2str(a)]);
        xlabel('log_{10}(n)');
        legend('Estimate', 'True', 'Location','best');
    end    
end

%-----Problem 3:-----
fprintf('-----------Problem 3----------\n');
clear

SM = [3 5 7]; %Sample Size Matrix
A = [1:5]; %Estimate MKatrix
lm = 5;
for j = 1:3
    n = 10^eval('SM(j)');
    for a = 1:5
        x = exprnd(a,1,n); %Sample from Exp(a)
        mu(j,a) = mean(lm*a*(x>a).*exp(-(lm-(1/a))*x));
        TP(a)=1-expcdf(a,1/lm); %True Prob
        %Plot
        figure(3)
        subplot(3,2,a);
        plot(1:j, mu(:,a), '-bo',1:j, ones(1,j)*TP(a), 'r');
        title(['a = ', num2str(a)]);
        xlabel('log_{10}(n)');
        legend('Estimate', 'True', 'Location','best');
    end    
end

diary off