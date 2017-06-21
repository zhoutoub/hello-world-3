tickers={'OI','XYL','LEG','LVLT','RAI','AEP','FL','WHR','UTX','V','HRL','TXT','PDCO','GIS'};
m=length(tickers);
res=zeros(m,2);

for j=1:m
    [res(j,1),res(j,2)]=moodCheck(tickers(j),rawPrice,tickerLmdR,actStartN,actEndN,c,avgPxN,avgMoodN,bigR);
end
Ymood=res(:,1);
Tmood=res(:,2);
T=table(Ymood,Tmood,'RowNames',tickers)