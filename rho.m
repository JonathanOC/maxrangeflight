function y = rho(h)
global param;

y = param.alpha .* exp(-param.beta .* h);