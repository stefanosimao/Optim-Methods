
%% Assignment 3 - Optimization Methods
% Name: Stefano Gonçalves Simao
%
% Date: 23/4/2021
%% Exercise 1
close all;
clc;

x0 = 0;
y0 = 0;
tol = 10^(-6);
N = 50000;

figure('Name', 'Exercise 1');
v = tiledlayout(2,2);
title(v,'Energy landscape')

bkt = 0;
[x1, r1, F1] = GD(x0,y0, tol, N, bkt);

bkt = 1;
[x2, r2, F2] = GD(x0,y0, tol, N, bkt);


bkt = 0;
[x3, r3, F3] = Newton(x0,y0, tol, N, bkt);

bkt = 1;
[x4, r4, F4] = Newton(x0,y0, tol, N, bkt);


figure('Name', 'Gradient norm');
z = tiledlayout(2,2);
nexttile;
plot(r1, '-r+');
xlabel('Iteration');
ylabel('Gradient norm');
title({'Gradient descent'; 'without Backtracking'});

nexttile;
plot(r2, '-r+');
xlabel('Iteration');
ylabel('Gradient norm');
title({'Gradient descent'; 'with Backtracking'});

nexttile;
plot(r3, '-r+');
xlabel('Iteration');
ylabel('Gradient norm');
title({"Newton's Method"; 'without Backtracking'});

nexttile;
plot(r4, '-r+');
xlabel('Iteration');
ylabel('Gradient norm');
title({"Newton's Method"; 'with Backtracking'});


figure('Name', 'Energy function');
j = tiledlayout(2,2);
nexttile;
plot(F1, '-go');
xlabel('Iteration');
ylabel('Function value');
title({'Gradient descent'; 'without Backtracking'});

nexttile;
plot(F2, '-go');
xlabel('Iteration');
ylabel('Function value');
title({'Gradient descent'; 'with Backtracking'});

nexttile;
plot(F3, '-go');
xlabel('Iteration');
ylabel('Function value');
title({"Newton's Method"; 'without Backtracking'});

nexttile;
plot(F4, '-go');
xlabel('Iteration');
ylabel('Function value');
title({"Newton's Method"; 'with Backtracking'});

%% Exercise 2

x0 = 0;
y0 = 0;
tol = 10^(-6);
N = 500;

figure('Name', 'Exercise 2');
title('Energy landscape')

bkt = 1;
[x6, r6, F6] = BFGS(x0,y0, tol, N, bkt);

figure('Name', 'BFGS');
z = tiledlayout(1,2);
nexttile
plot(r6, '-r+');
xlabel('Iteration');
ylabel('Gradient norm');
title({'BFGS'; 'with Backtracking'});
pbaspect([1 1 1])

nexttile;
plot(F6, '-go');
xlabel('Iteration');
ylabel('Function value');
title({"BFGS"; 'with Backtracking'});
pbaspect([1 1 1])