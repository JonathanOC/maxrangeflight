function [x, t] = adaptRungeKutta(f, x0, ta, te, h0, A1, b1, c1, A2, b2, c2)

% 1st step
t = ta;
x = x0;
h = h0;
dmin = 1e-7;
dmax = 1e-1;

x(:,1) = x0;
tol = 1e-6;

while (true)
    if (te < t + h)
        h = te - t;
    end
    while(true)
        for j =1:4
            kNew_4(:,j) = f(t) + c(j) * h, y(:,i) + h * k_4 * (A_2(j,:)');
        end
        
        if(max(abs(k_4 - kNew_4)) < tol)
            break;
        end
        k_4 = kNew_4;
    end
    % calculate local discrete deviation
    d = h*(-1/3*k_3(:, 2) + 1/3 * k_4(:, 3) + 1/6 * k_4(:,4) - 1/6 * k_3(:,3));

    if ((dmin <= d) && (d <= dmax))
        %h nehmen
    else if (dmax < d)
            h = 0.8 * h;
        else 
                h = 1.2 * h;
        end
    end

    
    
end
h = (te-ta)/N;
y = zeros(numel(y0),N+1);
y(:,1) = y0;

s = length(b);
n = length(y0);

tol = 1e-6;

k = zeros(n,s);
kNew_4 = k;

for i = 1:N
    %calculate k
    while(true)
        for j =1:s
            
            kNew_4(:,j) = f(t(i) + c(j) * h, y(:,i) + h * k * (A(j,:)'));
        end
        
        if(max(abs(k - kNew_4)) < tol)
            break;
        end
        k = kNew_4;
    end
    
    dy = k * b;
    y(:,i+1) = y(:,i) + h*dy;
    
