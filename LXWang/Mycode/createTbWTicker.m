function myTb=createTbWTicker(tickerLmdR,rawPrice)
%this funtion extends tickerLmdR array, by adding the ticker name, in case
%some ticker gets delisted , then we can simply remove it from here.
[m,n]=size(tickerLmdR);
ticker=cell(m,1);
for i=1:m
    ticker{i}=rawPrice(tickerLmdR(i,1)).ticker;
end
tickerInd=tickerLmdR(:,1);
Lamda=tickerLmdR(:,2);
MoodR=tickerLmdR(:,3);
BnHR=tickerLmdR(:,4);
Nbuy=tickerLmdR(:,5);
RoSM=tickerLmdR(:,6);
RoSBH=tickerLmdR(:,7);

minMR=tickerLmdR(:,8);
minBR=tickerLmdR(:,9);
c=tickerLmdR(:,10);
moodRnk=tickerLmdR(:,11);
%myTb=table(tickerInd,Lamda,MoodR,BnHR,Nbuy,RoSM,RoSBH,'RowNames',ticker);
myTb=table(ticker,tickerInd,Lamda,MoodR,BnHR,Nbuy,RoSM,RoSBH,minMR,minBR,c,moodRnk,'RowNames',ticker);

end