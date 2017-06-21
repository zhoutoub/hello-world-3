%useful functions
daysdif(start date, end date, 13); %13 for biz days, not including start date
busdays(sdate,edate) %generates a vector of business days between the last 
%business date of the period that contains the start date (sdate), 
%and the last business date of period that contains the end date (edate).
busdate(date,-1),'dd/mmm/yyyy');%busdate. next or previous biz date
busdateN(date,N) %next or previous N biz date
fbusdate(2001, 11);%Determine the first Business Date of a Given Year and Month
lbusdate(2001, 5);%Determine the Last Business Date of a Given Year and Month