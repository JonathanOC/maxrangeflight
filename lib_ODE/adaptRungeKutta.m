function [yres, tres] = adaptRungeKutta(f, x0, ta, te, h0)
% calls the genericRungeKutta method with default coefficient parameters
% Date:     28/05/2015
% Author:   F.Rupp, P.Truoel
A_1 = [0 0 0; 0.5 0 0; -1 2 0];
b_1 = [1/6 4/6 1/6]';
c_1 = [0 0.5 1]';
A_2 = [0 0 0 0; 0.5 0 0 0; 0 0.5 0 0; 0 0 1 0];
b_2 = [1/6 1/3 1/3 1/6]';
c_2 = [0 0.5 0.5 1]';
[yres, tres] = genericAdaptRungeKutta(f, x0, ta, te, h0, A_1, b_1, c_1, A_2, b_2, c_2);
end

