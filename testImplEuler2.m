clear all
close all
gamma = [5:5:50];clf;


f = @(t, y, g) [-y(1), -g*y(2) + ((g-1)*y(1) + g*y(1)^2)/((1+y(1))^2)]';

ya(1)=2;
ya(2)=1.5;

ta=0;
te=10;
N = 2.^(9:9);  
yres = zeros(2, N(end));
tres = zeros(1, N(end));

for k=1:numel(gamma)
    figure(k)
    title(['gamma = ', num2str(gamma(k))]);
    colors = ['k','b','c', 'r', 'm', 'g', 'y'];

    for i=1:numel(N)
        [yres, tres] = implEuler(@(t,y) f(t,y,gamma(k)), ya, ta, te, N(i));
        plot(yres(1,:), yres(2,:), colors(i));
        hold on;
    end
    
end