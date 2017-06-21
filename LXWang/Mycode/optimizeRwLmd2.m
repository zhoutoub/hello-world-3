function [lmdResult]=optimizeRwLmd2(DatePrice,startI,endI,c,avgPxN,avgMoodN,bigR)
%This funtion optimizes lmd given prices and date range
%DatePrice is an array, first column is date number, 6th column is adj
%close. Others are not used.
%output index: 1 lamda, 2 mood return,3 bh return,4 # of buys,5 mood r/std, 6 bh
%r/std 7 min mood R 8 min BH R 9 c
lmd=0.8:0.01:0.98;
n=length(lmd);
%calcRwLmd2 output has 7 columns
R=ones(n,7);
for i=1:n  
    R(i,:)=calcRwLmd2(lmd(i),DatePrice,startI,endI,c,avgPxN,avgMoodN,bigR);   
end
ind=find(max(R(:,1))==R(:,1),1);
lmd=lmd(ind);
result=R(ind,:);
lmdResult=[lmd,result,c];


    