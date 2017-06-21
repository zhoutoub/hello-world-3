function ind=findTicker(workPrice,ticker)
[~,num]=size(workPrice);
ind=0;
for i=1:num
    if(strcmp(workPrice(i).ticker,ticker))
        ind=i;
    end
end
if ind==0
    disp('no such ticker found.');
end
end