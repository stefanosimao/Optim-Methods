function [x, rvec, F] = BFGS (x0,y0,tol,N,bkt)
% Rosenbrock's function
f=@(x,y)(1 - x).^2 + 100 * (y - x.^2).^2;
df=@(x,y)[2 * (200 * x^3 - 200 * x * y + x - 1), 200 * (y - x^2)];
d2f=@(x,y)[1200 * x^2 - 400 * y + 2, -400 * x; -400 * x, 200];

x = x0;
y = y0;
x_old = x;
y_old = y;
rvec = [];
Xarr = [];
Yarr = [];
F = [];
i = 1;
gr = df(x,y);
gr_old = gr;
alpha = 1;
H = eye(2);
I = eye(2);

[X,Y] = meshgrid(0:.1:1, 0:.1:1);
fun = f(X,Y);
contour(X,Y,fun)
if bkt == 1
    title({"BFGS"; 'with Backtracking'});
else
    title({"BFGS"; 'without Backtracking'});
end
pbaspect([1 1 1])
hold on;

Xarr(1) = x;
Yarr(1) = y;

F(i) = f(x,y);
while (i < N && norm(gr_old) >= tol)
 p_k = -H * gr_old';
 if bkt == 1
    alpha = backtracking(f,df,alpha,0.9,10^(-4),x,y,p_k);
 end
 x = x_old + alpha * p_k(1);
 y = y_old + alpha * p_k(2);
 gr = df(x,y);
 x_all = [x;y];
 x_all_old = [x_old;y_old];
 s = x_all - x_all_old;
 gamma = gr' - gr_old';
 H = (I - (s * gamma')/(gamma' * s)) * H * (I - (gamma * s')/(gamma' * s)) + (s * s')/(gamma' * s);
 i = i + 1;
 Xarr(end + 1) = x;
 Yarr(end + 1) = y;
 rvec(i) = norm(gr);
 F(i) = f(x,y);
 x_old = x;
 y_old = y;
 gr_old = gr;
end

plot(Xarr,Yarr, '-r*');
end