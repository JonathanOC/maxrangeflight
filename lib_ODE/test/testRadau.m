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
ya3 =  @(t) [exp(t) - 4*t.*exp(t), exp(t) - 4*t.*exp(t) - 2*exp(2*t), 4*t.*exp(t) - 2*exp(2*t)]';
y03 = [1 -1 -2]';


N = 1e4;  
yres = zeros(2, N);
tres = zeros(1, N);

%% Radau
A = [5/12 -1/12; 3/4 1/4];
b = [3/4 1/4]';
c = [1/3 1]';

%Davis-Skodje
ta=0;
te=10;
figure(1);
[yres, tres] = rungeKutta(f1, y01, ta, te, N, A, b, c);
plot(yres(1,:), yres(2,:));
hold on;
ya = ya1(tres');
plot(ya(1,:), ya(2,:), 'r--');
hold off;

%Nicht-autonom
ta=0;
te=10;
figure(2);
[yres, tres] = rungeKutta(f2, y02, ta, te, N, A, b, c);
plot(tres, yres);
hold on;
plot(tres,ya2(tres), 'r--');
hold off;

%System
ta=0;
te=3;
figure(3);
[yres, tres] = rungeKutta(f3, y03, ta, te, N, A, b, c);
ya = ya3(tres');

for i=1:3
    subplot(1,3,i);
    plot(tres, yres(i,:));
    hold on;
    plot(tres, ya(i,:), 'r--');
    xlabel('t');
    ylabel(['y', num2str(i)]);
end
