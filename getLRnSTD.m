%This function finds log return and daily return std, if close price array
%is given. Results are Nx1 arrays.
function [logR, stdArr]=getLRnSTD(pxArr,daysOfRV,ticker)
[m,~]=size(pxArr);
logR=[0;log(pxArr(2:end)./pxArr(1:end-1))];
stdArr=zeros(m,1);
if m<=daysOfRV
    x=['px array smaller than daysOfRV,current ticker ',ticker];
    disp(x);
end
    for j=1:m
       if(j>=daysOfRV)
           stdArr(j)=std(logR(j-daysOfRV+1:j));
       end
    end
end