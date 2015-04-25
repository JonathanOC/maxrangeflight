function [dx dh dv dgamma] = f_plane(t, x, h, v, gamma, T, CL, CD, q, rho)

setup_params;

L = @(a,b,c) (F * c * q(a,b));
D = @(a,b,c) (F * CD(c) * q(a,b));

dx = v * cos(gamma);
dh = v * sin(gamma);
dv = 1/m * (T(t) - D(v,h,CL(t)) - m*g*sin(gamma));
dgamma = 1 / (m*v) * (L(v,h,CL(t)) - m*g*cos(gamma));