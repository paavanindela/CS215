clear;
close all;
clc;

I1 = double(imread("T1.jpg"));
I2 = double(imread("T2.jpg"));
I3 = 255 - I1;
corr1 = double.empty(21,0);
QMI1 = double.empty(21,0);
corr2 = double.empty(21,0);
QMI2 = double.empty(21,0);
x = double.empty(21,0);
for t = -10:10
    T2 = shift(I2,t);
    cor = corrcoef(T2,I1);
    corr1 = [corr1 cor(1,2)];
    pij = joint(T2,I1);
    pi = sum(pij,2);
    pj = sum(pij,1);
    Pij = pi.*pj;    
    X = (pij-Pij).^2;
    qmf = sum(X,'all');
    QMI1 = [QMI1 qmf];
    x = [x t];
    
    T2 = shift(I3,t);
    cor = corrcoef(T2,I1);
    corr2 = [corr2 cor(1,2)];
    pij = joint(T2,I1);
    pi = sum(pij,2);
    pj = sum(pij,1);
    Pij = pi.*pj;
    X = (pij-Pij).^2;
    qmf = sum(X,'all');
    QMI2 = [QMI2 qmf];
    imshow(uint8(T2));
end
plot(x,corr1);
title('Correlation Coefficient versus Shift for I2');
figure;
plot(x,QMI1);
title('Quadratic Mutual Information versus Shift for I2');
figure;
plot(x,corr2);
title('Correlation Coefficient versus Shift for I2 = 255-I1');
figure;
plot(x,QMI2);
title('Quadratic Mutual Information versus Shift for I2 = 255 - I1');

function pij = joint(s1,s2)
    pij = zeros(26,26);
    b = 10;
    [rows,columns] = size(s1);
    for i = 1:rows
        for j = 1:columns
            pij(floor(s1(i,j)/b)+1,floor(s2(i,j)/b)+1) = pij(floor(s1(i,j)/b)+1,floor(s2(i,j)/b)+1)+1;
        end
    end
    pij = pij /sum(pij,'all');
end

function S = shift( s , t)
    S = s;
    if t > 0
        S(:,t+1:size(s,2)) = s(:,1:size(s,2)-t);
        S(:,1:t) = 0;
    end
    if t < 0
        S(:,1:size(s,2)+t) = s(:,-t+1:size(s,2));
        S(:,size(s,2)+t:size(s,2)) = 0;
    end
end