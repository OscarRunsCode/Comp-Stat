% example for Nearest Neighbor

clear; close;

load hw3_3_data;

[m,n] = size(X);

% show all data
for i = 1:m
    I = reshape(X(i,:),28,23);
    imagesc(I);
    colormap(gray)
    axis equal;
    pause(0.5);
end 

% find the nearest neighbor
for i = 1:m
    for j = 1:m
        d(i,j) = norm(X(i,:)-X(j,:));
    end
    [dis, dis_ind] = sort(d(i,:));
    nn(i) = dis_ind(2);
end

% label of the nearest neighbor
subplot(211);
plot(nn);

% label distance 
subplot(212);
plot(nn-(1:m));
ylim([-5 5]);






