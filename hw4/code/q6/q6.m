clc;
close all;
clear;
imagefiles = dir('*.png');
nfiles = length(imagefiles);
I = []; F = strings(16);
for ii=1:nfiles
   crf = imagefiles(ii).name;
   cri = imread(crf);
   images{ii} = cri;
   I(end+1,:) = reshape(cri,[19200 1]);
   F(ii) = erase(crf,'_');
end
 m = MEAN(I,ii);
 figure('Renderer', 'painters', 'Position', [100 10 350 725])
 subplot(4,2,1:4),image(rescale(reshape(m,[80,80,3]))),title('Mean vector ');
 hold on;
 MM = I - m;
 covM = MM'*MM/(size(I,1)-1);
 [V D] = eigs(covM,4);
 subplot(4,2,5),image(rescale(reshape(V(:,1),[80,80,3]))),title('Eigen vector 1');
 subplot(4,2,6),image(rescale(reshape(V(:,2),[80,80,3]))),title('Eigen vector 2');
 subplot(4,2,7),image(rescale(reshape(V(:,3),[80,80,3]))),title('Eigen vector 3');
 subplot(4,2,8),image(rescale(reshape(V(:,4),[80,80,3]))),title('Eigen vector 4');
 A = eigs(covM,10);
 figure;
 plot(sort(A,'descend'));
 for ii=1:16
     v = []; u = [];
     for ij=1:4
        v(end+1,:) = dot(I(ii,:),V(:,ij));
        u(end+1,:) = dot(m,V(:,ij));
     end
     k = (dot(m,I(ii,:))-dot(u,v'))/(norm(m)*norm(m)-norm(u)*norm(u));
     v = v - k*u;
     img = k*m +(V*v)';
     %this can also be done taking the coefficient of mean to be one , but
     %since the question says use frobenius norm i have done this method
     %explained clearly in the full report pdf under q6
     %if it was for mean coefficient 1 then the method would be
     %components = V' * (I(i,:) - m)';
     %img = (V * components)' + m;
     figure('Renderer', 'painters', 'Position', [100 10 1000 430]);
     subplot(1,2,1), image(rescale(reshape(I(ii,:),[80,80,3]))),title('Orginal '+F(ii));
     subplot(1,2,2), image(rescale(reshape(img,[80,80,3]))),title('Closest for '+F(ii));
end
EM = V * sqrtm(D) * V';
figure('Renderer', 'painters', 'Position', [200 10 1000 300]);
for ii=1:3
    W = randn(19200,1);
    X = m' + EM*W;
    subplot(1,3,ii),image(rescale(reshape(X,[80,80,3]))),title('New fig');
end
function m = MEAN( T , N)
    m = sum(T,1)/N;
end