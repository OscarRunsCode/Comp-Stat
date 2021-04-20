  clc
 clear
 
 %  % Diary
 %  dfile ='MATLAB_Output_OM.txt';
 %  if exist(dfile, 'file') ; delete(dfile); end
 %  diary(dfile)
 %  diary on
 %  diary MATLAB_Output_OM.txt
 
 %Introduction
 fprintf('--------------------------------------------------------------\n');
 fprintf('Oscar Martinez \t Homework 6: Problems 1 and 2 \t STA 5106\n');
 fprintf('--------------------------------------------------------------\n');
 
 %-----Problem 1:-----
 fprintf('-----------Problem 1----------\n');
 
 n = 100;
 x = [6 52 28 14];
 
 % EM procedure
 theta0 = 0.1;  % initial guess
 
 th = @(x) x/(2+x);
 theta(1) = theta0;
 nth= theta(1)+1;
 i = 1;
 while (abs(theta(i)-nth)>1e-6)
 nth = theta(i);
 theta(i+1) = ( (th(theta(i)))*x(2)+x(4)+x(1) )/ ...
 (2*( (th(theta(i)))*x(2)+x(1)+x(3)+x(4) ));
 i = i+1;
 end
 
 theta
 
 % plot the estimate
 figure(1)
 subplot(211);
 plot(theta, 'b-*');
 xlabel('Iteration');
 ylabel('Theta');
 title('Problem 1 Estimate')
 
 % compute the log-likelihood
 K = length(theta);
 for k = 1:K
 ll(k) = (x(1)+x(2)+x(4))*log(theta(k)) + x(3)*log(1-2*theta(k));
 end
 
 % plot the log-likelihood
 subplot(212);
 plot(ll, 'ro-');
 xlabel('Iteration');
 ylabel('Log-Likelihood');
 title('Problem 1 Likelihood')
 
 %-----Problem 2:-----
 fprintf('-----------Problem 2----------\n');
 
 
 fprintf('----------Dataset 1---------\n');
 clear
 
 load ('hw6_2_data1.mat')
 Y1=Y;
 
 n=length(Y);
 figure(2)
 subplot(211);
 hist(Y);
 xlabel('Y');
 ylabel('Frequency');
 title('Data 1 Histogram')
 
 alpha(1,:) = [0.5 0.5];
 mu(1,:) = [0 5];
 sigma(1,:) = [1 0.5];
 
 u = 1;
 m = 1;
 while (u > 1e-6)
 for i = 1:n
 temp = alpha(m,:).*sigma(m,:).^(-1).*exp(-(Y(i)-mu(m,:)).^2./(2*sigma(m,:)));
 P(:,i,m) = temp'./sum(temp);
 end
 alpha(m+1,:) = mean(P(:,:,m),2)';
 mu(m+1,:) = sum(ones(2,1)*Y.*P(:,:,m),2)'./sum(P(:,:,m),2)';
 sigma(m+1,:) = sqrt(sum((ones(2,1)*Y-mu(m+1,:)'*ones(1,n)).^2.*P(:,:,m),2)'...
 ./sum(P(:,:,m),2)');
 u = max([norm(alpha(m+1,:)-alpha(m,:)) norm(mu(m+1,:)-mu(m,:)) ...
 norm(sigma(m+1,:)-sigma(m,:))]);
 
 m=m+1;
 end
 
 m
 
 % compute the log-likelihood
 K = length(alpha);
 for k = 1:K
 f1 = normpdf(Y,mu(k,1),sigma(k,1));
 f2 = normpdf(Y,mu(k,2),sigma(k,2));
 ll(k) = sum(log(alpha(k,1)*f1+alpha(k,2)*f2));
 end
 
 % plot the log-likelihood
 figure(3)
 subplot(211);
 plot(ll, 'r-');
 xlabel('Iteration');
 ylabel('Log-Likelihood');
 title('Data 1 Likelihood')
 
 
 fprintf('mu = (%4.3f, %4.3f), sigma = (%4.3f, %4.3f), alpha = (%4.3f, %4.3f) \n', mu(end,1), mu(end,2), sigma(end,1), sigma(end,2), alpha(end,1), alpha(end,2))
 
 fprintf('\n----------Dataset 2---------\n');
 
 load ('hw6_2_data2.mat')
 Y2=Y;
 n=length(Y);
 figure(2)
 subplot(212);
 hist(Y);
 xlabel('Y');
 ylabel('Frequency');
 title('Data 2 Histogram')
 
 alpha(1,:) = [0.5 0.5];
 mu(1,:) = [1 4];
 sigma(1,:) = [0.3 0.1];
 
 u = 1;
 m = 1;
 while (u > 1e-3)
 for i = 1:n
 temp = alpha(m,:).*sigma(m,:).^(-1).*exp(-(Y(i)-mu(m,:)).^2./(2*sigma(m,:)));
 P(:,i,m) = temp'./sum(temp);
 end
 alpha(m+1,:) = mean(P(:,:,m),2)';
 mu(m+1,:) = sum(ones(2,1)*Y.*P(:,:,m),2)'./sum(P(:,:,m),2)';
 sigma(m+1,:) = sqrt(sum((ones(2,1)*Y-mu(m+1,:)'*ones(1,n)).^2.*P(:,:,m),2)'...
 ./sum(P(:,:,m),2)');
 u = max([norm(alpha(m+1,:)-alpha(m,:)) norm(mu(m+1,:)-mu(m,:)) ...
 norm(sigma(m+1,:)-sigma(m,:))]);
 
 m=m+1;
 end
 
 m
 fprintf('mu = (%4.3f, %4.3f), sigma = (%4.3f, %4.3f), alpha = (%4.3f, %4.3f) \n', mu(end,1), mu(end,2), sigma(end,1), sigma(end,2), alpha(end,1), alpha(end,2))
 
 
 % compute the log-likelihood
 K = length(alpha);
 for k = 1:K
 f1 = normpdf(Y,mu(k,1),sigma(k,1));
 f2 = normpdf(Y,mu(k,2),sigma(k,2));
 ll(k) = sum(log(alpha(k,1)*f1+alpha(k,2)*f2));
 end
 
 % plot the log-likelihood
 figure(3)
 subplot(212);
 plot(ll, 'b-');
 xlabel('Iteration');
 ylabel('Log-Likelihood');
 title('Data 2 Likelihood')
 
 diary off
 
