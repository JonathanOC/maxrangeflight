function param = setup_params()

param.g = 9.81;
param.tf = 1800;
param.CD0 = 0.032;
param.AR = 7.5;
param.e = 0.8;
param.F = 845;
param.m = 276800;
param.Tmax = 1260000;
param.CLmin = 0;
param.CLmax = 1.48;

param.k = 1 / (pi * param.e * param.AR);
param.alpha = 1.247015;
param.beta = 0.000104;