clear;
clc;
close all;
rng(1);
Y = double.empty(8,0);
N = [10 10^2 10^3 10^4 10^5 10^6 10^7 10^8];
for N = [10 10^2 10^3 10^4 10^5 10^6 10^7 10^8]
   X = 1-rand(N,2,'single')*2; % generating random numbers between -1 and 1 of single data type
   X = X(:,1).^2+X(:,2).^2; % sum of squares of the random variable X = (X_1,X_2) i.e X_1^2+X_2^2 and stored in the same variable
   x = sum(X<1); % count of number of variables within a circle of radius 1
   y = 4*x/(N); % estimated value of pi
   Y = [Y y];
end
Y 

