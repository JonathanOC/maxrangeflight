function Peff = energyConservation(t, dx, dv, dh, T, D)
global param;
W=param.m*param.g;
Peff = param.m.*dv(t).*dx(t) + W.*dh(t) + (T(t)-D(t)).*dx(t);