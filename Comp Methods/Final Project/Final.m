%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Final Project %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc

N = 1000;
sigma = 1;
p = .99;

for i = 1:5
    
    %%%% Generate Initial Value of x
    x(1) = (rand < .5);
    
    %%%% Generate Remaining Values of x
    for j = 2:N
        if rand < p
            x(j) = x(j-1);
        else
            x(j) = 1-x(j-1);
        end
    end
    
    %%%% Generate Noisy Observations
    for k =1:N
        y(k) = x(k)+normrnd(0,sigma);
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%% Pseudo Code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%% Step 1
    
    s(1,1) = -(y(1)^2)/(2*sigma^2);
    s(1,2) =-((y(1)-1)^2)/(2*sigma^2);
    
    %%% Step 2
    
    for k = 2:N
        for j = 1:2
            h(1) = s(k-1,1) - .5/sigma^2*(y(k)-(j-1))^2 + log((j==1)*p + (j==2)*(1-p)); %sum from 1 to k for x(k-1) = 0
            h(2) = s(k-1,2) - .5/sigma^2*(y(k)-(j-1))^2 + log((j==2)*p + (j==1)*(1-p)); %sum from 1 to k for x(k-1) = 1
            
            if h(1) > h(2)
                b(k,j) = 0;
                s(k,j) = h(1);
            else
                b(k,j) = 1;
                s(k,j) = h(2);
            end
        end
    end
    
    %%% Step 3
    
    z(N) = (s(N,1) < s(N,2));
    for k=N-1:-1:1
        z(k) = b(k+1,z(k+1)+1);
    end
    
    for k = 1:1000
        if z(k) == x(k)
            S(k) = 1;
        else
            S(k) = 0;
        end
        s = sum(S);
    end
    
    success(i) = s/N
    average1 = mean(success)
end





figure(4); clf; 
plot(1:N, y, 'g'); hold on;
plot(1:N, x, 'b', 'linewidth', 2);
plot(1:N, z, 'r', 'linewidth', 2);
legend('Observed', 'True', 'Reconstructed');
title('Figure 4')

figure(1); clf;
plot(1:N, y, 'g');
xlabel('Observations')
ylabel('Noisy Values')
title('Figure 1')

figure(2)
plot(1:N, x, 'b', 'linewidth', 2);
xlabel('Observations')
ylabel('Original Values')
title('Figure 2')

figure(3)
plot(1:N, z, 'r', 'linewidth', 2);
xlabel('Observations')
ylabel('Reconstructed Values')
title('Figure 3')




N = 1000;
sigma = 1;
p = [.9 .8 .7 .6];

for m = 1:4
    
    for i = 1:5
        
        %%%% Generate Initial Value of x
        x(1) = (rand < .5);
        
        %%%% Generate Remaining Values of x
        for j = 2:N
            if rand < p(m)
                x(j) = x(j-1);
            else
                x(j) = 1-x(j-1);
            end
        end
        
        %%%% Generate Noisy Observations
        for k =1:N
            y(k) = x(k)+normrnd(0,sigma);
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%% Pseudo Code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%% Step 1
        
        s(1,1) = -(y(1)^2)/(2*sigma^2);
        s(1,2) =-((y(1)-1)^2)/(2*sigma^2);
        
        %%% Step 2
        
        for k = 2:N
            for j = 1:2
                h(1) = s(k-1,1) - .5/sigma^2*(y(k)-(j-1))^2 + log((j==1)*p(m) + (j==2)*(1-p(m))); %sum from 1 to k for x(k-1) = 0
                h(2) = s(k-1,2) - .5/sigma^2*(y(k)-(j-1))^2 + log((j==2)*p(m) + (j==1)*(1-p(m))); %sum from 1 to k for x(k-1) = 1
                
                if h(1) > h(2)
                    b(k,j) = 0;
                    s(k,j) = h(1);
                else
                    b(k,j) = 1;
                    s(k,j) = h(2);
                end
            end
        end
        
        %%% Step 3
        
        z(N) = (s(N,1) < s(N,2));
        for k=N-1:-1:1
            z(k) = b(k+1,z(k+1)+1);
        end
        
        for k = 1:1000
            if z(k) == x(k)
                S(k) = 1;
            else
                S(k) = 0;
            end
            s = sum(S);
        end
        
        success(i) = s/N;
    end
    average2(m) = mean(success);
end

figure(5)
plot(average2)
ylabel('Success Rate')
xlabel('Values of p')
title('Figure 5')



N = 1000;
sigma = [.5 1 2 5];
p = .99;

for m = 1:4
    
    for i = 1:5
        
        %%%% Generate Initial Value of x
        x(1) = (rand < .5);
        
        %%%% Generate Remaining Values of x
        for j = 2:N
            if rand < p
                x(j) = x(j-1);
            else
                x(j) = 1-x(j-1);
            end
        end
        
        %%%% Generate Noisy Observations
        for k =1:N
            y(k) = x(k)+normrnd(0,sigma(m));
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%% Pseudo Code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%% Step 1
        
        s(1,1) = -(y(1)^2)/(2*sigma(m)^2);
        s(1,2) =-((y(1)-1)^2)/(2*sigma(m)^2);
        
        %%% Step 2
        
        for k = 2:N
            for j = 1:2
                h(1) = s(k-1,1) - .5/sigma(m)^2*(y(k)-(j-1))^2 + log((j==1)*p + (j==2)*(1-p)); %sum from 1 to k for x(k-1) = 0
                h(2) = s(k-1,2) - .5/sigma(m)^2*(y(k)-(j-1))^2 + log((j==2)*p + (j==1)*(1-p)); %sum from 1 to k for x(k-1) = 1
                
                if h(1) > h(2)
                    b(k,j) = 0;
                    s(k,j) = h(1);
                else
                    b(k,j) = 1;
                    s(k,j) = h(2);
                end
            end
        end
        
        %%% Step 3
        
        z(N) = (s(N,1) < s(N,2));
        for k=N-1:-1:1
            z(k) = b(k+1,z(k+1)+1);
        end
        
        for k = 1:1000
            if z(k) == x(k)
                S(k) = 1;
            else
                S(k) = 0;
            end
            s = sum(S);
        end
        
        success(i) = s/N;
    end
    average3(m) = mean(success);
end

figure(6)
plot(average3)
ylabel('Success Rate')
xlabel('Values of Sigma^2')
title('Figure 6')

