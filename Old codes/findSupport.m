function [lowDate,WPCwSP]=findSupport(workPriceCont,dayRange)
%This function populates the lowest prices for a given range for given
%stock.
%make sure day range is not bigger than available data size
[days,~]=size(workPriceCont);
dayRange=min(days,dayRange);
%only work on the portion of interest, but exclude the latest day

%wPC=workPriceCont(end-dayRange+1:end,:);
wPC=workPriceCont(end-dayRange+1:end-1,:);
lowIndex=find(abs(wPC(:,4)-min(wPC(:,4)))<0.001,1,'first');
dateArr=wPC(:,1);
lowDate=dateArr(lowIndex);
%including the last date back
WPCwSP=[wPC wPC(lowIndex,4)*ones(dayRange-1,1);workPriceCont(end,:) wPC(lowIndex,4)];
end