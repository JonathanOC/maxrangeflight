function [c,ceq] = nonlcon(x,startvals,goalvals,N)
c = 0;

uncont = zeros(3*N,1);

for ti = 1:N
    xt = [x(ti);x(N+1+ti);x(2*N+2+ti)];
    p = x(3*N+3+ti);
    [gridt, xinth] = ode45(@(t,y) rocketveh(t,y,p),[0 1],xt); %parameter p rein
    
    xtpe = [x(ti+1);x(N+1+ti+1);x(2*N+2+ti+1)];
    
    uncont(((ti-1)*3+1):(ti*3)) = xtpe-xinth(end,:)';
    
end



ceq = [x(1)-startvals(1);x(N+2)-startvals(2);x(N+1)-goalvals(1);x(2*N+2)-goalvals(2);uncont];





end

