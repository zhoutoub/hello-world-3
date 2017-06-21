function tickerLmdR=findMaxRwLmd2(rawPrice,startN,endN,c,avgPxN,avgMoodN,bigR)
%need to have rawPrice available, can load histData.mat
%This function optimizes lmd and its R, and sort the result by R, then save
%the result. The top x tickers will be focus later.

%m will be 1, n should be the number of tickers

[m,n]=size(rawPrice);
vbForSize=optimizeRwLmd2(rawPrice(1).content,startN,endN,c,avgPxN,avgMoodN,bigR);
%get output size to initiate proper array for result
[k1,k2]=size(vbForSize);
LmdR=zeros(n,k2+1);
for i=1:n
    %1st col is the ticker index
    
    LmdR(i,1)=i;
    %2nd col is the optimized lmd, 3rd col is the related R
    [LmdR(i,2:end)]=optimizeRwLmd2(rawPrice(i).content,startN,endN,c,avgPxN,avgMoodN,bigR);
end
%sortrows can only do ascending order, so flipping the return sign
LmdR(:,3)=-LmdR(:,3);
sortLmdR=sortrows(LmdR,3);
%flipping back the return of the sorted array
sortLmdR(:,3)=-sortLmdR(:,3);
%add 8th column as rank of return
tickerLmdR=[sortLmdR,(1:n)'];