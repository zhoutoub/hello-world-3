function scanSpRes(workPrice,getSp,getRe)
global dateFormat dayRangeL dayRangeH
[~,numOfTickers]=size(workPrice);
currentDay=datestr(busdate(datenum(datetime('today'))+1,-1),dateFormat);
    newSpRows=cell(1,10);
    newRsRows=cell(1,10);
    for i=1:numOfTickers
    sp=workPrice(i).support;
    re=workPrice(i).resist;
    spIndex=find(workPrice(i).content(:,1)==sp(3));
    reIndex=find(workPrice(i).content(:,1)==re(3));
    [m,~]=size(workPrice(i).content);
    lows=workPrice(i).content(:,4);
    highs=workPrice(i).content(:,3);
    %below if statement plots stocks that approach recent support
    if(getSp==true)
        %support happens at least 20 days ago
        if ((m-spIndex)>20)
            if(lows(end)/sp(4)<(1+workPrice(i).content(end-1,9)))
                fig=plotSpRes(workPrice,i);
                title(workPrice(i).ticker); 
                fpath='D:\Softwares\GoogleDrive\Charts\Daily Support\';
                filename=strcat('SP ',datestr(workPrice(i).content(end,1),dateFormat),workPrice(i).ticker);
                newSpRows=[newSpRows;{datestr(currentDay,dateFormat),workPrice(i).ticker,dayRangeL,datestr(sp(3),dateFormat)...
                    ,sp(4),datestr(busdate(sp(2),1),dateFormat),lows(end),round(lows(end)-sp(4),2),round(lows(end)/sp(4)-1,3),round(workPrice(i).content(end-1,9),3)}];
                fullpath=strcat(fpath,filename,'.jpg');
                %saveas(fig,strcat(fpath,filename),'jpeg');
                saveas(fig,fullpath);
                
                
            end
        end
    end
        %below if statement plots stocks that approach recent resistance
    if(getRe==true)
        if ((m-reIndex)>20)
            if(highs(end)/re(4)>(1-workPrice(i).content(end-1,9)))
                fig=plotSpRes(workPrice,i);
                title(workPrice(i).ticker); 
                fpath='D:\Softwares\GoogleDrive\Charts\Daily Resistance\';
                filename=strcat('RS ',datestr(workPrice(i).content(end,1),dateFormat),workPrice(i).ticker);
                fullpath=strcat(fpath,filename,'.jpg');
                newRsRows=[newRsRows;{datestr(currentDay,dateFormat),workPrice(i).ticker,dayRangeH,datestr(re(3),dateFormat)...
                    ,re(4),datestr(busdate(re(2),1),dateFormat),highs(end),round(highs(end)-re(4),2),round(highs(end)/re(4)-1,3),round(workPrice(i).content(end-1,9),3)}];
                saveas(fig,fullpath);
                %sendmail('zekundeng@gmail.com', strcat('Support of ',workPrice(i).ticker), 'chart',fullpath);
            end
        end
    end
    end
    xlspath='D:\Softwares\GoogleDrive\Charts\summary.xlsx';
    newSpRows(1,:)=[];
    newRsRows(1,:)=[];
    if(~isempty(newSpRows))
        oldSpt=readtable(xlspath,'Sheet','Support');
        newSpt=appendRow2Table(oldSpt,newSpRows);
        writetable(newSpt,xlspath,'Sheet','Support');
    end
    if(~isempty(newRsRows))
        oldRst=readtable(xlspath,'Sheet','Resistance');
        newRst=appendRow2Table(oldRst,newRsRows);
        writetable(newRst,xlspath,'Sheet','Resistance');
    end
    sendmail('zekundeng@gmail.com', 'Daily update', 'Daily update',xlspath);
end