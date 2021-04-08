clear;
close all;
clc;
row_val = [1 2 3 4 5];
pd_val = [0.05 0.4 0.15 0.3 0.1];
for n=[5 ,10, 20, 50, 100, 200, 500, 1000, 5000, 10000]
    nsamp = 2000;
    X = randsrc(nsamp,n,[row_val;pd_val]);
    sumX = mean(X,2); 
    numbins = 50;
    hist(sumX,numbins);
    title (sprintf('PDF of the average of %d iid random variables',n));
    h = get (gca, 'children');
    fname = sprintf('%da.png',n);
    saveas(h,fname);
    pause(1.2);
end
