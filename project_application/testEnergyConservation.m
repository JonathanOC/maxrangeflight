%clear all;
%close all;


global param;
param = setup_params();

ya = [0, 100, 300, 0.27]';
ta = 0;
te = 60;
N = 3e4;
dt = (te-ta)/N;

T = @(t) param.Tmax;
CL = @(t) param.CLmax/9;

func = @(t,state) f_plane(t, state, T(t), CL(t));

[yres, tres] = implEuler(func, ya, ta, te, N);

ind = 1:N;
dyres = (yres(:,2:end) - yres(:,1:N))/dt;
dx = dyres(1,:);
dh = dyres(2,:);
dv = dyres(3,:);
drag = D(yres(3,:),yres(2,:),CL(ind));
thrust = param.CLmax/9*ones(1,N);

P = energyConservation(ind, dx, dv, dh, thrust, drag);
plot(tres(1:end-1),P)