%SPYdata=getYahooDailyData('SPY','22/01/1993', '31/12/2015', 'dd/mm/yyyy');
%1=Date,2=Open,3=High,4=Low,5=Close,6=Volume,7=AdjClose,8=lnRetrun,9=return
%std
load 'histData.mat';
[numOfTickers, ~]=size(tickers.textdata);
%subtract header for 1 
numOfTickers=numOfTickers-1;
%convert date to num, and num to date
%busday determines prev/next business day
currentDay=datestr(busdate(datenum(datetime('today'))+1,-1),'dd/mm/yyyy');
workPrice=rawPrice;
% daysOfRV=10;
for i=1:numOfTickers
    [row,col]=size(workPrice(i).content);
    workPrice(i).content=[workPrice(i).content [0;log(workPrice(i).content(2:end,7)./workPrice(i).content(1:end-1,7))]];
    for j=1:row
       if(j<=daysOfRV)
           workPrice(i).content(j,9)=0;
       else
           workPrice(i).content(j,9)=std(workPrice(i).content(j-daysOfRV:j,8));
       end
       
    end
    
end
clear col row i j ;
%3 things are saved. current Day(date string), rawPrice (str), and tickers
%(str)
save histData currentDay rawPrice workPrice tickers daysOfRV numOfTickers ;
