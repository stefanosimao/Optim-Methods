function [x, rvec, F]=CG(x0)
%Conjugate Gradient method

%Initialization
A = [2 -1 0;-1 2 -1; 0 -1 2];
b = [4;0;0];
x = x0;
rvec = [];
Xarr = [];
Yarr = [];
F = [];
max_itr = 10;
tol = 10^(-8);

r = b - A * x0;
d = r;
p_old = dot(r,r);
i = 1;
%The first iteration is actually the status before it starts. Iteration 1
%starts at position 2
rvec(i) = norm(r);
%F(i) = x0(1,1)^2 + mu * x0(2,1)^2;

Xarr(1) = x0(1,1);
Yarr(1) = x0(2,1);

while (i < max_itr && norm(r) > tol)
    s = A * d;
    alpha = p_old / dot(d, s);
    x = x + alpha * d
    r = r - alpha * s;
    p_new = dot(r,r);
    beta = p_new/p_old;
    d = r + beta * d;
    p_old = p_new;
    i = i + 1;
    Xarr(end + 1) = x(1,1);
    Yarr(end + 1) = x(2,1);
    rvec(i) = norm(r);

    %F(i) = x(1,1)^2 + mu * x(2,1)^2;
end
end