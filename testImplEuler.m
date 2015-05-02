f = @(t, y) y;
ya=1;
ta=0;
te=1;
N = 2.^(2:8);  
yres = zeros(1, N(end));
tres = zeros(1, N(end));
colors = ['k','b','c', 'r', 'm', 'g', 'y'];

for i=1:numel(N)
    [yres, tres]=implEuler(f, ya, ta, te, N(i));
    plot(tres, yres, colors(i));
    hold on;
    pause(0.5);
end
plot(tres, exp(tres), 'b--');    