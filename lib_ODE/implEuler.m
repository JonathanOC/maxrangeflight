% implicite Euler method
% Input:    f   - function handle, multidimensional output: column vector
%           ya - initial value of state
%           ta - start time
%           te - end time
%           N - number of partitions of the time
% Output:   y - value y(i) of the solution at t(i)
%           t - time partition
% Date:     08/05/2015
% Author:   F.Rupp, P.Truoel

function [y, t] = implEuler(f, ya, ta, te, N);
t = linspace(ta, te, N+1);
tol = 1e-10;
h = (te-ta)/N;
y = zeros(numel(ya),N+1);
y(:,1) = ya;
for i = 1:N
    g = @(a) y(:,i)+h*f(t(i+1), a) - a;
    [y(:,i+1), numit]=newton(g, y(:,i), tol);
end