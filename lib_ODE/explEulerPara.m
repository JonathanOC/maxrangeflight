function [y, t] = explEulerPara(f, ya, ta, te, N, para)

t = linspace(ta, te, N);
h = (te-ta)/(N-1);
y = zeros(numel(ya),N);
y(:,1) = ya;
for i = 1:(N-1)
    dy = f(t(i), y(:,i), i, para);
    y(:,i+1) = y(:,i) + h*dy;
end