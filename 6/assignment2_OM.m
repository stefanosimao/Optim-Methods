%% Assignment 2 - Optimization Methods
% Name: Stefano Gonçalves Simao
%
% Date: 14/4/2021
%% Exercise 1
close all;
clc;

disp('Exercise 1');
disp(' ');

disp('1.');
disp(' ');
disp('With N = 4 we have:');
disp(' ');

N = 4;
h = 1/(N - 1);

A = zeros(N,N);
A(1,1) = 1;
A(N,N) = 1;
for i = 2:(N - 1)
    A(i,i) = 2;
    A(i,i + 1) = -1;
    A(i,i - 1) = -1;
end
A

b = zeros(N,1);
for i = 2:(N - 1)
    b(i,1) = 1 * h^2;
end
b

disp('2.');
disp(' ');

A1 = zeros(N,N);
A1(1,1) = 1;
A1(N,N) = 1;
for i = 2:(N - 1)
    A1(i,i) = 2;
    A1(i,i + 1) = -1;
    A1(i,i - 1) = -1;
end
A1(2,1) = 0;
A1(N - 1,N) = 0;
A1

%--------------------------------------------------------------------------

N1 = 1000;
h1 = 1/(N1 - 1);

A2 = zeros(N1,N1);
A2(1,1) = 1;
A2(N1,N1) = 1;
for i = 2:(N1 - 1)
    A2(i,i) = 2;
    A2(i,i + 1) = -1;
    A2(i,i - 1) = -1;
end
A2(2,1) = 0;
A2(N1 - 1,N1) = 0;

b1 = zeros(N1,1);
for i = 2:(N1 - 1)
    b1(i,1) = 1 * h1^2;
end

[x, rvec, F] = CG(A2, b1, zeros(N1, 1), 10^(-8), 1000);

f1 = figure;
f2 = figure;

figure(f1);
semilogy(rvec, '-r+');
xlabel('Iteration');
ylabel('Gradient norm');
s = sprintf('Norm of the gradient');
title(s)

figure(f2);
plot(F, '-g+');
xlabel('Iteration');
ylabel('Function value');
s = sprintf('Energy Function');
title(s)

%% Exercise 2

disp('Exercise 2');
disp(' ');

disp('1.');
disp(' ');

A1 = diag((1:10))

A2 = diag(ones(1,10))

A3 = diag([1,1,1,3,4,5,5,5,10,10])

A4 = diag((1.1:0.1:2))

E1 = eig(A1);
u1 = unique(E1);

E2 = eig(A2);
u2 = unique(E2);

E3 = eig(A3);
u3 = unique(E3);

E4 = eig(A4);
u4 = unique(E4);

disp('The eigenvalues of diagonal matrix are the elements on the diagonal')
disp('We have:')
C1 = numel(u1)
C2 = numel(u2)
C3 = numel(u3)
C4 = numel(u4)

disp('2.');
disp(' ');

b2 = rand (10,1);

[x1, lenerr1] = CG2(A1, b2, zeros(10, 1), 10^(-8), 10);
[x2, lenerr2] = CG2(A2, b2, zeros(10, 1), 10^(-8), 10);
[x3, lenerr3] = CG2(A3, b2, zeros(10, 1), 10^(-1), 10);
[x4, lenerr4] = CG2(A4, b2, zeros(10, 1), 10^(-8), 10);
x1
x2
x3
x4

f3 = figure;

figure(f3);
u = tiledlayout(2,2);
nexttile;
plot(lenerr1, '-b+');
xlabel('Iteration');
ylabel("$log((x - x^*)^T A (x - x^*))$",'Interpreter','latex');
s = sprintf('Norm of the error for A = diag(1:10)');
title(s)

nexttile;
plot(lenerr2, '-b+');
xlabel('Iteration');
ylabel("$log((x - x^*)^T A (x - x^*))$",'Interpreter','latex');
s = sprintf('Norm of the error for A = diag(ones(1,10))');
title(s)

nexttile;
plot(lenerr3, '-b+');
xlabel('Iteration');
ylabel("$log((x - x^*)^T A (x - x^*))$",'Interpreter','latex');
s = sprintf('Norm of the error for A = diag([1,1,1,3,4,5,5,5,10,10])');
title(s)

nexttile;
plot(lenerr4, '-b+');
xlabel('Iteration');
ylabel("$log((x - x^*)^T A (x - x^*))$",'Interpreter','latex');
s = sprintf('Norm of the error for A = diag((1.1:0.1:2))');
title(s)

disp('4.');
disp(' ');
disp('We can observe that the number of iterations is equal to the number');
disp('of unique eigenvalues of the matrix A. The first and last matrices');
disp('have 10 distinct eigenvalues and take 10 iteration. The second has');
disp('1 cluster and takes 1 iteration, the third one has 5 clasters and');
disp('needs 5 iterations to come to a good solution. We can coclude that')
disp('with n distinct eigenvalues, then CG converges in at most n steps.');