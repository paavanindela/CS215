clear;
clc;
close all;

m1 = load('points2D_Set2.mat');
T1 = m1.x;
T2 = m1.y;
figure;
title('SET 1 plot');
hold on;
scatter(T1,T2,'blue');
M1 = MEAN(T1,numel(T1));
M2 = MEAN(T2,numel(T2));
V1 = VAR(T1,numel(T1),M1);
V2 = VAR(T2,numel(T2),M2);
cv = COVAR(T1,T2,numel(T1),M1,M2);
theta = 0:0.001:pi;
T = V1*cos(theta).*cos(theta)+V2*sin(theta).*sin(theta)+2*cv*cos(theta).*sin(theta);
[max_val, max_ind] = max(T);
t = theta(max_ind); L = 10;
y = M2 + (T1-M1)*tan(t);
plot(T1,y,'red');
function m = MEAN( T , N)
    m = sum(T)/N;
end
function v = VAR(T, N, m)
    v = sum((T-m).^2/(N-1));
end
function c = COVAR(X,Y,N,m1,m2)
    c = sum(((X-m1).*(Y-m2))/(N-1));
end
