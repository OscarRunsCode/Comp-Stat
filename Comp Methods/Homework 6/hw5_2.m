%  EM process

clear;

load hw5_2_data2;

n = length(Y);
subplot(211);
hist(Y);

% alpha(1,:)= [0.5 0.5];
% mu(1,:) = [0 5];
% sigma(1,:) = [1 0.5];

alpha(1,:)= [0.5 0.5];
mu(1,:) = [1 4];
sigma(1,:) = [0.3 0.1];

u = 1;
m = 1;
while (u > 1e-3)
    for i = 1:n
        temp = alpha(m,:).*sigma(m,:).^(-1).*exp(-(Y(i)- mu(m,:)).^2./(2*sigma(m,:).^2));
        P(:,i,m) = temp'./sum(temp);
    end
    alpha(m+1,:) = mean(P(:,:,m),2)';
    mu(m+1,:) = sum(ones(2,1)*Y.*P(:,:,m),2)'./sum(P(:,:,m),2)';
    sigma(m+1,:) = sqrt(sum((ones(2,1)*Y-mu(m+1,:)'*ones(1,n)).^2.*P(:,:,m),2)' ...
                   ./ sum(P(:,:,m),2)');
    u = max([norm(alpha(m+1,:)-alpha(m,:)) norm(mu(m+1,:)-mu(m,:)) ...
                            norm(sigma(m+1,:)-sigma(m,:))]);
    m = m+1;
end

disp(sprintf('mu = (%4.3f, %4.3f), sigma = (%4.3f, %4.3f), alpha = (%4.3f, %4.3f)', ...
      mu(end,1), mu(end,2), sigma(end,1), sigma(end,2), alpha(end,1), alpha(end,2)));

% compute the log-likelihood
M = size(alpha,1);
for m = 1:M
    ll(m) = sum(log(alpha(m,1)*normpdf(Y, mu(m,1), sigma(m,1)) +  ...
                    alpha(m,2)*normpdf(Y, mu(m,2), sigma(m,2))));
end

% plot the log-likelihood
subplot(212);
plot(ll, 'ro-');


