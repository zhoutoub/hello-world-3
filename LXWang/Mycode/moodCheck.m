function [ymood,tmood]=moodCheck(ticker,rawPrice,tickerLmdR,actStartN,actEndN,c,avgPxN,avgMoodN,bigR)
a=findTicker(rawPrice,ticker);
i=tickerLmdR(:,1)==a;
[ymood,tmood]=getAvgmood(tickerLmdR(i,2),rawPrice(tickerLmdR(i,1)).content,actStartN,actEndN,c,avgPxN,avgMoodN,bigR);
end