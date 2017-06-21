%This script runs every day, it screens avgmood for last biz day and today,
%if it changes from 0 to 1, then get in.If it changes form 1 to 0, and
%hold=true, then get out.

%first make tickerLmdR into a table and save it
% CollectHistoricalData;
UpdateData;
% calibration;
%load histData;
load calibrationData;
%caliStartN=-daysdif(fbusdate(2016,1),currentDay,13);
%caliEndN=-daysdif(lbusdate(2016,12),currentDay,13);
actStartN=-daysdif(fbusdate(2017,1),currentDay,13);
actEndN=0;
c=0.01;
avgPxN=3;
avgMoodN=5;
bigR=0.1;
%scan top 50 stocks,NCS=Number of Candidate Stocks

NCS=min(500,numOfTickers);
buyCell={};b=1;
outCell={};out=1;
bdate={};sdate={};
for i=1:NCS
    [Ymood,Tmood]=getAvgmood(tickerLmdR(i,2),rawPrice(tickerLmdR(i,1)).content,actStartN,actEndN,c,avgPxN,avgMoodN,bigR);
    if (Ymood<0&&Tmood>0)
        x=['Buy signal for ',rawPrice(tickerLmdR(i,1)).ticker];
        buyCell{b}=rawPrice(tickerLmdR(i,1)).ticker;
        bdate{b}=currentDay;
        b=b+1;
        %disp(x);
    elseif (Ymood>0&&Tmood<0)
        y=['Get out of long position for ',rawPrice(tickerLmdR(i,1)).ticker];
        outCell{out}=rawPrice(tickerLmdR(i,1)).ticker;
        sdate{out}=currentDay;
        out=out+1;
        %disp(y);
    end
end
disp('Displaying new buy signal.');
TbLmdR(buyCell,:)
disp('Displaying new out signal.');
TbLmdR(outCell,:)
xlspath='D:\Softwares\GoogleDrive\Codes\mood.xlsx';

if(~isempty(buyCell))
    buyCellSave=[bdate',buyCell'];
    oldSpt=readtable(xlspath,'Sheet','Sheet1');
    newSpt=appendRow2Table(oldSpt,buyCellSave);
    writetable(newSpt,xlspath,'Sheet','Sheet1');
end
if(~isempty(outCell))
    outCellSave=[sdate',outCell'];
    oldSpt=readtable(xlspath,'Sheet','Sheet2');
    newSpt=appendRow2Table(oldSpt,outCellSave);
    writetable(newSpt,xlspath,'Sheet','Sheet2');
end
%save scanResult buyCell outCell ;