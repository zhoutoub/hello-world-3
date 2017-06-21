function workPrice=appendSupport(workPrice,dayRange)
%this function adds a field to workPrice, called support, it is a 4x1 array
%1=dayRange 2=lookBackDate 3=lowDate 4=SupportPx
[~,numOfTickers]=size(workPrice);
    for i=1:numOfTickers
       sp=findSupport2(workPrice,i,dayRange);
       workPrice(i).support=sp;
    end
end