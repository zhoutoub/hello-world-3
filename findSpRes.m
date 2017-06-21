
function [SupportArr, Resist]=findSpRes(workPrice,indexI,dayRangeL,dayRangeH)
%This function populates the lowest prices and highest prices for a given range for given
%stock.
%The output is two 1x4 array, 1=dayRange 2=lookBackDate 3=lowDate 4=SupportPx

%make sure day range is not bigger than available data size
workPriceCont=workPrice(indexI).content;
[days,~]=size(workPriceCont);
dayRangeL=min(days,dayRangeL);
dayRangeH=min(days,dayRangeH);
%only work on the portion of interest, but exclude the latest day

%wPC=workPriceCont(end-dayRange+1:end,:);
wPCL=workPriceCont(end-dayRangeL+1:end-1,:);
wPCH=workPriceCont(end-dayRangeH+1:end-1,:);
lowIndex=find((wPCL(:,4)-min(wPCL(:,4)))<0.001,1,'first');
highIndex=find((max(wPCH(:,3))-wPCH(:,3))<0.001,1,'first');
dateArrL=wPCL(:,1);
dateArrH=wPCH(:,1);
lowDate=dateArrL(lowIndex);
highDate=dateArrH(highIndex);
lookBackDate=workPriceCont(end-1,1);
SupportPx=wPCL(lowIndex,4);
ResistPx=wPCH(highIndex,3);
%Return the summary array , to be append to the workPrice struct

SupportArr=[dayRangeL lookBackDate lowDate SupportPx];
Resist=[dayRangeH lookBackDate highDate ResistPx];
%WPCwSP=[wPC wPC(lowIndex,4)*ones(dayRange-1,1);workPriceCont(end,:) wPC(lowIndex,4)];
end