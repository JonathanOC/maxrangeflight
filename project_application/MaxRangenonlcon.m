function [c,ceq] = MaxRangenonlcon(x,startvals,goalvals,N,dt)
c = 0; %aus Bedingung ceq(x)=c

uncont = zeros(4*N,1); %Dimension richtig?
%length(uncont)

for ti = 1:N
    xt = [x(ti);x(N+1+ti);x(2*N+2+ti);x(3*N+3+ti)]; %initial conditions for ode
    
    
    p = [x(4*N+4+ti);x(5*N+5+ti)]; %Steuerung
    
    % ODE neu schreiben rocketveh
    [gridt, xinth] = ode45(@(t,y) odeForMaxRange(t,y,p),[(ti-1)*dt ti*dt],xt); %parameter p rein
    
    
    xtpe = [x(ti+1);x(N+1+ti+1);x(2*N+2+ti+1);x(3*N+3+ti+1)];
    uncont(((ti-1)*4+1):(ti*4)) = xtpe-xinth(end,:)';
    %length(uncont)
    
end

ceq = [zeros(4,1);zeros(length(uncont),1)];
ceq(1:4)=[x(1)-startvals(1);x(N+2)-startvals(2);x(2*N+3)-startvals(3);x(3*N+4)-startvals(4)];
ceq(5:end)=uncont;


end

