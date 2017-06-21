%Ticker check
%{stocks get delisted all the time, this m file intends to check if any of them are delisted}%



tickers=importdata('tickers2.xlsx');
[numOfTickers, ~]=size(tickers.textdata);
numOfTickers=numOfTickers-1;
rawPrice(numOfTickers).ticker='stop';
rawPrice(numOfTickers).content=struct([]);

for i=1:numOfTickers
    rawPrice(i).ticker=tickers.textdata(i+1,1);
    rawPrice(i).content=getYahooDailyData(rawPrice(i).ticker,'28/11/2016', '30/11/2016', 'dd/mm/yyyy');
end
