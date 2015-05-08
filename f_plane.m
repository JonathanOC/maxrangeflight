% The ODE function
% Input:    t - time
%           state - initial state of the system
%           T - control function concerning thrust as a function of t
%           CL - control function concerning lift as a function of t
% Output:   y - (dx, dh, dv, dgamma) solution of the ODE
% Date:     08/05/2015
% Author:   F.Rupp, P.Truoel

function y = f_plane(t, state, T, CL)

global param;

x = state(1);
h = state(2);
v = state(3);
gamma = state(4);

y = zeros(4,1);
y(1) = v * cos(gamma);
y(2) = v * sin(gamma);
y(3) = 1/param.m * (T - D(v,h,CL) - param.m * param.g*sin(gamma));
y(4) = 1 / (param.m *v) * (L(v,h,CL) - param.m * param.g*cos(gamma));
