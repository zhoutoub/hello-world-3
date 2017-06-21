%This script intends to update the raw data to date
load 'histData.mat';
[~,numOfTickers]=size(rawPrice);
%numOfTickers=numOfTickers-1; this is no longer needed
%firstTicker=rawPrice(1).ticker;
lastContentDay=rawPrice(1).content(end,1);
continueDay=datestr(busdate(lastContentDay,1),'dd/mmm/yyyy');
%convert date to num, and num to date
%busday determines prev/next business day
currentDay=datestr(busdate(datenum(datetime('today'))+1,-1),'dd/mmm/yyyy');
if datenum(currentDay)~=datenum(lastContentDay)
    global daysOfRV

    if datetime(continueDay)<=datetime(currentDay)
        for i=1:numOfTickers
           [oldN,~]=size(rawPrice(i).content);
           newContent=getYahooDailyDataToArray(rawPrice(i).ticker,continueDay, currentDay, 'dd/mmm/yyyy');
           [extraN,~]=size(newContent);
           tempStd=zeros(extraN,1);
           rawPrice(i).content=[rawPrice(i).content;newContent];
           ret=[workPrice(i).content(:,8);log(rawPrice(i).content(oldN+1:end,7)./rawPrice(i).content(oldN:end-1,7))];
           for j=1:extraN
               if(oldN+j-daysOfRV+1>0)
                tempStd(j)=std(ret(oldN+j-daysOfRV+1:oldN+j));
               else
                tempStd(j)=0;
               end
           end
           workPrice(i).content=[workPrice(i).content; rawPrice(i).content(oldN+1:end,:) ret(oldN+1:end) tempStd];
        end

    end
    %update SPY
    newContent=getYahooDailyDataToArray('SPY',continueDay,currentDay, 'dd/mmm/yyyy');
    %SPYdata=getYahooDailyDataToArray('SPY','12/10/1994', '13/12/2016', 'dd/mm/yyyy');
    tempData=SPYdata(:,1:7);
    SPYdata=[tempData;newContent];
    [logR, stdArr]=getLRnSTD(SPYdata(:,7),daysOfRV);
    SPYdata=[SPYdata,logR,stdArr];


    clear row i j oldN ret tempStd extraN;
end
    %3 things are saved. current Day(date string), rawPrice (str), and tickers
    %(str)
save histData currentDay rawPrice workPrice tickers daysOfRV numOfTickers SPYdata;
