function [y, t] = implEuler(f, ya, ta, te, N);
t = linspace(ta, te, N+1);
tol = 1e-16;
h = (te-ta)/N;
y = zeros(numel(ya),N+1);
y(:,1) = ya;
for i = 1:N
    g = @(a) y(:,i)+h*f(t(i+1), a) - a;
    [y(:,i+1), numit]=newton(g, y(:,i), tol);
end