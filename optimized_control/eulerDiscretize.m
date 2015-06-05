function [x, u] = eulerDiscretize(t, phi, f, x0, u0, psi, n_psi, c, n_c, s, n_s, lb, ub)
% params
% t: time lattice
% phi: function handle phi(x_0, x_end) Mayer term to minimize
% f: function handle f(t,x,u)
% x0: column vector, initial guess for x
% u0: column vector, initial guess for u
% psi: function handle psi(x_0, x_end) boundary conditions
% n_psi: dimension of psi
% c: function handle c(t,x,u) mixed controll and state constraints
% n_c: dimension of c
% s: function handle s(t,x) pure state constraints
% n_s: dimension of s
% lb, ub: vectors, box constraints for u
N = length(t)-1;
% nonlinear inequalities
n_x = length(x0);
n_u = length(u0);
function [constr, constreq] = mycon(z)
    constr = zeros((n_c + n_s)*(N+1),1);
    for i = 1:N+1
        x(i) = z(1+(i-1)*n_x:i*n_x);
        u(i) = z((N+1)*n_x+1+(i-1)*n_u:(N+1)*n_x+i*n_u);
        constr(1+(i-1)*n_c:i*n_c) = c(t(i),x(i), u(i));
        constr(1+(N+1)*n_c+(i-1)*n_s:(N+1)*n_c+i*n_s) = s(t(i), x(i));
    end
    % nonlinear equalities
    n_x = length(x_0);
    constreq = zeros(n_x*N+n_psi,1);
    for i=1:N
        h_i = t(i+1)-t(i);
        constreq(1+(i-1)*n_x:i*n_x)=x(i)+h_i*f(t(i), x(i), u(i))-x(i+1);
    end
    constreq(n_x*N+1:end) = psi(x(1), x(N+1));
end
% boxing constraints
lb_new=[-inf * ones(n_x*(N+1),1); repmat(lb,N+1, 1)];
ub_new=[inf*ones(n_x*(N+1),1); repmat(ub,N+1, 1)];
z = fmincon(phi, [x0;u0], [],[],[],[], lb_new, ub_new, mycon);
x = reshape(z(1:n_x*(N+1)), n_x, N+1);
u = reshape(z(n_x*(N+1)+1, end), n_u, N+1);
