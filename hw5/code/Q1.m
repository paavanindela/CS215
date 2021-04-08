clear; clc;
close all;
sig = 4; mean=10;
mean1 = 10.5; sig1 = 1; up=11.5; down=9.5;
nsample=100;
plt1 = zeros(100,10);
plt2 = zeros(100,10);
plt3 = zeros(100,10);
i = 1;
for n = [5 10 20 40 60 80 100 500 1000 10000]
    X = sig*randn(nsample, n) + mean;
    ml_mean = sum(X, 2)/n;
    ml_error = abs(ml_mean-mean)/mean;
    map1_mean = (ml_mean*(sig1^2) + mean1*(sig^2)/n)/((sig1^2) + (sig^2)/n);
    map1_error = abs(map1_mean-mean)/mean;
    map2_mean = ml_mean;
    map2_mean(ml_mean>up) = up;
    map2_mean(ml_mean<down) = down;
    map2_error = abs(map2_mean-mean)/mean;
    plt1(:,i) = ml_error;
    plt2(:,i) = map1_error;
    plt3(:,i) = map2_error;
    i = i + 1;
    %saveas(gcf,sprintf('%d.png',n));
end
subplot(3,1,1),boxplot(plt1),xticklabels({5,10,20,40,60,80,100,500,1000,10000}),title('MLE error')
subplot(3,1,2),boxplot(plt2),xticklabels({5,10,20,40,60,80,100,500,1000,10000}),title('MAP 1 error')
subplot(3,1,3),boxplot(plt3),xticklabels({5,10,20,40,60,80,100,500,1000,10000}),title('MAP 2 error')