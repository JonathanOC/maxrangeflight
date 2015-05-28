function y = L(v,h,CL)
global param;

y = param.F * CL * qq(v,h);