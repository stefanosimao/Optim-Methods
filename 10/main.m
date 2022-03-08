%% MIDTERM - Exercise 2
% Name: Stefano Gonçalves Simao
%
% Date: 14/5/2021
%
%% (2.4)
clc 
clear 

%Initialization
syms x y
f = (y - 4 * x^2)^2 + (1 - x)^2;
f_handle = matlabFunction(f);
x_0 = [0;0];
tol = 10^-8;
delta_max = 2;
delta_0 = 1;
eta = 0.2;
max_itr = 1000;

%Trust region
[xvec, zvec, rvec] = TR(f, x_0, tol, delta_max, delta_0, eta, max_itr);

%Plot
figure 
surf(xvec(1,:), xvec(2,:), zvec)
hold on
plot3(xvec(1,:), xvec(2,:), f_handle(xvec(1,:),xvec(2,:)),'-*','Color','m','MarkerSize',20, 'LineWidth', 2)
hold off
%% (2.5)

%Initialization
f_ros = (1 - x)^2 + 100 * (y - x^2)^2;
f_ros_handle = matlabFunction(f_ros);

%Trust region
[xvec_r, zvec_r, rvec] = TR(f_ros, x_0, tol, delta_max, delta_0, eta, max_itr);

%Plot
figure 
surf(xvec_r(1,:), xvec_r(2,:), zvec_r)
hold on
plot3(xvec_r(1,:), xvec_r(2,:), f_ros_handle(xvec_r(1,:),xvec_r(2,:)),'-*','Color','m','MarkerSize',20, 'LineWidth', 2)
hold off

figure
semilogy(rvec, '-r+');
xlabel('Iteration');
ylabel('Gradient norm');
s = sprintf('Norm of the gradient');
title(s)