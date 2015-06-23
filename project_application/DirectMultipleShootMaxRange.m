%%Direct multiple shooting applied to project
clear all;
close all;

global param;
param = setup_params();

%grid properties
N = 10;%only even vals!

%physical properties
x_0 = 0;
h_0 = 10660;
v_0 = 100;
gamma_0 = 0.27;
startvals = [x_0; h_0; v_0; gamma_0];

x_est = 1000;
h_est = 10668;
v_est = 100;
gamma_est = 0.27;
goalvals = [x_est; h_est; v_est;gamma_est];

%Create estimate for ALL optimization variables
%that is, discretized states and controls
T_max = param.Tmax; % maximale Schubkraft
CL_max = param.CLmax; % maximaler Auftriebswert

Te = 10; %estimated final time in s
dt = Te/N; %time step for integration
x0 = [linspace(startvals(1),goalvals(1),N+1),linspace(startvals(2),goalvals(2),N+1),linspace(startvals(3),goalvals(3),N+1),linspace(startvals(4),goalvals(4),N+1),T_max/2*ones(1,N+1),CL_max/2*ones(1,N+1)]';
%length(x0);
%define empty arrays for non used constraints
Adummy = zeros(6*N+6);
bdummy = 0*x0;

%define box constraints lb and ub
ub = [10^6*ones(N+1);10^5*ones(N+1);4*v_0*ones(N+1);pi*ones(N+1);T_max*ones(N+1); CL_max*ones(N+1)];
lb = [0*ones(N+1);-10^5*ones(N+1);10*ones(N+1);-pi*ones(N+1);0*ones(N+1); param.CLmin*ones(N+1)];
%length(lb);

options = optimoptions(@fmincon,'Display','iter-detailed', 'MaxFunEvals', 2500);

x = fmincon(@(x) MaxRangeTimeOpt(x,N),x0,Adummy,bdummy,Adummy,bdummy,lb,ub,@(x) MaxRangenonlcon(x,startvals,goalvals,N,dt),options);

%MaxRangetimeOpt ok
%x0: für u=x(4*N+5:6*N+6) (?) noch andere geschaetzte Werte moeglich
%Adummy, bdummy ok
%ub, lb koennen noch angepasst werden
% Bem.: ub(1:N+1) soll gross sein (inf)
% MaxRangenonlcon richtig?
%options ok

tres=linspace(0,Te,N+1);
yres=zeros(4,N+1);
yres(1,:)=x(1:N+1);
yres(2,:)=x(N+2:2*N+2);
yres(3,:)=x(2*N+3:3*N+3);
yres(4,:)=x(3*N+4:4*N+4);

subplot(1,4,1);
plot(tres, yres(1,:));
xlabel('t');
ylabel('x');
subplot(1,4,2);
plot(tres, yres(2,:));
xlabel('t');
ylabel('h');
subplot(1,4,3);
plot(tres, yres(3,:));
xlabel('t');
ylabel('v');
subplot(1,4,4);
plot(tres, yres(4,:));
xlabel('t');
ylabel('gamma');

figure();
plot(yres(1,:), yres(2,:));


