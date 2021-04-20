	function b = backsub(X,y)
	l = size(X);
	n = l(2);
	b(n, 1) = y(n, 1)/X(n, n);
	for j = n - 1 : -1 : 1
		b(j, 1) = (y(j, 1) - X(j, j + 1 : n) * b(j + 1 : n, 1))/X(j, j);
	end
