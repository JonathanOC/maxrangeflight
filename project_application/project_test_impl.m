% main test file using implEuler.m
% Plots the trajectory of the plane for given control functions
% T and CL
% Date:     08/05/2015
% Author:   F.Rupp, P.Truoel


clear all;
close all;


global param;
param = setup_params();

ya = [0, 100, 300, 0.27]';
ta = 0;
te = 60;
N = 0.5*3e4; 


T = @(t) param.Tmax;
CL = @(t) param.CLmax/9;

func = @(t,state) f_plane(t, state, T(t), CL(t));

[yres, tres] = implEuler(func, ya, ta, te, N);
subplot(1,4,1);
plot(tres, yres(1,:));
xlabel('t');
ylabel('x');
subplot(1,4,2);
plot(tres, yres(2,:));
xlabel('t');
ylabel('h');
subplot(1,4,3);
plot(tres, yres(3,:));
xlabel('t');
ylabel('v');
subplot(1,4,4);
plot(tres, yres(4,:));
xlabel('t');
ylabel('gamma');

figure();
plot(yres(1,:), yres(2,:));