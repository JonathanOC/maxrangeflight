function [x, tres] = adaptRungeKutta(f, x0, ta, te, h0, A_1, b_1, c_1, A_2, b_2, c_2)
%A_i, b_i, c_i correspond to i+2 RungeKutta methods, i=1,2
% 1st step
t = ta;
x = x0;
h = h0;
dmin = 1e-5;
dmax = 1e-1;
tres(1)=ta;
x(:,1) = x0;
tol = 1e-6;
i=1;
k_3 = zeros(length(x0), length(b_1));
k_4 = zeros(length(x0), length(b_2));

while (true)
    if (te < t + h)
        h = te - t;
    end
    % calc k for 4 step
    while(true)
        for j =1:4
            kNew_4(:,j) = f(t + c_2(j) * h, x(:,i) + h * k_4 * (A_2(j,:)'));
        end
        
        if(max(norm(k_4 - kNew_4)) < tol)
            break;
        end
        k_4 = kNew_4;
    end
    % calc k for 3 step
    while (true)
        for j=1:3
            kNew_3(:,j) = f(t + c_1(j) * h, x(:,i) + h* k_3 * (A_1(j,:)'));
        end
        if (max(abs(k_3 - kNew_3)) < tol)
            break;
        end
        k_3=kNew_3;
    end
    
    % calculate local discrete deviation
    d = norm(h*(-1/3*k_3(:, 2) + 1/3 * k_4(:, 3) + 1/6 * k_4(:,4) - 1/6 * k_3(:,3)));
    if ((dmin <= d) && (d <= dmax))
        %h nehmen
        t = t+ h;
        tres(i+1)=t;
        x(:,i+1) = x(:,i) + h * k_3 * b_1;
        i = i + 1;
    else if (dmax < d)
            h = 0.8 * h;
        else
            if (abs(t+h- te)<tol)
                break
            else 
                h = 1.2 *h;
            end
        end
    end
    
end