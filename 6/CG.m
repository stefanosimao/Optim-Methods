function [x, rvec, F]=CG(A,b,x0,tol,max_itr)
%Conjugate Gradient method

%Initialization
rvec = [];
F = [];

r = b - A * x0;
d = r;
p_old = dot(r,r);
i = 1;

rvec(i) = norm(r);
F(i) = 1/2 * (x0' * A * x0) - b' * x0; 
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

    rvec(i) = norm(r);
    F(i) = 1/2 * (x' * A * x) - b' * x; 

end
end