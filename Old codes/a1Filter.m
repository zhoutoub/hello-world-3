function workPriceA1=a1Filter(workPrice)
global noStd daysOfRV dateFormat
[~,numOfTickers]=size(workPrice);
recentDayA1=zeros(1,numOfTickers);
    for i=1:numOfTickers
       a=workPrice(i).content;
       extraR=noStd*a(2:end,9);
       a1b=(a(2:end,3)>(a(1:end-1,7).*exp(extraR)))&(a(2:end,3)<a(2:end,7).*exp(extraR/noStd));
       a1b(1:daysOfRV)=false(daysOfRV,1);
       workPrice(i).A1=[false(1);a1b];
       recentDayA1(i)=workPrice(i).A1(end);
       if recentDayA1(i)
           disp(workPrice(i).ticker,'showed type A1 today');
       end
    end

N=30;
    for i=1:numOfTickers    
        allDay=workPrice(i).content(:,1);
        lowP=workPrice(i).content(:,4);
        [row,~]=size(allDay);
        Slogic=workPrice(i).A1;
        a1index=find(Slogic==true);
        if(sum(Slogic)>0)
            for j=1:length(a1index)
                minIdx=max(1,a1index(j)-N);
                maxIdx=min(row,a1index(j)+N);
                DTC=workPrice(i).content(minIdx:maxIdx,:);
                fig=highlow(DTC(:,3),DTC(:,4),DTC(:,7),DTC(:,2),'red');
                dateX=datestr(workPrice(i).content(a1index(j),1),dateFormat);
                myTitle=strcat(workPrice(i).ticker,' ',dateX);
                title({myTitle});
                grid on;
                axes1.XGrid='on';
                pathname=strcat(workPrice(i).ticker,num2str(j),'.jpg');
                saveas(fig,pathname);
            end
        end
    end
workPriceA1=workPrice;
end