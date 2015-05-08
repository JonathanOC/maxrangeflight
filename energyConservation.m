function E = energyConservation(t, v, dv, dh, T, D);
global param;
W=param.m*param.g;
E = @(t) m*dv(t)*v(t) + W*dh(t) + (T(t)-D(t))*v(t);