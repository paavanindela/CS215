clear;
clc;
x = [-3:0.02:3];
prompt = "enter the fraction ";
f = input(prompt);
y = 2.5*sin(1.8*x)+ sqrt(3)*2.5*cos(1.8*x);
plot(x,y,'DisplayName','original wave','color',[0 0 0]);
l = randperm(length(x),ceil(f*length(x)));
z = y;
z(l) = 20*rand(ceil(f*length(x)),1) + 100;
hold on;
plot(x,z,'DisplayName','corrupted wave','color',[0.9290 0.6940 0.1250]);
ymedian = z;
for i = 1:301
    if i < 9
        ymedian(i)=median(z(1:(i+8)));
    end
    if i > 293
        ymedian(i) = median(z(i-8:301));
    end
    if i>=9 && i<=293
        ymedian(i) = median(z(i-8:i+8));
    end
end
hold on;
plot(x,ymedian,'DisplayName','Filtered wave(median)','color',[1 0 0]);

ymean = z;
for i = 1:301
    if i < 9
        ymean(i)=mean(z(1:(i+8)));
    end
    if i > 293
        ymean(i) = mean(z(i-8:301));
    end
    if i>=9 && i<=293
        ymean(i) = mean(z(i-8:i+8));
    end
end
hold on;
plot(x,ymean,'DisplayName','Filtered wave(mean)','color',[0.4940 0.1840 0.5560]);

yquart = z;
for i = 1:301
    if i < 9
        temp = z(1:(i+8));
        yquart(i) = median(temp(temp<median(temp)));
    end
    if i > 293
        temp = z(i-8:301);
        yquart(i) = median(temp(temp<median(temp)));
    end
    if i>=9 && i<=293
        temp = z(i-8:i+8);
        yquart(i) = median(temp(temp<median(temp)));
    end
end
hold on;
plot(x,yquart,'DisplayName','Filtered wave(quartile)','color',[0 0.0780 0.1840]);
legend;
errormedian = errir(ymedian,y);
errormean = errir(ymean,y);
errorquart = errir(yquart,y);
disp(errormedian);
disp(errormean);
disp(errorquart);
function error = errir(A,B)
    error = sum((B-A).^2)/sum(B.^2);
end