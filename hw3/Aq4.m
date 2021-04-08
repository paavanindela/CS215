clc;
clear;
close all;

X = normrnd(0,4,[1000 1]);
indices = randperm(1000);
T = X(indices(1:750),:);
V = X(indices(751:end),:);
Y = [-8:0.1:8];
s_val = double.empty(11,0);
l_val = double.empty(11,0);
S = 0.001;
ll = -Inf;
for s = [0.001 0.1 0.2 0.9 1 2 3 5 10 20 100]
    l = sum(exp(-((T -V.').^2)/(2 * s * s)),1);
    L = log(l) - log(750*s*sqrt(2*pi));
    LL = sum(L);
    if (ll ~= max(LL,ll))
        ll = max(LL,ll);
        S = s;
    end
    l_val = [l_val LL];
    s_val = [s_val log(s)];
end
plot(s_val,l_val);
S
title('log LL versus log \sigma');
PV = double.empty(161,0);
pV = double.empty(161,0);
for x = [-8:0.1:8]
    pv = exp(-x*x/32)/(4*sqrt(2*pi));
    PV = [PV pv];
    p0 = sum(exp(-((T-x).^2)/(2*S*S)),'all');
    p0 = p0 / (750 *S * sqrt(2*pi));
    pV = [pV p0];
end
figure;
title('True Density and Kernel Density');
hold on;
plot(Y,PV);
plot(Y,pV);
legend('True','Kernel');
sig = double.empty(2001,0);
D = double.empty(2001,0);
for s = [log(S)-1:0.001:log(S)+1]
    S = exp(s);
    trup = exp(-V.*V/32)/(4*sqrt(2*pi));
    ep = sum(exp(-((T -V.').^2)/(2 * S * S)),1).';
    ep = ep / (750 * S * sqrt(2*pi));
    DD = (trup - ep).^2;
    d = sum(DD);
    D = [D d];
    sig = [sig s];
end
figure;
hold on;
title('D versus log \sigma');
plot(sig ,D);
d = min(D);
S = exp(sig(find(D == d)));
S
PV = double.empty(161,0);
Pv = double.empty(161,0);
for x = [-8:0.1:8]
    pv = exp(-x*x/32)/(4*sqrt(2*pi));
    PV = [PV pv];
    p0 = sum(exp(-((T-x).^2)/(2*S*S)),'all');
    p0 = p0 / (750 *S * sqrt(2*pi));
    Pv = [Pv p0];
end
figure;
title('True Density and Kernel Density(part D)');
hold on;
plot(Y,PV);
plot(Y,pV);
plot(Y,Pv);
legend('true','approx','final');
%figure;
%D = double.empty(11,0);
%sig = double.empty(11,0);
%for S = [0.001 0.1 0.2 0.9 1 2 3 5 10 20 100]
%    trup = exp(-V.*V/32)/(4*sqrt(2*pi));
%    ep = sum(exp(-((T -V.').^2)/(2 * S * S)),1).';
%    ep = ep / (750 * S * sqrt(2*pi));
%    DD = (trup - ep).^2;
%    d = sum(DD);
%    D = [D d];
%    sig = [sig log(S)];
%end
%plot(sig,D);