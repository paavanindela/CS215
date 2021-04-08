clear; clc;
close all;
lam = 5; a = 5.5; b = 1;
M=100;
plt1 = zeros(100,10);
plt2 = zeros(100,10);
i = 1;
for n = [5 10 20 40 60 80 100 500 1000 10000]
    X = rand(M, n);
    Y = -1*log(X)/lam;
    ml_lam = n*(sum(Y, 2).^(-1));
    ml_error = abs(ml_lam - lam)/lam;
    map_lam = (n+a-1)*((sum(Y, 2)+b).^(-1));
    map_error = abs(map_lam - lam)/lam;
    plt1(:,i) = ml_error;
    plt2(:,i) = map_error;
    i = i + 1;
end
figure;
subplot(2,1,1),boxplot(plt1),xticklabels({5,10,20,40,60,80,100,500,1000,10000}),title('MLE error')
subplot(2,1,2),boxplot(plt2),xticklabels({5,10,20,40,60,80,100,500,1000,10000}),title('Posterior Mean error')