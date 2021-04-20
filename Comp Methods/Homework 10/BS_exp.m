 %% bootstrap example

x = [94 197 16 38 99 141 23];

%y = [52 104 146 10 51 30 40 27 46];

lx = length(x);

B = 50000;

bx = zeros(B, lx);
for i = 1:B
    bx(i,:) = randsample(x,lx,true);
end

% standard error of mean
semnx = std(mean(bx,2)),

% standard error of median
semdx = std(median(bx,2)),

% true standard error of mean
tsemnx = std(x,1)/sqrt(lx), 


%% Law example
clear;
load hw10_1_data;

n = 15;
m = 2;
ind0 = [72 14 80 22 73 82 29 20 57 51 70 81 23 28 60]; 

x = X(ind0,:);
temp = corrcoef(x(:,1), x(:,2));
cc0 = temp(1,2);

B = 2000;
bx = zeros(n, m, B);
for i = 1:B
    ind = randsample(n, n, 'true');
    bx(:,:,i) = x(ind,:);
end

% corrcoefs
for i = 1:B
    temp = corrcoef(bx(:,1,i), bx(:,2,i));
    cc(i) = temp(1,2);
end

% standard errors
t = B/100:B/100:B;
for k = 1:100
    sdcc(k) = std(cc(1:k*B/100));
end

figure(1);
plot(cc);
figure(2);
plot(t, sdcc);
xlabel('B', 'fontsize', 16);
ylabel('SE_B', 'fontsize', 16);

% bias
bias = mean(cc) - cc0,
