function [y, t] = explEulerPara(f, ya, ta, te, N, para)

t = linspace(ta, te, N+1);
h = (te-ta)/N;
y = zeros(numel(ya),N+1);
y(:,1) = ya;
for i = 1:N
    dy = f(t(i), y(:,i), i, para);
    y(:,i+1) = y(:,i) + h*dy;
end