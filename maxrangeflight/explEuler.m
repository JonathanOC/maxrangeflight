function [y, t] = explEuler(f, ya, ta, te, N);
t = linspace(ta, te, N+1);
h = (te-ta)/N;
y = zeros(numel(ya),N+1);
y(:,1) = ya;
for i = 1:N
    y(:,i+1)=y(:,i)+h*f(t(i), y(:,i));
end