%{
this file is intend to look for all intraday reversals, and then more
investigation will be taken. 


There are 6 special cases of a OHLC bar, here O is not same day Open, but
previous Close
1a H>=C>O>=L;1b H>O=C=L; 1c H>O>C=L
2a H>=O>C>=L;2b H=O=C>L; 2c H=C>O>L
case of 1b/1c/2b/2c are the interesting cases here.
For case b: we need O=C, and H-L is large
for case 1c: we need H-O is large, O-L is large, and C=L
for case 2c: we need O-L is large, H-O is large, and H=C
c cases are similar, only need to know where C is on high end or low end.
%}
%1b first
%1=Date,2=Open,3=High,4=Low,5=Close,6=Volume,7=AdjClose,8=lnRetrun,9=rVol
load histdata.mat;
noStd=3;

recentDayb2=zeros(1,numOfTickers);
recentDayb1=recentDayb2;
for i=1:numOfTickers
   a=workPrice(i).content;
   extraR=noStd*a(2:end,9);
   b1b=(a(2:end,3)>(a(1:end-1,5).*exp(extraR)))&(a(2:end,3)>(a(2:end,5).*exp(extraR)))&(a(2:end,3)>(a(2:end,4).*exp(extraR)));
   %b2b cal seems not right. 
   b2b=(a(2:end,3)>(a(2:end,4).*exp(extraR)))&(a(1:end-1,5)>(a(2:end,4).*exp(extraR)))&(a(2:end,5)>(a(2:end,4).*exp(extraR)));
   b1b(1:daysOfRV)=false(daysOfRV,1);
   b2b(1:daysOfRV)=false(daysOfRV,1);
   workPrice(i).b1=[false(1);b1b];
   workPrice(i).b2=[false(1);b2b];
   recentDayb1(i)=workPrice(i).b2(end);
   recentDayb2(i)=workPrice(i).b2(end);
end

N=30;
for i=1:numOfTickers
    
    allDay=workPrice(i).content(:,1);
    lowP=workPrice(i).content(:,4);
    [row,col]=size(allDay);
    b1logic=workPrice(i).b1;
    b1index=find(b1logic==true);
    if(sum(b1logic)>0)
        
        for j=1:length(b1index)
            minIdx=max(1,b1index(j)-N);
            maxIdx=min(row,b1index(j)+N);
            DTC=workPrice(i).content(minIdx:maxIdx,:);
            fig=highlow(DTC(:,3),DTC(:,4),DTC(:,5),DTC(:,2),'red');
            title({workPrice(i).ticker});
            grid on;
            axes1.XGrid='on';
            pathname=strcat(workPrice(i).ticker,num2str(j),'.jpg');
            saveas(fig,pathname);
%             axes1.XMinorGrid = 'on';
%             axes2.XMinorGrid = 'on';
%             hold on;
%             plot(allDay(b2index(j),lowP(b2index(j))));
        end
    end
end
% 
% 
% %find the +/-N days, and chart them
% N=20;
% for i=1:numOfTickers
%     
%     allDay=workPrice(i).content(:,1);
%     lowP=workPrice(i).content(:,4);
%     [row,col]=size(allDay);
%     b2logic=workPrice(i).b2;
%     b2index=find(b2logic==true);
%     if(sum(b2logic)>0)
%         
%         for j=1:length(b2index)
%             minIdx=max(1,b2index(j)-N);
%             maxIdx=min(row,b2index(j)+N);
%             DTC=workPrice(i).content(minIdx:maxIdx,:);
%             fig=highlow(DTC(:,3),DTC(:,4),DTC(:,5),DTC(:,2),'blue');
%             title({workPrice(i).ticker});
%             grid on;
%             axes1.XGrid='on';
%             pathname=strcat(workPrice(i).ticker,num2str(j),'.jpg');
%             saveas(fig,pathname);
% %             axes1.XMinorGrid = 'on';
% %             axes2.XMinorGrid = 'on';
% %             hold on;
% %             plot(allDay(b2index(j),lowP(b2index(j))));
%         end
%     end
% end
