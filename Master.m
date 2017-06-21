global daysOfRV noStd dateFormat dayRangeL dayRangeH
daysOfRV=10;
noStd=3;
dateFormat='mm-dd-yyyy';
UpdateData;
email;
dayRangeL=150;
dayRangeH=252;
getSp=true;
getRe=true;
% workPrice=appendSupport(workPrice,dayRange);
% scanSupport(workPrice);
% msgbox('Finish!');
%plots support for last x days
workPrice=appendSpRes(workPrice,dayRangeL,dayRangeH);
scanSpRes(workPrice,getSp,getRe);
msgbox('Finish!');
save histData SPYdata currentDay rawPrice workPrice tickers daysOfRV numOfTickers dateFormat dayRangeH dayRangeL noStd;







