
function [SupportArr]=findSupport2(workPrice,indexI,dayRange)
%This function populates the lowest prices for a given range for given
%stock.
%The output is a 1x4 array, 1=dayRange 2=lookBackDate 3=lowDate 4=SupportPx

%make sure day range is not bigger than available data size
workPriceCont=workPrice(indexI).content;
[days,~]=size(workPriceCont);
dayRange=min(days,dayRange);
%only work on the portion of interest, but exclude the latest day

%wPC=workPriceCont(end-dayRange+1:end,:);
wPC=workPriceCont(end-dayRange+1:end-1,:);
lowIndex=find(abs(wPC(:,4)-min(wPC(:,4)))<0.001,1,'first');
dateArr=wPC(:,1);
lowDate=dateArr(lowIndex);
lookBackDate=workPriceCont(end-1,1);
SupportPx=wPC(lowIndex,4);
%Return the summary array , to be append to the workPrice struct

SupportArr=[dayRange lookBackDate lowDate SupportPx];
%WPCwSP=[wPC wPC(lowIndex,4)*ones(dayRange-1,1);workPriceCont(end,:) wPC(lowIndex,4)];
end