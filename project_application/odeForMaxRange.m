function [ dy ] = odeForMaxRange(t,y,p)

global param;

dy=zeros(4,1);
dy(1)=y(3)*cos(y(4));
dy(2)=y(3)*sin(y(4));
dy(3)=(1/param.m)*(p(1)-param.F *(param.CD0 + param.k *(p(2))^2)*(1/2)*param.alpha*exp(1)^(-param.beta*y(2))*(y(3))^2-param.m*param.g*sin(y(4)));
dy(4)=(1/(param.m*y(3)))*(param.F*p(2)*(1/2)*param.alpha*exp(1)^(-param.beta*y(2))*(y(3))^2-param.m*param.g*cos(y(4)));


end

