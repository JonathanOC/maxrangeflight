function [y_start] = singleShooting(y_start_est, r, g, ta, te);
% y' = g(t,y(t)) ODE


ya = y_start_est;
N=1e3;
[tgrid, y] = ode45(g, linspace(ta,te,N), ya);
% calc S
para = y(:,1);
f = @(t, S, ii, para) [-3*para(ii)*S(2); -S(1); -3*para(ii)*S(4); -S(3)];
explEulerPara(f, [1;0;1;0], ta, te, N, para)



end