function y = D(v,h,CL)
global param;

y = param.F .* CD(CL) .* qq(v,h);