clear; clc;
close all;
m = matfile('mnist.mat');
mean = zeros(28*28, 10);
new = cast(m.digits_train, 'double');
new = new/255;
for i=0:9
    X = new(:,:, m.labels_train == i);
    [x, y, z] = size(X);
    X = reshape(X, x*y, 1, z);
    Mean = sum(X, 3)/z;
    cov = zeros(x*y);
    for k=1:z
        cov = cov + (X(:,1,k)-Mean)*(X(:,1,k)-Mean)';
    end
    cov = cov/z;
    [V, D] = eigs(cov, 1);
    figure;
    e = eig(cov);
    e = sort(e, 'descend');
    plot(e);
    title(sprintf('eigen values for digit %d', i) )
    %D is largest eigen value and V is corresponding eigenvector
    figure;
    subplot(1,3,1);
    imagesc(reshape(Mean-sqrt(D)*V, x, y));
    title(sprintf('digit %d, Mean-', i));
    axis equal;
    subplot(1,3,2);
    imagesc(reshape(Mean, x, y));
    title(sprintf('digit %d, Mean', i));
    axis equal;
    subplot(1,3,3);
    imagesc(reshape(Mean+sqrt(D)*V, x, y));
    title(sprintf('digit %d, Mean+', i));
    axis equal;
end