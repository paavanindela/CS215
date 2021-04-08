clear;
clc;
function newMean = UpdateMean (OldMean, NewDataValue, n)
    newMean= (OldMean*n+NewDataValue)/(n+1);
end
function newMedian = UpdateMedian (OldMedian, NewDataValue, A, n)
    if(mod(n,2)==0)
        if(NewDataValue>OldMedian)
            newMedian = A(n/2+1);
        else
            newMedian = A(n/2);
        end
    else
        if(NewDataValue>OldMedian)
            newMedian = (A((n+3)/2)+OldMedian)/2;
        else
            newMedian = (A((n-1)/2)+OldMedian)/2;
        end
    end           
end
function newStd = UpdateStd (OldMean, OldStd, NewMean, NewDataValue, n)
    newStd = sqrt(((n-1)*OldStd^2+n*(NewMean-OldMean)^2+(NewDataValue-NewMean)^2)/n);
end