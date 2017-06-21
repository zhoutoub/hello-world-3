% % %UpdateData;
caliStartN=-daysdif(fbusdate(2016,1),currentDay,13);
caliEndN=-daysdif(lbusdate(2016,12),currentDay,13);
avgPxN=3;
avgMoodN=5;
bigR=0.1;

tickerLmdR=findMaxRwLmdSig(workPrice,caliStartN,caliEndN,avgPxN,avgMoodN,bigR);
%tickerLmdR=findMaxRwLmd(rawPrice,caliStartN,caliEndN);
TbLmdR=createTbWTicker(tickerLmdR,rawPrice);
save calibrationSigData TbLmdR caliStartN caliEndN tickerLmdR;

%Below is full calibration
% % startYr=1995;
% % endYr=2016;
% % yrArr=startYr:endYr;
% % m=length(yrArr);
% % fn=cell(1,m);
% % caliResult=struct;
% % for i=1:m
% %    caliStartN= -daysdif(fbusdate(yrArr(i),1),currentDay,13);
% %    caliEndN=-daysdif(lbusdate(yrArr(i),12),currentDay,13);
% %    fn{i}=strcat('Year',num2str(yrArr(i)));
% % caliResult.(fn{i})=findMaxRwLmd2(rawPrice,caliStartN,caliEndN);
% % 
% % end
% % save fullCal caliResult yrArr fn;