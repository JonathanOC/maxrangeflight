function [y, t] = rungeKutta(f, ya, ta, te, N, A, b, c)

t = linspace(ta, te, N+1);
h = (te-ta)/N;
y = zeros(numel(ya),N+1);
y(:,1) = ya;

s = length(b);
%k = zeros(s,1);


%setup a function to calculate parameters k via newton
syms vart vary;
k = sym('k', [s,0])';
g = sym('g', [s,0])';

for j=1:s
    g_(vart, vary, k) = f(vart + c(j) * h, vary + h * A(j,:) * k);
    g(j) = g_;
end

phi = matlabFunction(g);



for i = 1:N
    
    for j =1:s
    
    
    [k(:,i+1), numit]=newton(g, y(:,i), tol);
    
    
    dy = f(t(i), y(:,i))';
    y(:,i+1) = y(:,i) + h*dy;
    
    end
end