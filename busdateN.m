function dateN=busdateN(date,N)
%this funtion gets the N day before/after the given biz date.
%N=1 means next biz date
dateN=date;
if N>0
    for i=1:N
        dateN=busdate(dateN,1);
    end
else 
     for i=1:-N
         dateN=busdate(dateN,-1);
     end
end
dateN=datenum(dateN);