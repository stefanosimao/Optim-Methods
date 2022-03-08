function [xvec, zvec, rvec] = TR(f, x_0, tol, delta_max, delta_0, eta, max_itr)
syms x y
x_k = x_0;
delta_k = delta_0;
g = gradient(f);
h = hessian(f,[x y]);
f_handle = matlabFunction(f);
g_handle = matlabFunction(g);
h_handle = matlabFunction(h);
B_k = h_handle(x_0(1), x_0(2));
xvec = [];
rvec = [];
norm_g = tol;
i = 1;
while i <= max_itr && norm_g >= tol
   xvec(:,i) = x_k;
 
   g_k = g_handle(x_k(1), x_k(2));
   p_b = -B_k\g_k;

   if norm(p_b) <= delta_k
     p = p_b;
    else
    p_u = -(transpose(g_k) * g_k) / (transpose(g_k) * B_k * g_k) * g_k;
    if norm(p_u) > delta_k
        if (transpose(g_k) * B_k * g_k) <= 0
            tau = 1;
        else
            tau = min((norm(g_k))^3/(delta_k * (transpose(g_k) * B_k * g_k)),1);
        end
    p = -tau * (delta_k/norm(g_k)) * g_k;
    else
        syms t
        tau = solve (norm(p_u + t * (p_b - p_u)) == delta_k, t);
        tau = max(tau(1), tau(2));
        tau = double(tau);
        p = p_u + tau * (p_b - p_u);
    end
   end
   f_k = f_handle(x_k(1), x_k(2));
   g_k = g_handle(x_k(1), x_k(2));
   rvec(:,i) = norm(g_k);
   norm_g = norm(g_k,2);
   m_k = f_k + transpose(g_k) * p + 0.5 * transpose(p) * B_k * p;
   rho_k = (f_k - f_handle(x_k(1) + p(1), x_k(2) + p(2)))/(f_k - m_k);
   
   if rho_k < 0.25
       delta_k = 0.25 * delta_k;
   else
       if rho_k > 3/4 && (norm(p) - delta_k < tol)
           delta_k = min(2 * delta_k, delta_max);
       end
   end
   if rho_k > eta
       x_k = x_k + p;
   end
   i = i + 1;
   B_k = h_handle(x_k(1),x_k(2));
end
xvec(:,i) = x_k;
rvec(:,i) = norm(g_k);
zvec = [];
for j = 1:i
    for k = 1:i
        zvec(j,k) = f_handle(xvec(1,j), xvec(2,k));
    end
end
