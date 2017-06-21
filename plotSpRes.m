function fig=plotSpRes(workPrice,indexI)
%this function plots the daily OHLC with support

%make sure day range is not bigger than available data size
[days,~]=size(workPrice(indexI).content);
dayRangeL=workPrice(indexI).support(1);
dayRangeL=min(days,dayRangeL);
dayRangeH=workPrice(indexI).resist(1);
dayRangeH=min(days,dayRangeH);

L=workPrice(indexI).content(end-dayRangeL+1:end,:);
H=workPrice(indexI).content(end-dayRangeH+1:end,:);
fig=highlow(L(:,3),L(:,4),L(:,7),L(:,2),'blue',L(:,1),'mm/yy');
hold on;
[m,~]=size(L(:,1));
plot(L(:,1),workPrice(indexI).support(4)*ones(m,1),'r');
%highlow(H(:,3),H(:,4),H(:,7),H(:,2),'red',H(:,1),'mm/yy');
[n,~]=size(H(:,1));
plot(H(:,1),workPrice(indexI).resist(4)*ones(n,1),'g');
hold off;
end