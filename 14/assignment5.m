%% Assignment 5
% Name: Stefano Gonçalves Simao
%
% Date: 11/6/2021
%
%% Exercise 2
clc 
clear 

x = linspace(-0.5, 3);   
x1 = (6-2*x)/3;                                     
x2 = (3+3*x)/2;
x3 = (4-2*x);
                  
X = [0 0   0.2308 1.5 2];
Y = [0 1.5 1.8462 1   0];
figure
plot(x, x1, x, x2, x, x3)
yline(0,'g');
yline(2.5);
xline(0,'b');
hold on
patch(X, Y, 'r','FaceAlpha',.3)
hold off
grid

%% Exercise 3

%Init
G = [6, 2, 1;
     2, 5, 2;
     1, 2, 4];
c = [-8;-3;-3];
A = [1, 0, 1;
     0, 1, 1];
b = [3; 0];
x = [0; 0; 0];
lambda = [0;0];
tol = 10^-5;

for k = 1:50
    x_k = G\(c - A' * lambda)
    lambda = lambda + (A * x_k - b)
    if norm(x_k - x) <= tol
        break;
    end    
    x = x_k;
end    



