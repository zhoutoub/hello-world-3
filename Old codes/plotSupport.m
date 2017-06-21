function fig=plotSupport(workPrice,indexI)
%this function plots the daily OHLC with support

%make sure day range is not bigger than available data size
[days,~]=size(workPrice(indexI).content);
dayRange=workPrice(indexI).support(1);
dayRange=min(days,dayRange);

b=workPrice(indexI).content(end-dayRange+1:end,:);
fig=highlow(b(:,3),b(:,4),b(:,7),b(:,2),'blue',b(:,1),'mm/yy');
hold on;
[m,~]=size(b(:,1));
plot(b(:,1),workPrice(indexI).support(4)*ones(m,1));
hold off;
end