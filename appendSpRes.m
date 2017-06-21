function workPrice=appendSpRes(workPrice,dayRangeL,dayRangeH)
%this function adds a field to workPrice, called support, it is a 4x1 array
%1=dayRange 2=lookBackDate 3=lowDate 4=SupportPx
[~,numOfTickers]=size(workPrice);
    for i=1:numOfTickers
       [sp,re]=findSpRes(workPrice,i,dayRangeL,dayRangeH);
       workPrice(i).support=sp;
       workPrice(i).resist=re;
    end
end