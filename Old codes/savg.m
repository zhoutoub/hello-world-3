%1=Date,2=Open,3=High,4=Low,5=Close,6=Volume,7=AdjClose,8=MACD 12 cal,9=MACD 26
%cal, 10=divergence line (12-26), 11=signal line (EMA of col 10)
%avg in percentage,10=rVol, 11=50 avg,
%tickers={'SPY','DXD','QQQ'};
tickers={'SPY'};
rawData=getYahooDailyData(tickers,'01/01/2015','16/03/2016','dd/mm/yyyy');
mydata=table2array(rawData.SPY);
[m n]=size(mydata);
%business days in one year
bizdayperyr=252;
%column of close
clcol=5;
%MACD param
MACDd1=12;MACDd2=26;MACDd3=9;
%for volatility calculation
volfreq=22;

lastcol=11;
mydata(1:end,8:lastcol)=0;
mydata(MACDd1,8)=mean(mydata(1:MACDd1,clcol));
mydata(MACDd2,9)=mean(mydata(1:MACDd2,clcol));
%populate MACD 12
for i=MACDd1+1:m
    mydata(i,8)=mydata(i,clcol)*2/(MACDd1+1)+mydata(i-1,8)*(1-2/(MACDd1+1));
end
%populate MACD 26
for i=MACDd2+1:m
    mydata(i,9)=mydata(i,clcol)*2/(MACDd2+1)+mydata(i-1,9)*(1-2/(MACDd2+1));
end
%populate MACD 9

mydata(:,10)=mydata(:,8)-mydata(:,9);
mydata(1:MACDd2-1,10)=0;
mydata(MACDd3+MACDd2-1,11)=mean(mydata(MACDd2:(MACDd3+MACDd2-1),10));
for i=MACDd3+MACDd2:m
    mydata(i,11)=mydata(i,10)*2/(MACDd3+1)+mydata(i-1,11)*(1-2/(MACDd3+1));
end

% 
% 
% mydata(:,9)=(mydata(:,7)-mydata(:,8))./mydata(:,8)*100;
% 
% t=datetime(datestr(mydata(:,1)),'InputFormat','dd-MMM-yyyy');
% figure('Name','Price');
% plot(t,mydata(:,7),'-r',t,mydata(:,8),'-.b',t,mydata(:,11),'.g','DatetimeTickFormat','dd-MMM-yyyy');
% legend('close','252','50');
% grid on;
% px252=mydata(:,8);
% px50=mydata(:,11);
% pxSL=(px50-px252)./px252;
% figure('Name','Percent');
% plotyy(t,pxSL,t,mydata(:,7));grid on;
