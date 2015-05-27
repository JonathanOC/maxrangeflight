function [y_start] = singleShooting(y_start_est, r, g, ta, te);
% y' = g(t,y(t)) ODE

f = @(t, S, ii, para) [ -S(3); -3*para(ii)*S(1); -S(4); -3*para(ii)*S(2)];

norm_dd = 1;
norm_rr = 1;
z=0;
while norm_dd > 10^3*eps && norm_rr > 10^-8 && z<10^4
    z = z+1;
    if z == 1
        ya = y_start_est;
    end
    N=1e3;
    [tgrid, y] = ode45(g, linspace(ta,te,N), ya);
    % calc S
    para = y(:,1);
    
    Svec = explEulerPara(f, [1;0;0;1], ta, te, N, para);
    %solve lin sys
    AA = [-1 0;0 0] + [0 0;5*Svec(1,N)-Svec(2,N) 5*Svec(3,N)-Svec(4,N)];
    bb = -r(0,ya(1),y(end,:));
    dd = AA\bb;
    ya = ya + dd;
    norm_dd = norm(dd);
    norm_rr = norm(bb);
    
end


end