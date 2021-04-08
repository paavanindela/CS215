clear;
close all;
clc;

N = 2000;
Data = dlmread("XYZ.txt",",");
P = sum(Data(:,1).*Data(:,3)); 
Q = sum(Data(:,2).*Data(:,3)); 
R = sum(Data(:,3));
A = sum(Data(:,1).^2);
B = sum(Data(:,1).*Data(:,2)); 
C = sum(Data(:,1));
E = sum(Data(:,2).^2); 
D = sum(Data(:,2));
syms x y z
eqn1 = A*x + B*y + C*z == P;
eqn2 = B*x + E*y + D*z == Q;
eqn3 = C*x+ D*y + N*z == R;
[A,B] = equationsToMatrix([eqn1, eqn2, eqn3], [x, y, z]);

X = linsolve(A,B);
a = double(X(1))
b = double(X(2))
c = double(X(3))

M = Data(:,3) - a*Data(:,1) - b*Data(:,2) -c;
std_dev = std(M)
