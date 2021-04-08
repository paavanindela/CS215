clear; clc;
close all;
m = matfile('mnist.mat');
mean = zeros(28*28, 10);
new = cast(m.digits_train, 'double');
new = new/255;
for i=0:1
    X = new(:,:, m.labels_train == i);
    [x, y, z] = size(X);
    X = reshape(X, x*y, 1, z);
    Mean = sum(X, 3)/z;
    V = red_dim(X,Mean,z);
    X1 = (X(:,:,1)-Mean)'*V*V' + Mean';
    figure;
    subplot(1,2,1);
    imagesc(reshape(X(:,:,1), x, y));
    title('Original Image');
    subplot(1,2,2);
    imagesc(reshape(X1, x, y));
    title('PCA Image');
end
%Takes corresponding image sets, Mean and size as input
function V = red_dim(X, Mean, z)
    cov = zeros(28*28);
    v = squeeze(X(:,1,:))-Mean;
    for k=1:z
        cov = cov + (X(:,1,k)-Mean)*(X(:,1,k)-Mean)';
    end
    cov = cov/z;
    [V, D] = eigs(cov, 84);  %84 eigen vectors    
end