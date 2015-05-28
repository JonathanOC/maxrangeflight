%clear all
close all

g = @(t, y) [-y(2)-15*exp(-2*t); -3/2*y(1)^2];
ta = 0;
te = 1;
y_start_est = [4;-5];
%ya = y(0);
%ye = y(1);
r = @(y, alpha, beta) [4-alpha; 5*(beta(1)-1) - beta(2)];

singleShooting(y_start_est, r, g, ta, te);