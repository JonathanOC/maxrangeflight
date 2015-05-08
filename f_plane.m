function y = f_plane(t, state, T, CL)

global param;
%T = param.Tmax;
%CL = param.CLmax;

x = state(1);
h = state(2);
v = state(3);
gamma = state(4);
%
%

y(1) = v * cos(gamma);
y(2) = v * sin(gamma);
y(3) = 1/param.m * (T - D(v,h,CL) - param.m * param.g*sin(gamma));
y(4) = 1 / (param.m *v) * (L(v,h,CL) - param.m * param.g*cos(gamma));