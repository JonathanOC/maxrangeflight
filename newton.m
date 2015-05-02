% Calculates a root of a function f using Newtons Method.
% Input:    f   - function handle, multidimensional output: column vector
%           x0  - inital value as a column vector
%           tol - tolerance 
% Output:   x   - root of f, i.e. f(x) = 0
%           nit - number of iterations
% Date:     02/05/2015
% Author:   F.Rupp

function [x,nit] = newton(f,x0,tol)

df = @(x)jacobianest(f, x);

nit = 0;
x = x0;
fx0 = norm(f(x0));

while norm(f(x)) > tol*max(norm(fx0),1e-10)
    x = x - (df(x))^(-1)*f(x);
    nit = nit + 1;
end