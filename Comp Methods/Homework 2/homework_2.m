clear 
clc

x = [6 3 9 2; 0 4 6 1; 0 0 8 8; 0 0 0 5];
y = [1; 4; 6; 1];

b = backsub(x,y)

clear x

x = [1.4; 5.8; 2.3; 8.1; 9.0];

v = house(x)

clear x

x = [1.4 4.5 6.5; 5.8 3.2 7.3; 2.3 -2.6 8.2; 8.1 -5.8 -8.0; 9.0 0.3 1.5];

X = rowhouse(x,v)

clear x
clear y

x = [5 0 9 3; 3 6 8 9; 4 4 9 6; 0 3 1 8; 2 8 2 3]
y = [20; 17; 32; 10; 12]

b = multilinreg(x,y)