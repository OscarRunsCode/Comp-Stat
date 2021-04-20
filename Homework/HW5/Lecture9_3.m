x=[ 4 6 3 2 1]';
v=house(x);
H=eye(5)-2*v*v'/(v'*v)
X=[4 3 5; 6 6 7; 3 7 8; 2 4 4; 1 2 5];
X=rowhouse(X,v)
v2=(house(X(2:5,2)))
H2t=eye(4)-2*v2*v2'/(v2'*v2)
H2=blkdiag(eye(2),H2t)
%H2*X
v3=(house(X(3:5,3)))
H3t=eye(3)-2*v3*v3'/(v3'*v3)
H3=blkdiag(eye(2),H3t)
H3*X