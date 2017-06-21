%this script gets prices from yahoo, and give the last date saved in record
%the ticker list is fixed in this file,loaded from an excel file need to rerun this script if new
%tickers added
%output is saved in histData.mat

%usage of rawPrice.--rawPrice.ticker shows ticker;rawPrice.content.AAPL is
%data array where 1=Date,2=Open,3=High,4=Low,5=Close,6=Volume,7=AdjClose
global daysOfRV 
daysOfRV=252;
tickers=importdata('tickers2.xlsx');
[numOfTickers, ~]=size(tickers.textdata);
%Subtract 1 for header
numOfTickers=numOfTickers-1;
rawPrice(numOfTickers).ticker='stop';
%rawPrice(numOfTickers).content=struct([]);

for i=1:numOfTickers
    rawPrice(i).ticker=tickers.textdata{i+1,1};
%     temptable=getYahooDailyData(rawPrice(i).ticker,'12/10/2014', '29/11/2016', 'dd/mm/yyyy');
%     fieldName=rawPrice(i).ticker{1};
%     rawPrice(i).content=table2array(temptable.(fieldName));
    rawPrice(i).content=getYahooDailyDataToArray(rawPrice(i).ticker,'12/10/1993', '13/12/2016', 'dd/mm/yyyy');
end
SPYdata=getYahooDailyDataToArray('SPY','12/10/1993', '13/12/2016', 'dd/mm/yyyy');
clear numOfTickers i;
%two things are saved, rawPrice and tickers
%save histData rawPrice tickers;
[numOfTickers, ~]=size(tickers.textdata);
%subtract header for 1 
numOfTickers=numOfTickers-1;
%convert date to num, and num to date
%busday determines prev/next business day

workPrice=rawPrice;

% daysOfRV=10;
for i=1:numOfTickers
    [logR, stdArr]=getLRnSTD(workPrice(i).content(:,7),daysOfRV,workPrice(i).ticker);
    workPrice(i).content=[workPrice(i).content,logR,stdArr];
    
%     [row,~]=size(workPrice(i).content);
%     workPrice(i).content=[workPrice(i).content [0;log(workPrice(i).content(2:end,7)./workPrice(i).content(1:end-1,7))]];
%     for j=1:row
%        if(j<=daysOfRV)
%            workPrice(i).content(j,9)=0;
%        else
%            workPrice(i).content(j,9)=std(workPrice(i).content(j-daysOfRV:j,8));
%        end
%        
%     end
    
end
[logR, stdArr]=getLRnSTD(SPYdata(:,7),daysOfRV);
SPYdata=[SPYdata,logR,stdArr];
% for j=1:row
%        if(j<=daysOfRV)
%            SPYdata(j,9)=0;
%        else
%            SPYdata=std(workPrice(i).content(j-daysOfRV:j,8));
%        end
% end
clear col row i j logR stdArr;
%3 things are saved. current Day(date string), rawPrice (str), and tickers
%(str)
save histData rawPrice workPrice tickers daysOfRV numOfTickers SPYdata;
