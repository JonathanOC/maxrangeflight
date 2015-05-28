function [y, t] = rungeKutta(f, y0, ta, te, N, A, b, c)

t = linspace(ta, te, N+1);
h = (te-ta)/N;
y = zeros(numel(y0),N+1);
y(:,1) = y0;

s = length(b);
n = length(y0);

tol = 1e-6;

k = zeros(n,s);
kNew = k;

for i = 1:N
    %calculate k
    while(true)
        for j =1:s
            
            kNew(:,j) = f(t(i) + c(j) * h, y(:,i) + h * k * (A(j,:)'));
        end
        
        if(max(abs(k - kNew)) < tol)
            break;
        end
        k = kNew;
    end
    
    dy = k * b;
    y(:,i+1) = y(:,i) + h*dy;
    
end