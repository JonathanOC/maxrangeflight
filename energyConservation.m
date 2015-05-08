function E = energyConservation(t, dx, dv, dh, T, D);
global param;
W=param.m*param.g;
E = @(t) param.m*dv(t)*dx(t) + W*dh(t) + (T(t)-D(t))*dx(t);