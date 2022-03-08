function [x, lenerr]=CG2(A,b,x0,tol,max_itr)
%Conjugate Gradient method

%Initialization
rvec = [];
lenerr = [];

%Exact solution
x_e = A\b;

r = b - A * x0;
d = r;
p_old = dot(r,r);
i = 1;

rvec(i) = norm(r);
x = x0;

while (i < max_itr && norm(r)/norm(b) > tol)
    s = A * d;
    alpha = p_old / dot(d, s);
    x = x + alpha * d;
    r = r - alpha * s;
    p_new = dot(r,r);
    beta = p_new/p_old;
    d = r + beta * d;
    p_old = p_new;
    
    i = i + 1;
    
    lenerr(i) = log((x - x_e)' * A * (x - x_e));
    rvec(i) = norm(r);
    

end
end