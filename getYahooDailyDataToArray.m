function data = getYahooDailyDataToArray(tickers, startDate, endDate, dateFormat)
%this function outputs a matrix instead of a table.works for 1 ticker only
%%1=Date,2=Open,3=High,4=Low,5=Close,6=Volume,7=AdjClose
atable=getYahooDailyData(tickers, startDate, endDate, dateFormat);
%data=table2array(atable.(tickers));

dates=datenum(table2array(atable(:,1)));
pxs=table2array(atable(:,2:end));
data=[dates,pxs];
data=sortrows(data,1);

