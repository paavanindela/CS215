clear;
close all;
clc;
row_val = [1 2 3 4 5];
pd_val = [0.05 0.4 0.15 0.3 0.1];
MAD = double.empty(10,0);
for n=[5 10 20 50 100 200 500 1000 5000 10000]
    nsamp = 2000;
    X = randsrc(nsamp,n,[row_val;pd_val]);
    sumX = mean(X,2);
    mu = mean(sumX);
    sigma = std(sumX);
    [f ,x]= ecdf(sumX);
    gauss = normcdf(x, mu, sigma);
    mad = max(abs(f-gauss));
    MAD = [MAD mad];
    fprintf('MAD for %d is %d',n,mad);
    figure;
    plot(x, f);
    hold on;
    plot(x, gauss, 'color', 'red');
    title (sprintf('CDF of the average of %d iid random variables',n));
    legend('ecdf', 'normcdf');
end
figure;
N = [5 10 20 50 100 200 500 1000 5000 10000];
plot(N, MAD);
title('Maximum absolute difference');
