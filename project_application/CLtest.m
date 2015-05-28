function y = CLtest(t, tOff)

global param;

if(t < tOff)
    y = param.CLmax/10;
else
    y = param.CLmax/100;
end