function [x, rvec, F] = GD(x0,y0,tol,N,bkt)

% Rosenbrock's function
f=@(x,y)(1 - x).^2 + 100 * (y - x.^2).^2;
df=@(x,y)[2 * (200 * x^3 - 200 * x * y + x - 1), 200 * (y - x^2)];

x = x0;
y = y0;
rvec = [];
Xarr = [];
Yarr = [];
F = [];
i = 1;
gr = df(x,y);
alpha = 1;

nexttile
[X,Y] = meshgrid(0:.1:1, 0:.1:1);
fun = f(X,Y);
contour(X,Y,fun)
if bkt == 1
    title({'Gradient descent'; 'with Backtracking'});
else
    title({'Gradient descent'; 'without Backtracking'});
end
pbaspect([1 1 1])
hold on;

Xarr(1) = x;
Yarr(1) = y;
rvec(i) = norm(gr);

F(i) = f(x,y);
while (i < N && norm(gr) >= tol)
 if bkt == 1
    alpha = backtracking(f,df,alpha,0.9,10^(-4),x,y,-gr');
 end
 x = x - alpha * gr(1);
 y = y - alpha * gr(2);
 gr = df(x,y);
 i = i + 1;
 Xarr(i) = x;
 Yarr(i) = y;
 rvec(i) = norm(gr);
 F(i) = f(x,y);
end

plot(Xarr,Yarr, '-r*');
end
