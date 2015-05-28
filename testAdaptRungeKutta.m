clear all;
close all;

%% ODE definitions
%Davis-Skodje
f1_ = @(t, y, g) [-y(1), -g*y(2) + ((g-1)*y(1) + g*y(1).^2)./((1+y(1)).^2)]';
ya1_ = @(t, g) [exp(-t), exp(-g * t) + 1 ./ (1 + exp(t))]';
g = 10;
f1 = @(t,y) f1_(t,y,g);
ya1 = @(t) ya1_(t,g);
y01 = [1 1.5]';

%Nicht-autonome DGl
f2 = @(t,y) -2*t*y.^2;
ya2 = @(t) 1 ./ (1 + t.^2);
y02 = 1;

%System
f3 = @(t, y) [y(2) - y(3), -2*y(1) + 3*y(2) - y(3), -y(1) + y(2) + y(3)]';
ya3 =  @(t) [exp(t) - 4*t.*exp(t), exp(t) - 4*t.*exp(t) - 2*exp(2*t), 4*exp(t) - 2*exp(2*t)]';
y03 = [1 -1 -2]';


h0 = 0.1;
yres = zeros(2, 1);
tres = zeros(1, 1);

%% Runge-Kutta
A_1 = [0 0 0; 0.5 0 0; -1 2 0];
b_1 = [1/6 4/6 1/6]';
c_1 = [0 0.5 1]';
A_2 = [0 0 0 0; 0.5 0 0 0; 0 0.5 0 0; 0 0 1 0];
b_2 = [1/6 1/3 1/3 1/6]';
c_2 = [0 0.5 0.5 1]';

%Davis-Skodje
ta=0;
te=10;
figure(1);
[yres, tres] = adaptRungeKutta(f1, y01, ta, te, h0, A_1, b_1, c_1, A_2, b_2, c_2);
disp('example 1 finished')
plot(yres(1,:), yres(2,:));
hold on;
ya = ya1(tres');
plot(ya(1,:), ya(2,:), 'r--');
hold off;



%Nicht-autonom
ta=0;
te=10;
figure(2);
[yres, tres] = adaptRungeKutta(f2, y02, ta, te, h0, A_1, b_1, c_1, A_2, b_2, c_2);
disp('example 2 finished')
plot(tres, yres);
hold on;
plot(tres,ya2(tres), 'r--');
hold off;


%System
ta=0;
te=3;
figure(3);
[yres, tres] = adaptRungeKutta(f3, y03, ta, te, h0, A_1, b_1, c_1, A_2, b_2, c_2);
disp('example 3 finished')
ya = ya3(tres');


for i=1:3
    subplot(1,3,i);
    plot(tres, yres(i,:));
    hold on;
    plot(tres, ya(i,:), 'r--');
    xlabel('t');
    ylabel(['y', num2str(i)]);
end
