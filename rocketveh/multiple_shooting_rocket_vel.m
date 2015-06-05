%%Direct multiple shooting applied to rocketvehicle

%grid properties
N = 30;%only even vals!

%physical properties
startvals = [1;1];
goalvals = [0;0];

%Create estimate for ALL optimization variables
%that is, discretized states and controls
Te = 5; %estimated final time
x0 = [linspace(startvals(1),goalvals(1),N+1),linspace(startvals(2),goalvals(2),N+1),Te*ones(1,N+1),[-0.999*ones(1,N/2),0.999*ones(1,N/2+1)]]';

%define empty arrays for non used constraints
Adummy = zeros(4*N+4);
bdummy = 0*x0;

%define box constraints lb and ub
ub = [10^4*ones(2*N+2,1);10^4*ones(N+1,1);ones(N+1,1)];
lb = -ub;
lb((2*N+3):(3*N+3)) = 10^-4;

options = optimoptions(@fmincon,'Display','iter-detailed');

x = fmincon(@(x) timeOpt(x,N),x0,Adummy,bdummy,Adummy,bdummy,lb,ub,@(x) nonlcon(x,startvals,goalvals,N),options)

