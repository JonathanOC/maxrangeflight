clear all;
close all;


global param;
param = setup_params();

ya = [0, 100, 300, 0.27]';
ta = 0;
te = 60;
N = 3e4; 

T = @(t) param.Tmax;
CL = @(t) param.CLmax/9;

func = @(t,state) f_plane(t, state, T(t), CL(t));

[yres, tres] = explEuler(func, ya, ta, te, N);


 E = energyConservation(t, dx, dv, dh, T, D);