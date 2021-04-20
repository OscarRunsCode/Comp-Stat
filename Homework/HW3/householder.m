	function X = householder(X)
	[m, n] = size(X);
	v = zeros(m, 1);
	for j = 1 : n
		v(j : m, 1) = house(X(j : m, j));
        X(j : m, j : n) = rowhouse(X(j : m, j : n), v(j : m, 1));       
	end
