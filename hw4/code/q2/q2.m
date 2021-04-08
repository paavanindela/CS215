clc; clear;
close all;
covar = [1.6250 -1.9486;
         -1.9486 3.8750;];
Mean = [1; 2];
nsample = 100;
[Q, D] = eig(covar);
A = Q * sqrtm(D);
meanerr = [];
covarerr = [];
covarerr1 = [];
xaxis = [];
for n=[10 100 1000 10000 100000]
   i = 1:n;
   errn = zeros(nsample,1);
   errcov = zeros(nsample,1);
   errcov1 = zeros(nsample,1);
   for j = 1:nsample 
       X = randn(2, n);
       X(:,i)  = A*X(:,i)+Mean;
       S = sum(X, 2)/n;
       cov = zeros(2);
       for k=1:n
           cov = cov + (X(:,k)-S)*(X(:,k)-S)';
       end
           
       if j==1
           scatter(X(1,:), X(2,:));
           hold on;
           [Q1, D1] = eig(cov/n);
           first = S + (D1(1,1)*Q1(:,1))/norm(Q1(:,1));
           second = S + (D1(2,2)*Q1(:,2))/norm(Q1(:,2));
           plot([S(1) first(1)], [S(2) first(2)], 'color', 'black');
           plot([S(1) second(1)], [S(2) second(2)], 'color', 'black');
           title (sprintf('principal mode of variation for n = %d', n));
           hold off;
           figure;
       end
       errcov(j) = norm(cov/n-covar)/norm(covar);
       errcov1(j) = norm(cov/(n-1)-covar)/norm(covar);
       err = norm(S-Mean)/norm(Mean);
       errn(j)=err;
   end
   meanerr = [meanerr, errn;];
   covarerr = [covarerr, errcov];
   covarerr1 = [covarerr1, errcov1];
   xaxis = [xaxis, n;];
end

boxplot(meanerr, xaxis);
title ('Error in mean');
xlabel('n values');
ylabel('Error in ml estimate of mean');
figure;
boxplot(covarerr, xaxis);
title ('Error in corrected covariance');
xlabel('n values');
ylabel('Error in ml estimate of covariance');
figure;
boxplot(covarerr1, xaxis);
title ('Error in unbiased covariance');
xlabel('n values');
ylabel('Error in ml estimate of covariance');

