%clear all
close all

%Number of multiple shooting mesh points
Nb = 2;
%Number of time discretization points
Nt_inp = 10^3;
Ntb = round(Nt_inp/Nb);
Nt = (Ntb-1)*Nb+1;

%Problem specs
g = @(t, y) [-y(2)-15*exp(-2*t); -3/2*y(1)^2];
dimsys = 2; %system dimensionality
ta = 0;
te = 1;
yStartEst = [4;-5; 2; -3; 2; -4];
%ya = y(0);
%ye = y(1);
r = @(y, alpha, beta) [4-alpha; 5*(beta(1)-1) - beta(2)];

cd ..;
multipleShooting(yStartEst, r, g, ta, te, Nt, Nb, Ntb, dimsys);