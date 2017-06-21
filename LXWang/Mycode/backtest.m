%back test
%This back test uses previous optimization of lamda, and perform trading
%the next period.
load fullCal;
load histData;
N=500; %use the best 30 stocks from previous years
m=length(yrArr);
fn=cell(1,m-1);
btestResult=struct;
[k1,k2]=size(calcRwLmd2(0.95,rawPrice(1).content,-10,-1));
M=length(rawPrice);
NN=min(M,N);
for i=1:m-1 %i is the previous year
   caliStartN= -daysdif(fbusdate(yrArr(i+1),1),currentDay,13);
   caliEndN=-daysdif(lbusdate(yrArr(i+1),12),currentDay,13);
   %fn still previous year
   fn{i}=strcat('Year',num2str(yrArr(i)));
   tempYear=caliResult.(fn{i});
   tempArr=zeros(NN,k2);
   for j=1:NN
        tempArr(j,:)=calcRwLmd2(tempYear(j,2),rawPrice(tempYear(j,1)).content,caliStartN,caliEndN);
   end
   btestResult.(fn{i})=[tempYear(1:NN,:),tempArr];
end
avgAnnualMeanR=ones(2,m-1);
for i=1:m-1
    tempArr=btestResult.(fn{i});
    avgAnnualMeanR(1,i)=mean(tempArr(:,11));
    avgAnnualMeanR(2,i)=mean(tempArr(:,12));
end
figure;
ax1=subplot(2,1,1);
ax2=subplot(2,1,2);
plot(ax1,yrArr(1:m-1),avgAnnualMeanR(1,:));
title(ax1,'mood');
hold on;
plot(ax2,yrArr(1:m-1),avgAnnualMeanR(2,:));
title(ax2,'bnh');