function scanSupport(workPrice)
global dateFormat
[~,numOfTickers]=size(workPrice);
    for i=1:numOfTickers
    sp=workPrice(i).support;
    spIndex=find(workPrice(i).content(:,1)==sp(3));
    [m,~]=size(workPrice(i).content);
    lows=workPrice(i).content(:,4);
        if ((m-spIndex)>1)
            if(lows(end)/sp(4)<(1+workPrice(i).content(end-1,9)))
                fig=plotSupport(workPrice,i);
                title(workPrice(i).ticker); 
                fpath='D:\Softwares\GoogleDrive\Charts\Daily Support\';
                filename=strcat(datestr(workPrice(i).content(end,1),dateFormat),workPrice(i).ticker);
                fullpath=strcat(fpath,filename,'.jpg');
                %saveas(fig,strcat(fpath,filename),'jpeg');
                saveas(fig,fullpath);
                
                %sendmail('zekundeng@gmail.com', strcat('Support of ',workPrice(i).ticker), 'chart',fullpath);
            end
        end
    end
end